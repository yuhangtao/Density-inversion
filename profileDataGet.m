function []=profileDataGet(filein,fileout,minlon,maxlon,minlat,maxlat)
A=load(filein);
fidout=fopen(fileout,'wt');

n=50;
B=zeros(n,3);
slon=(maxlon-minlon)/n;
slat=(maxlat-minlat)/n;
for i=1:n+1
    B(i,1)=minlon+(i-1)*slon;
    B(i,2)=minlat+(i-1)*slat;
    B(i,3)=0;
    for j=1:length(A(:,1))
        if B(i,1)==A(j,1) && B(i,2)==A(j,2)
            B(i,3)=A(j,3);
            break;
        else
            s=sqrt(power(A(j,1)-B(i,1),2)+power(A(j,2)-B(i,2),2));
            B(i,3)=B(i,3)+1/s*A(i,3);
        end
    end
end
for i=1:length(B(:,1))
    fprintf(fidout,'%.2f %.2f %d\n',B(i,1),B(i,2),B(i,3));
end

% while ~feof(fidin)
%     tline=fgetl(fidin);
%     s=strsplit(tline);
%     lon=str2double(s(1));
%     lat=str2double(s(2));
%     if lon<=maxlon && lon>=minlon && lat<=maxlat && lat>=minlat
%         k=(maxlat-minlat)/(maxlon-minlon);
%         k2=(lat-minlat)/(lon-minlon);
%         if k==k2 || (lat==minlat && lon==minlon)
%             fprintf(fidout,'%s\n',tline); 
%         end
%     end
% end

fclose(fidout);  

