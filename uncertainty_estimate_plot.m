clear;clc;close all;

load('struct_UQ.mat');
UQ512 = reshape(UQ512,[512,512]);
UQ128 = reshape(UQ128,[512,512]);
UQ64 = reshape(UQ64,[512,512]);
UQ32 = reshape(UQ32,[512,512]);
UQ16 = reshape(UQ16,[512,512]);


cmin = 0;
cmax = 1;

fig1 = figure;

subplot(1,5,1);
imagesc(UQ512);
colormap(jet);
caxis([cmin,cmax]);


xticklabels=0:50:100;
xticks = linspace(1,512,numel(xticklabels));
yticklabels=100:-50:0;
yticks = linspace(1,512,numel(yticklabels));
set(gca,'XTick',xticks,'XTickLabel',xticklabels);
set(gca,'YTick',yticks,'YTickLabel',yticklabels);
ax=gca;
ax.FontSize=15;



subplot(1,5,2);
imagesc(UQ128);
colormap(jet);
caxis([cmin,cmax]);

set(gca,'XTick',xticks,'XTickLabel',xticklabels);
set(gca,'YTick',yticks,'YTickLabel',yticklabels);
ax=gca;
ax.FontSize=15;


subplot(1,5,3);
imagesc(UQ64);
colormap(jet);
caxis([cmin,cmax]);

set(gca,'XTick',xticks,'XTickLabel',xticklabels);
set(gca,'YTick',yticks,'YTickLabel',yticklabels);
ax=gca;
ax.FontSize=15;



subplot(1,5,4);
imagesc(UQ32);
colormap(jet);
caxis([cmin,cmax]);

set(gca,'XTick',xticks,'XTickLabel',xticklabels);
set(gca,'YTick',yticks,'YTickLabel',yticklabels);
ax=gca;
ax.FontSize=15;



subplot(1,5,5);
imagesc(UQ16);
colormap(jet);
caxis([cmin,cmax]);
% colorbar;

set(gca,'XTick',xticks,'XTickLabel',xticklabels);
set(gca,'YTick',yticks,'YTickLabel',yticklabels);
ax=gca;
ax.FontSize=15;


set(gcf, 'Position', [500 50 1500 235]);
set(gcf,'Color','w');

mystyle = hgexport('factorystyle');
mystyle.Format = 'png';
mystyle.Resolution = 1000;

hgexport(fig1,'struct_UQ.png',mystyle);