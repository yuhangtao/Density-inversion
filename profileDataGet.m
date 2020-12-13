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
%     Bjmax=ceil(B(i,1)*4)/4;
%     Bwmax=ceil(B(i,2)*4)/4;
%     Bjmin=floor(B(i,1)*4)/4;
%     Bwmin=floor(B(i,2)*4)/4;
    B(i,3)=0;
    s=0;
%     c=zeros(4,3);
%     c(1,1)=Bjmax;
%     c(1,2)=Bwmax;
%     c(2,1)=Bjmin;
%     c(2,2)=Bwmax;
%     c(3,1)=Bjmin;
%     c(3,2)=Bwmin;
%     c(4,1)=Bjmax;
%     c(4,2)=Bwmin;
%     
%     
%     for j=1:length(A(:,1))
%         if Bjmax==A(j,1) && Bwmax==A(j,2)
%             c(1,3)=A(j,3);
%         elseif Bjmin==A(j,1) && Bwmax==A(j,2)
%             c(2,3)=A(j,3);
%         elseif Bjmin==A(j,1) && Bwmin==A(j,2)
%             c(3,3)=A(j,3);
%         elseif Bjmax==A(j,1) && Bwmin==A(j,2)
%             c(4,3)=A(j,3);
%         end
%     end

    for j=1:length(A(:,1))
        if B(i,1)==A(j,1) && B(i,2)==A(j,2)
            break;
        else        
            s=s+1/sqrt(power(A(j,1)-B(i,1),2)+power(A(j,2)-B(i,2),2));     
        end
    end
    
    for j=1:length(A(:,1))
        if B(i,1)==A(j,1) && B(i,2)==A(j,2)
            B(i,3)=A(j,3);
            break;
        else        
            B(i,3)=B(i,3)+(1/sqrt(power(A(j,1)-B(i,1),2)+power(A(j,2)-B(i,2),2)))/s*A(j,3);     
        end
    end
%     for k=1:4
%                 B(i,3)=B(i,3)+(1/sqrt(power(c(k,1)-B(i,1),2)+power(c(k,2)-B(i,2),2)))/s*c(k,3);
%             end
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

