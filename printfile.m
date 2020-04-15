
fid=fopen('D8_density.txt','wt');      %新建一个txt文件  

for k=0:35
    phns = ['density_D8-',num2str(90-k*5),num2str(85-k*5),'.txt'];                %要读取的文档所在的路径
    
    fpn = fopen (phns, 'rt');           %打开文档
    
    while feof(fpn) ~= 1                %用于判断文件指针p在其所指的文件中的位置，如果到文件末，函数返回1，否则返回0
        
        file = fgetl(fpn);            %获取文档第一行
        
        %%%
        
        new_str=file;                %中间这部分是对读取的字符串file进行任意处理
        
        %%%
        
        fprintf(fid,'%s\n',new_str);%新的字符串写入当新建的txt文档中
        
    end
end
fclose(fid);  

 
