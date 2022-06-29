function [ logK ] = log_K( Lox,Loy,Rox,Roy )

% sigma2=2.5;
% l=20;
sigma2 = 0.5;
l = 20;

dx=Lox/Rox;
dy=Loy/Roy;

[X,Y]=meshgrid((-Lox/2+dx/2):dx:(Lox/2-dx/2),(-Loy/2+dy/2):dy:(Loy/2-dy/2));

D=sqrt((X).^2+(2*Y).^2);
% D=sqrt((X).^2+(Y).^2);
RYY = sigma2*exp(-D/l);

SYY=fftn(fftshift(RYY))/Rox/Roy;
SYY=abs(SYY);
SYY(1,1)=0;

logK=sqrt(SYY).*exp(1i*angle(fftn(normrnd(0,1,[Roy,Rox]))));

% logK=real(ifftn(logK*Rox*Roy))-1.76; 
logK=real(ifftn(logK*Rox*Roy))-5;

end

