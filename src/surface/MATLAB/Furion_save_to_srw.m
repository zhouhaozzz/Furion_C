function  Furion_save_to_srw( meri,sag,data,address)
%将面型数据保存为SRW格式，让srw软件可以导入数据
               x=sag;   %x为列向量
               y=meri;   % y为列向量
                fid=fopen(address,'wt');%打开一个文件
                fprintf(fid,'%g\t',0);
                for i=1:length(x)-1
                    fprintf(fid,'%g\t ',x(i));
                end
                fprintf(fid,'%g\n',x(end));  % 显示子午坐标；

                data2 = [y data]; % 将弧矢坐标绑定到子午坐标上；
                [m,n] = size(data2);
                for i = 1:m
                    for j = 1:n  
                      if j == n
                        fprintf(fid,'%g\n',data2(i,j));
                      else
                        fprintf(fid,'%g\t',data2(i,j));
                      end
                    end
                end
                fclose(fid);
end

