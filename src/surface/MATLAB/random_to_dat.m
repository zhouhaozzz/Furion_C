classdef random_to_dat<handle  
     properties 
         meri;%子午方向
         V;%面型误差数据
         name;%文件名
     end
     
     methods
             function  obj = random_to_dat(h_Error_rms,s_Error_rms,n_Upper,name) %导入一维面型数据，即2列，格式是CSV 适用于Furion 和 SRW 的一维情况
                   [l_Mirro,f_Error,~] = Furion_figure_error(h_Error_rms,s_Error_rms,n_Upper);              %导入原始数据，格式是CSV
                    obj.meri = l_Mirro';
                    obj.V = f_Error';
                    obj.name = name;                    
             end
     end  
     
     methods%%保存成.dat格式，可以给Furion 和srw 使用
         function save_to_furion_and_srw_1d(obj)
             data = [obj.meri,obj.V];
                   [m,n] = size(data);                              %得到数据的行数和列数
                       fid=fopen([obj.name,'.dat'],'wt');                   %创建dat 数据
                       for i = 1:m
                          for j= 1:n  
                              if j==n
                                 fprintf(fid,'%g\n',data(i,j));%每一行，换行
                              else
                                 fprintf(fid,'%g\t',data(i,j));%数据之间用tab键隔开
                              end
                           end
                        end %从左到右，从上到下，一个个写数据
                      fclose(fid);%关闭文件              
         end
     end
     
     methods
           function save_to_srw_2d(obj)   %保存为srw可以读取的模式
               sag  = (-0.03:0.01:0.03)';   
               data=repmat(obj.V,1,length(sag));
               Furion_save_srw( obj.meri,sag,data,[obj.name,'_srw.dat']);
               
           end
     end
         
      methods
          function save_to_shadow_2d(obj)%保存为shadow可以读取的模式
              sag  = (-0.03:0.01:0.03)';   
              data=repmat(obj.V,1,length(sag))';
              Furion_save_to_shadow( obj.meri,sag,data,[obj.name,'_shadow.dat'])
           end
     end 
     
  
end
 