clear;clc;close all;

load('struct_result512.mat')
b = op_chain.b;
s = ones(Rox0*Roy0,1) * b(end) + V0 * b(1:end-1);
s = reshape(s,[512,512]);

yp = tomography(Lox,Loy,s,Rox,Roy);

corrcoef(y,yp)


load('struct_result512to128.mat')
b = op_chain.b;
s1 = ones(Rox0*Roy0,1) * b(end) + V0 * b(1:end-1);
s1 = reshape(s1,[512,512]);

yp1 = tomography(Lox,Loy,s1,Rox0,Roy0);

corrcoef(y,yp1)

load('struct_result512to64.mat')
b = op_chain.b;
s2 = ones(Rox0*Roy0,1) * b(end) + V0 * b(1:end-1);
s2 = reshape(s2,[512,512]);

yp2 = tomography(Lox,Loy,s2,Rox0,Roy0);

corrcoef(y,yp2)

load('struct_result512to32.mat')
b = op_chain.b;
s3 = ones(Rox0*Roy0,1) * b(end) + V0 * b(1:end-1);
s3 = reshape(s3,[512,512]);

yp3 = tomography(Lox,Loy,s3,Rox0,Roy0);

corrcoef(y,yp3)

load('struct_result512to16.mat')
b = op_chain.b;
s4 = ones(Rox0*Roy0,1) * b(end) + V0 * b(1:end-1);
s4 = reshape(s4,[512,512]);

yp4 = tomography(Lox,Loy,s4,Rox0,Roy0);

corrcoef(y,yp4)

fig1 = figure;


subplot(1,5,1);
plot(y,y,'-k','linewidth',1.25);hold on;
plot(y,yp,'.r','markersize',10);
hold off;
xlim([min(y),max(y)]);
ylim([min(y),max(y)]);

subplot(1,5,2);
plot(y,y,'-k','linewidth',1.25);hold on;
plot(y,yp1,'.r','markersize',10);
hold off;
xlim([min(y),max(y)]);
ylim([min(y),max(y)]);

subplot(1,5,3);
plot(y,y,'-k','linewidth',1.25);hold on;
plot(y,yp2,'.r','markersize',10);
hold off;
xlim([min(y),max(y)]);
ylim([min(y),max(y)]);

subplot(1,5,4);
plot(y,y,'-k','linewidth',1.25);hold on;
plot(y,yp3,'.r','markersize',10);
hold off;
xlim([min(y),max(y)]);
ylim([min(y),max(y)]);

subplot(1,5,5);
plot(y,y,'-k','linewidth',1.25);hold on;
plot(y,yp4,'.r','markersize',10);
hold off;
xlim([min(y),max(y)]);
ylim([min(y),max(y)]);


set(gcf, 'Position', [500 50 1500 235]);
set(gcf,'Color','w');


mystyle = hgexport('factorystyle');
mystyle.Format = 'png';
mystyle.Resolution = 1000;

hgexport(fig1,'measurement_reproduction1.png',mystyle);