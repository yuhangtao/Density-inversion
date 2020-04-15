function []=display1(x)
% X=x(:,1);
% Y=x(:,2);
% Z=x(:,3);
% xx=linspace(min(X),max(X),179);
% yy=linspace(min(Y),max(Y),179);
% [xt,yt]=meshgrid(xx,yy);
% zt=griddata(X,Y,Z,xt,yt,'v4');
% contourf(xt,yt,zt)
% colorbar
X=reshape(x(:,3),720,360)';
imagesc(X)
set(gca,'XTick',-180:0.25:180)
set(gca,'YTick',-90:0.25:90)
%set(gca,'XTick',[])
%set(gca,'YTick',[])
colorbar()