clc;
clear;
%R=6371000;
R=1738000;%Average radius of the Earth, unit: m
G=6.67*1.0e-11;  %gravitational constant
% %observations at R=6371000
gcp=load('D8.txt');  %gravity anomaly and coordinates at computing points
gcp(:,4)=R; %altitude at computing points, unit: m

for k=0:35
    locp=gcp(1441*(1+k*20):1441*(21+k*20),1)*pi/180;          % longitude    ,unit: rad
    lacp=gcp(1441*(1+k*20):1441*(21+k*20),2)*pi/180;          % latitude  ,unit: rad
    hcp=gcp(1441*(1+k*20):1441*(21+k*20),4);           % distence from geocenter   ,unit: m
    L=gcp(1441*(1+k*20):1441*(21+k*20),3)*1.0e-5; % gravity anomaly at computing points unit: m/s^2
    % %积分点 位置参数
    minlon=-180*pi/180;    %longitude at integrated points, unit: rad
    maxlon=180*pi/180;
    minlat=(-90+5*k)*pi/180;     %latitude at integrated points, unit: rad
    maxlat=(-85+5*k)*pi/180;
    r1=R-332000;          %depths of integrated points, unit: m
    r2=R-468000;
    dr=r1-r2;             %thickness of integrated points, unit: m
    dlon=0.5*pi/180;      %interval of tesseroids
    dlat=0.5*pi/180;
    n=round((maxlat-minlat)/dlat);
    m=round((maxlon-minlon)/dlon);
    for i=1:n+1
        for j=1:m+1
            lonip(i,j)=minlon+(j-1)*dlon;
            latip(i,j)=minlat+(i-1)*dlat;
        end;
    end;
    
    for i=1:n
        for j=1:m
            lamda0_grid(i,j)=lonip(i,j)+dlon/2;
            fai0_grid(i,j)=latip(i,j)+dlat/2;
            r0_grid(i,j)=(r1+r2)/2;
        end
    end
    % surf(lamda0,fai0,r0);
    lamda0=reshape(lamda0_grid,m*n,1);
    fai0=reshape(fai0_grid,m*n,1);
    r0=reshape(r0_grid,m*n,1);
    point_mass=zeros(m*n,3);
    point_mass(:,1)=lamda0*180.0/pi;     %longitude at integrated points, unit: degree
    point_mass(:,2)=fai0*180.0/pi;     %latitude at integrated points, unit: degree
    point_mass(:,3)=r0;
    
    B=zeros(length(locp),m*n);
    for i=1:length(locp)
        r=hcp(i);
        lamda=locp(i);
        fai=lacp(i);
        for j=1:m*n
            [ L000,L200,L020,L002 ] = tesseroid1( r,fai,lamda,r0(j),fai0(j),lamda0(j) );
            B(i,j)=G*dr*dlat*dlon*(L000+1/24.0*(L200*dr^2+L020*dlat^2+L002*dlon^2));
        end
        i
    end
    save ('B.mat','B');
    save ('point_mass.mat','point_mass');
    save ('L.mat','L');
    [ x ] = inverse( ['density_D8-',num2str(90-k*5),num2str(85-k*5),'.txt'],B,L,point_mass );
end












