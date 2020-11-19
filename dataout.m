function []=dataout(filein,fileout,minlon,maxlon,minlat,maxlat)
fidin=fopen(filein,'rt');
fidout=fopen(fileout,'wt');

while ~feof(fidin)
    tline=fgetl(fidin);
    s=strsplit(tline);
    lon=str2double(s(1));
    lat=str2double(s(2));
    if lon<=maxlon && lon>=minlon && lat<=maxlat && lat>=minlat
        fprintf(fidout,'%s\n',tline); 
    end
end

fclose(fidin);
fclose(fidout); 