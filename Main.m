clear;close all;

% % generate synthetic random field

Lox=100; % domain size
Loy=100;

Rox=256; % Resolution
Roy=256;

logK = log_K(Lox,Loy,Rox,Roy); % function to generate lnK field

% % generate synthetic head data
y0=tomography(Lox,Loy,logK,Rox,Roy); % -- use forward model to generate head data
n=length(y0);

y=y0+0.02*normrnd(0,abs(y0)); % add random errors
y=y+0.01*mvnrnd(zeros(n,1),eye(n))';


% PCA to reduce parmeter dimension, use KPCA
NR=400;

 % generate random field for kernel matrix
for ii=1:NR
    new=log_K(Lox,Loy,Rox,Roy);
    ucr(:,ii)=new(:);
end
beta = mean(ucr(:));
mu=beta*ones(Rox*Roy,1);
MU=repmat(mu,1,NR);

K=(ucr-MU)'*(ucr-MU); % -- find kernel matrix

[V,D]=eig(K);
[D,indices]=sort(diag(D/NR),'descend');
V=V(:,indices);
V=(ucr-MU)*V; % --compute principal component 

clear MU;
clear ucr;

k=50; % define k - number of retained principal components % 50 for struct field
D=D(1:k);
V=V(:,1:k);

for ii=1:k
    V(:,ii)=V(:,ii)./norm(V(:,ii));
end

% reduced prior distribution
siga=sqrt(D(1:k));
V=V*diag(siga);

% load PCAdata512_1.mat; % -- load pre-process data (reduced data)

Rox0 = Rox;
Roy0 = Roy;
Rox = 32; Roy = 32; % -- the upscaled resolution
V0 = V;
U = Umat(Rox0,Roy0,Rox,Roy); % -- upscaling matrix
V = U*V;

X = ones(Rox*Roy,1);

% initialize chain variables
chain_vars=struct('V',V,'y',y/norm(y),'Lox',Lox,'Loy',Loy,...
    'Rox',Rox,'Roy',Roy,'ynorm',norm(y),'convR',1,...
    'b',[],'X',X,'resd',0,'lambda',0.01,'fr',0,'iter',[],'H',[]); 
chain_stat=struct('iter_2_conv',[],'t_2_conv',[],'fr_2_conv',[],...
    'sum_t',[],'t_per_iter',[],'conv_curv',[]);

% initialization
op_chain=chain_vars;
op_chain.b=[zeros(k,1);beta];

% optimization routine
iter=0;

while op_chain.convR > 0.0001 % convergence rule
     
    iter=iter+1;
    
    tic
    
    if rem(iter,3)==0
        op_chain.lambda=max(op_chain.resd/iter,5e-5);
%         op_chain.lambda = op_chain.resd/iter; % lamba can be adjusted
%         iteratively
    end

    op_chain.iter=iter;        
    op_chain=my_Optimizer(op_chain); 
    
    chain_stat.t_per_iter=[chain_stat.t_per_iter;toc];   
    
    disp(['Iteration ' num2str(iter) ', convergence: ' num2str(op_chain.convR)]);
    
end
chain_stat.iter_2_conv=iter;
chain_stat.t_2_conv=sum(chain_stat.t_per_iter);


