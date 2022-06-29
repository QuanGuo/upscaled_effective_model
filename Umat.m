function [U] = Umat(rox_1,roy_1,rox_2,roy_2)
%UMAT returns an upscaling matrix.

% 1 for fine resolution, 2 for coarse resolution.

uf=[rox_1;roy_1]./[rox_2;roy_2]; % upscaling factor (vector form)

count=1;
cindx=[];
rindx=[];
v=[];
for jj_2=1:rox_2 % column index in r_2
    
    for ii_2=1:roy_2 % row index in r_2

        ii_1=((ii_2-1)*uf(2)+1:ii_2*uf(2))'; % row index in r_1
        jj_1=((jj_2-1)*uf(1)+1:jj_2*uf(1))'; % column index in r_1
        
        [ii_1,jj_1]=meshgrid(ii_1,jj_1);
        
        cindx=[cindx;ii_1(:)+(jj_1(:)-1)*roy_1];
        rindx=[rindx;count*ones(prod(uf),1)];
        v=[v;1/prod(uf)*ones(prod(uf),1)];
        
        count=count+1;
    end
end
U=sparse(rindx,cindx,v,rox_2*roy_2,rox_1*roy_1);

end

