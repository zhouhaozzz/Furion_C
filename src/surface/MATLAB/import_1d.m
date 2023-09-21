classdef import_1d<handle   %导入CSV文件保存为dat格式
     properties   
         meri;              %子午数组坐标
         V;                 %弧矢数组坐标
         name;              %文件名
     end
     methods
             function  obj = import_1d(address) %导入一维面型数据，即2列，格式是CSV 适用于Furion 和 SRW 的一维情况
                       data = importdata(address);                %导入原始数据，格式是CSV
                       [m,n] = size(data);                              %得到数据的行数和列数
                       fid=fopen([address(1:end-3),'dat'],'wt');                   %创建dat 数据
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
                      obj.meri = data(:,1);
                      obj.V    = data(:,2); 
                      obj.name = address(1:end-4);
             end
     end
        methods 
              function surface_plot(obj)
                  figure;plot(obj.meri,obj.V)%作图显示数据
                  xlabel('L [m]','interpreter','latex','FontSize',18);
                  ylabel('Height error [m]','interpreter','latex','FontSize',22);
                  set(gcf,'Units','centimeters','Position',[10 10 25 10]);
                  set(gca,'TickLabelInterpreter','latex','fontsize',18,'linewidth',2);
                  set(get(gca,'Children'),'linewidth',2); 
              end               
        end    
         methods
          function save_to_shadow_2d(obj)%保存为shadow可以识别的文件格式
              sag  = (-0.03:0.01:0.03)';   %弧矢坐标
              data=repmat(obj.V,1,length(sag))';%构建二维数据
              Furion_save_to_shadow( obj.meri,sag,data,[obj.name,'_shadow.dat']);%保存为shadow可以是别的文件
           end
     end 
               
 end

 