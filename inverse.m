function [ x ] = inverse( fileout,B,L,point_mass )
%INVERSE Summary of this function goes here
%   Detailed explanation goes here
% L=(gi_0km(:,5)+Ac0(3))*1.0e-5;


NBB=B'*B;
W=B'*L;
pointnum=10;
% curve_x=zeros(pointnum,1);
% curve_y=zeros(pointnum,1);

i=1;
st=1.0e-13;
gap=1.0e-13;

ed=st+pointnum*gap-gap;
m=size(NBB,1);
% num =[-13:0.5:-5];
% alpha = 10.^(num);
% anum = length(alpha);
% residual=zeros(pointnum,1);
for k=st:gap:ed
% for p = 1:anum
%     k = alpha(p);
    x=(NBB+k*eye(m))\W;
    res=B*x-L;
    norm1=norm(x);
    norm2=norm(res);
    curve_x(i)=norm2;
    curve_y(i)=norm1;
    i
    i=i+1;    
end;
% 
% a=log(curve_x);
% b=log(curve_y);
a=curve_x;
b=curve_y;


%--------------------------------------------------------------------------
% a1=diff(a);
% b1=diff(b);
% a2=diff(a,2);
% b2=diff(b,2);
% 
% num=size(a,1);
% 
% curveture1=(b1(1:num-2).*a2-b2.*a1(1:num-2))./(a1(1:num-2).^2+b1(1:num-2).^2).^(3/2);
%--------------------------------------------------------------------------

% num=size(a,1);
num=length(a);
a1=zeros(num-2,1);
b1=zeros(num-2,1);
% rep1=zeros(num-2,1);
a2=zeros(num-4,1);
b2=zeros(num-4,1);
for i=1:num-2
    a1(i)=(a(i+2)-a(i))/2;
    b1(i)=(b(i+2)-b(i))/2;
end;
% for i=1:num-2
%     rep1(i)=(rep(i+2)-rep(i));
%     a1(i)=(a(i+2)-a(i))/rep1(i);
%     b1(i)=(b(i+2)-b(i))/rep1(i);
% end;
for i=1:num-4
    a2(i)=(a1(i+2)-a1(i))/2;
    b2(i)=(b1(i+2)-b1(i))/2;
end;

% for i=1:num-4
%     a2(i)=(a1(i+2)-a1(i))/rep1(i);
%     b2(i)=(b1(i+2)-b1(i))/rep1(i);
% end;

curveture=zeros(num,1);

% for i=1:num-4
%     curveture(i+2)=(b1(i+1).*a2(i)-b2(i).*a1(i+1))./(a1(i+1).^2+b1(i+1).^2).^(3/2);
% end;


for i=1:num-4
    curveture(i+2)=abs(b1(i+1)*a2(i)-b2(i)*a1(i+1))/(a1(i+1)^2+b1(i+1)^2)^(3/2);
end;

[max_curve,pos_curve]=max(curveture);
% k1 = alpha(pos_curve+1);
k1=gap*pos_curve+st-gap;
% k1=0;
x=(NBB+k1*eye(m))\W;
res=B*x-L;
    norm1=norm(x);
    norm2=norm(res);
    curve_x1=norm2;
    curve_y1=norm1;
% a1=log(curve_x1);
% b1=log(curve_y1);
a1=curve_x1;
b1=curve_y1;
% 
num2=size(x,1);
fid0=fopen('regular.txt','w');
fprintf(fid0,'%42.40f %42.38f %42.38f\n',a1,b1,k1);
for i=1:length(a)
    fprintf(fid0,'%42.40f %42.38f %42.38f\n',a(i),b(i),curveture(i));
end
fclose(fid0);

fid=fopen(fileout,'w');
for i=1:num2
    fprintf(fid,'%f %f %f %f',point_mass(i,1),point_mass(i,2),point_mass(i,3),x(i));
    fprintf(fid,'\r\n');
end;
fclose(fid);

end

