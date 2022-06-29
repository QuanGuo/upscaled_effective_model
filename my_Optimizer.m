function [ chain_vars ] = my_Optimizer( chain_vars )
% read data
X = chain_vars.X;
b = chain_vars.b;
V=chain_vars.V;
lambda=chain_vars.lambda;
Lox=chain_vars.Lox;
Loy=chain_vars.Loy;
Rox=chain_vars.Rox;
Roy=chain_vars.Roy;
y=chain_vars.y; % data
fr=chain_vars.fr;

k = length(b)-1;
ynorm = chain_vars.ynorm;


eps=1e-8;

% optimization
s=X*b(end)+V*b(1:end-1);
yp=tomography(Lox,Loy,s,Rox,Roy)/ynorm;
fr=fr+1;

chain_vars.yp=yp;
chain_vars.resd=chain_vars.resd+mean((y-yp).^2);

Obj_Old = 1/2*(y-yp)'*(y-yp)/lambda + 1/2*b(1:end-1)'*b(1:end-1);

% compute Jacobian matrix
J=zeros(length(y),k+1);
for ii=1:k+1

    b(ii) = b(ii) + eps;
    
    y1=tomography(Lox,Loy,X*b(end)+V*b(1:end-1),Rox,Roy)/ynorm;

    J(:,ii)=(y1-yp)/eps;
    
    b(ii) = b(ii) - eps;
    
end

fr=fr+k+1;

Damp = diag([ones(k,1);0]);
H = J'*J/lambda + Damp; % approximated Hessian

% calculate the linear correction term
Hs = J*b;

RHS = J'*(y - yp + Hs)/lambda;

bN = H\RHS; % update all the unknown parameters

% calculate the objective function
s=X*bN(end)+V*bN(1:end-1);
yp_obj=tomography(Lox,Loy,s,Rox,Roy)/ynorm;fr=fr+1; % only used for obj evaluations.

Obj = 1/2*(y-yp_obj)'*(y-yp_obj)/lambda + 1/2*bN(1:end-1)'*bN(1:end-1);

if Obj < Obj_Old
    chain_vars.b=bN;
else
    Obj = Obj_Old;
end

% number of forward runs
chain_vars.fr=fr;

% convergence
chain_vars.convR = Obj_Old/Obj-1;
chain_vars.H = H(1:50,1:50);

end

