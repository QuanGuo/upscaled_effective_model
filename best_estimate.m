clear;clc;close all;

load('struct_result512.mat')
b = op_chain.b;
s = ones(Rox0*Roy0,1) * b(end) + V0 * b(1:end-1);
s = reshape(s,[512,512]);


load('struct_result512to128.mat')
b = op_chain.b;
s1 = ones(Rox0*Roy0,1) * b(end) + V0 * b(1:end-1);
s1 = reshape(s1,[512,512]);


load('struct_result512to64.mat')
b = op_chain.b;
s2 = ones(Rox0*Roy0,1) * b(end) + V0 * b(1:end-1);
s2 = reshape(s2,[512,512]);


load('struct_result512to32.mat')
b = op_chain.b;
s3 = ones(Rox0*Roy0,1) * b(end) + V0 * b(1:end-1);
s3 = reshape(s3,[512,512]);


load('struct_result512to16.mat')
b = op_chain.b;
s4 = ones(Rox0*Roy0,1) * b(end) + V0 * b(1:end-1);
s4 = reshape(s4,[512,512]);


% [ny,nx]=size(logK);
% yloc=nx/4+1:nx/8:nx*3/4+1;
% xloc=ny/4+1:ny/8:ny*3/4+1; % 25 points
% [X,Y]=meshgrid(xloc,yloc);
% X=X(:);
% Y=Y(:);
fig1 = figure;

my_color=jet(20);

cmin = -4;
cmax = -1.5;

subplot(1,5,1);
imagesc(s);
colormap(my_color);
caxis([cmin,cmax]);

xticklabels=0:50:100;
xticks = linspace(1,512,numel(xticklabels));
yticklabels=100:-50:0;
yticks = linspace(1,512,numel(yticklabels));
set(gca,'XTick',xticks,'XTickLabel',xticklabels);
set(gca,'YTick',yticks,'YTickLabel',yticklabels);
ax=gca;
ax.FontSize=15;
% title('True Field');
% xlabel('x');
% ylabel('y');


subplot(1,5,2);
imagesc(s1);
colormap(my_color);
caxis([cmin,cmax]);


set(gca,'XTick',xticks,'XTickLabel',xticklabels);
set(gca,'YTick',yticks,'YTickLabel',yticklabels);
ax=gca;
ax.FontSize=15;
% title({'Method 1 (without Upscaling)','A-1'});
% xlabel('x');
% ylabel('y');
% font size and figure size


subplot(1,5,3);
imagesc(s2);
colormap(my_color);
caxis([cmin,cmax]);

set(gca,'XTick',xticks,'XTickLabel',xticklabels);
set(gca,'YTick',yticks,'YTickLabel',yticklabels);
ax=gca;
ax.FontSize=15;
% title('B-1');
% xlabel('x');
% ylabel('y');


subplot(1,5,4);
imagesc(s3);
colormap(my_color);
caxis([cmin,cmax]);

set(gca,'XTick',xticks,'XTickLabel',xticklabels);
set(gca,'YTick',yticks,'YTickLabel',yticklabels);
ax=gca;
ax.FontSize=15;
% title({'Method 2 (with Upscaling)','A-2'});
% xlabel('x');
% ylabel('y');
% font size and figure size


subplot(1,5,5);
imagesc(s4);
colormap(my_color);
caxis([cmin,cmax]);
colorbar;

set(gca,'XTick',xticks,'XTickLabel',xticklabels);
set(gca,'YTick',yticks,'YTickLabel',yticklabels);
ax=gca;
ax.FontSize=15;

set(gcf, 'Position', [500 50 1500 235]);
set(gcf,'Color','w');


mystyle = hgexport('factorystyle');
mystyle.Format = 'png';
mystyle.Resolution = 1000;

hgexport(fig1,'colorbar.png',mystyle);