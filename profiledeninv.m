clc;
clear;
G=6.67*1.0e-11;
gcp=load('test.txt');
locp=gcp(:,1)*pi/180;
lacp=gcp(:,2)*pi/180;
depth=[0;-20000;-40000;-60000;-80000;-100000;-120000];

L=gcp(:,3)*1.0e-5;

alon=15;  
blon=18;
alat=15;   
blat=18;

dlon=0.25;      %interval
dlat=0.25;
ddepth=-20000;
ddistance=sqrt(dlon*dlon+dlat*dlat)*30000;

m=round((blat-alat)/dlat);
n=length(depth)-1;

for i=1:n+1
    for j=1:m+1
        x(i,j)=(j-1)*ddistance;
        y(i,j)=(i-1)*ddepth-0.1;
    end;
end;

for i=1:n
    for j=1:m
        x2d(i,j)=x(i,j)+ddistance/2;
        y2d(i,j)=y(i,j)+ddepth/2;
    end
end

x2d=reshape(x2d,m*n,1); %输出横坐标
y2d=reshape(y2d,m*n,1); %输出纵坐标

% K=zero(n,m);
% for i=1:n
%     for j=1:m
%         K=
%     end
% end
% 
% K=reshape(K,m*n,1);
%K=(x(x1,y1+1)*y(x1,y1)-x(x1,y1)*y(x1,y1+1))/(power(y(x1,y1)-y(x1,y1+1),2)+power(x(x1,y1)-x(x1,y1+1),2))*((x(x1,y1)-x(x1,y1+1))*(atan2(y(x1,y1+1),x(x1,y1+1)-x)-atan2(y(x1,y1),x(x1,y1)-x))+1/2*(y(x1,y1)-y(x1,y1+1))*log((power(x(x1,y1)-x,2)+power(y(x1,y1),2))/(power(x(x1,y1+1)-x,2)+power(y(x1,y1+1),2)))

B=zeros(length(locp),m*n);

for i=1:length(locp)
     X=x(1,i);
     for j=1:m*n
         if mod(j,m)==0
             y1=m;
             x1=floor(j/m);
         else
             y1=mod(j,m);
             x1=floor(j/m)+1;
         end
         B(i,j)=2*G*(((x(x1,y1)*y(x1+1,y1)-x(x1+1,y1)*y(x1,y1))/(power(y(x1+1,y1)-y(x1,y1),2)+power(x(x1+1,y1)-x(x1,y1),2))*((x(x1+1,y1)-x(x1,y1))*(atan2(y(x1,y1),x(x1,y1)-X)-atan2(y(x1+1,y1),x(x1+1,y1)-X))+1/2*(y(x1+1,y1)-y(x1,y1))*log((power(x(x1+1,y1)-X,2)+power(y(x1+1,y1),2))/(power(x(x1,y1)-X,2)+power(y(x1,y1),2)))))+...
             ((x(x1+1,y1)*y(x1+1,y1+1)-x(x1+1,y1+1)*y(x1+1,y1))/(power(y(x1+1,y1+1)-y(x1+1,y1),2)+power(x(x1+1,y1+1)-x(x1+1,y1),2))*((x(x1+1,y1+1)-x(x1+1,y1))*(atan2(y(x1+1,y1),x(x1+1,y1)-X)-atan2(y(x1+1,y1+1),x(x1+1,y1+1)-X))+1/2*(y(x1+1,y1+1)-y(x1+1,y1))*log((power(x(x1+1,y1+1)-X,2)+power(y(x1+1,y1+1),2))/(power(x(x1+1,y1)-X,2)+power(y(x1+1,y1),2)))))+...
             ((x(x1+1,y1+1)*y(x1,y1+1)-x(x1,y1+1)*y(x1+1,y1+1))/(power(y(x1,y1+1)-y(x1+1,y1+1),2)+power(x(x1,y1+1)-x(x1+1,y1+1),2))*((x(x1,y1+1)-x(x1+1,y1+1))*(atan2(y(x1+1,y1+1),x(x1+1,y1+1)-X)-atan2(y(x1,y1+1),x(x1,y1+1)-X))+1/2*(y(x1,y1+1)-y(x1+1,y1+1))*log((power(x(x1,y1+1)-X,2)+power(y(x1,y1+1),2))/(power(x(x1+1,y1+1)-X,2)+power(y(x1+1,y1+1),2)))))+...
             ((x(x1,y1+1)*y(x1,y1)-x(x1,y1)*y(x1,y1+1))/(power(y(x1,y1)-y(x1,y1+1),2)+power(x(x1,y1)-x(x1,y1+1),2))*((x(x1,y1)-x(x1,y1+1))*(atan2(y(x1,y1+1),x(x1,y1+1)-X)-atan2(y(x1,y1),x(x1,y1)-X))+1/2*(y(x1,y1)-y(x1,y1+1))*log((power(x(x1,y1)-X,2)+power(y(x1,y1),2))/(power(x(x1,y1+1)-X,2)+power(y(x1,y1+1),2))))));
     end
end

point_mass=zeros(m*n,2);
point_mass(:,1)=x2d;    
point_mass(:,2)=y2d; 

save ('B.mat','B');
save ('point_mass.mat','point_mass');
save ('L.mat','L');
[ x ] = inverse('profile_density.txt',B,L,point_mass );

