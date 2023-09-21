function Furion_save_to_shadow( meri,sag,data,address )
%FURION_SAVE_TO_SHADOW 此处显示有关此函数的摘要
%   此处显示详细说明

            fid=fopen(address,'wt');
            x = meri';%子午坐标 列向量
            y = sag;%弧失坐标 列向量
            fprintf(fid,'%g ',length(y));
            fprintf(fid,'%g\n',length(x));% 显示行和列数字 第一行；

           for i=1:length(x)-1
             fprintf(fid,'%g ',x(i));
           end
           fprintf(fid,'%g\n',x(end));  % 显示子午坐标； 换行 
           
           data2 = [y data]; % 将弧矢坐标绑定到子午坐标上；
             [m,n] = size(data2);
                for i = 1:m
                    for j = 1:n  
                      if j == n
                        fprintf(fid,'%g\n',data2(i,j));
                      else
                        fprintf(fid,'%g  ',data2(i,j));
                      end
                    end
                end
           fclose(fid);
        end



