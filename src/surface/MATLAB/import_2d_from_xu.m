classdef import_2d_from_xu<no_surfe
    properties   
%          meri_2d;
%          sag_2d;
%          V_2d;
         name;
         meri_1d;
         sag_1d;
    end
    methods
        function obj = import_2d_from_xu(address,ratio)
            obj.name = address(1:end-4);
            data_1 = importdata(address)/1000;%导入原始数据
            X=data_1(:,1);%第一列，X
            Y=data_1(:,2);%第二列，Y
            Z=data_1(:,3);%第三列，Z
            
            %------------扩展数据----------------
            data_2=[-X Y Z];
            data_3=[-X -Y Z];
            data_4=[X -Y Z];
            data_merge= [data_1 ;data_2 ;data_3 ;data_4];%将数据扩展到四个象限     
            
            %-----------------对数据进行插值------------------------------
            X1=data_merge(:,1);
            Y1=data_merge(:,2);
            Z1=data_merge(:,3);
            F = scatteredInterpolant(X1,Y1,Z1);
            F.Method = 'linear';
            y  =-150e-3:0.5e-3:150e-3;
            x =-15e-3:0.2e-3:15e-3;
            obj.meri_1d =y;
            obj.sag_1d =x;
            [Xd,Yd]=meshgrid(x,y);
            data1 = F(Xd,Yd);
            obj.meri_X = Xd;
            obj.sag_Y  = Yd;
            obj.V    = data1*ratio;
%             data=data1*ratio;%ratio 控制斜率误差
%             [m,n] = size(data);
%             
%             fid=fopen([address(1:end-3),'100slpeFurion','.dat'],'wt');%保存到Furion可以识别的模式
%                 for i = 1:m
%                     for j= 1:n  
%                       if j==n
%                         fprintf(fid,'%g\n',data(i,j));
%                        else
%                        fprintf(fid,'%g\t',data(i,j));
%                       end
%                     end
%                 end
%             fclose(fid);
%         end
    end
    end
%     methods
%         function   surface_plot(obj)  %汇制图形          
%             mesh(obj.meri_2d,obj.sag_2d,obj.V_2d); 
%             view(3);
%             set(gca,'TickLabelInterpreter','latex','fontsize',20,'linewidth',2);
%             xlabel('X','interpreter','latex','FontSize',22);
%             ylabel('Y','interpreter','latex','FontSize',22);
%             zlabel('Z','interpreter','latex','FontSize',22);
%         end
%     end
    
    methods
        function save_to_shadow(obj)
            fid=fopen([obj.name,'_shadow.dat'],'wt');
            y = obj.meri_1d;
            x = obj.sag_1d;
            fprintf(fid,'%g',length(x));% 显示行和列数字 第一行；
            fprintf(fid,'%g\n ',length(y));
            

           for i=1:length(y)-1
             fprintf(fid,'%g ',y(i));
           end
           fprintf(fid,'%g\n',y(end));  % 显示子午坐标；
           data =obj.V;
           data2 = [x' data']; % 将弧矢坐标绑定到子午坐标上；
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
    end
%     
%     methods
%         function save_to_srw(obj)%保存为srw可以识别的模式
%             x=obj.sag_1d; %弧矢数组
%             y=obj.meri_1d;% 子午数组
%             data = obj.V_2d;% 二维数据
%             fid=fopen([obj.name,'_SRW.dat'],'wt');%打开文件
%                 for i=1:length(x)-1                  %保存X
%                     fprintf(fid,'%g\t ',x(i));
%                 end
%                 fprintf(fid,'%g\n',x(end));  % 显示子午坐标；
% 
%                 data2 = [y' data]; % 将子午坐标绑定到子午坐标上；
%                 [m,n] = size(data2);%保存整个数据 以回车换行，以
%                 for i = 1:m
%                     for j = 1:n  
%                       if j == n
%                         fprintf(fid,'%g\n',data2(i,j));
%                       else
%                         fprintf(fid,'%g\t',data2(i,j));
%                       end
%                     end
%                 end
%                 fclose(fid);
%         end
%     end
end