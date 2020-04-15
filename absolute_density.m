clc;
clear;
x=load('D8_density.txt');
fid=fopen('400km_density.txt','w');
for i=1:length(x(:,1))
    abs_den(i)=x(i,4)/1000+2.55;
    fprintf(fid,'%f %f %f\n',x(i,1),x(i,2),abs_den(i));
end
fclose(fid);