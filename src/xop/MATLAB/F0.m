classdef F0 < handle
    %F0 此处显示有关此类的摘要
    %   此处显示详细说明    
     properties
      f0;          %结构因子
      f1;f2;       %结构因子
      q;           %散射矢量
      atomic_sym;  %元素符号
      n;           %数据点数量
      ph_Energy;   %光子能量
    end
    
     methods         %初始化
      function obj = F0(q_range,n)
            q=q_range(1):(q_range(2)-q_range(1))/(n-1):q_range(2);   %设置q值横坐标
            obj.q=q;                       %元素波矢量
            obj.n=n;                       %元素数量
            obj.ph_Energy = 12.398./(sind(90)./q);
       end %设置范围和点数
     end
    
     methods      %作图元素的形状因子
       function   obj=element_F(obj,atomic_sym)%
           
            bragg_Str.theta_Bragg = 90;                         %设置布拉格波长    
            %******************* ↓ ↓ ↓***********************
            F0 = zeros(1,obj.n);    
            F1 = zeros(1,obj.n); 
            F2 = zeros(1,obj.n); %分配初始内存
            ph_Energy1 = zeros(1,obj.n); 
            %************** ↑ ↑ ↑ *************************** 
            
            path_Str = Furion_filepath();                        %设置路径
            
            for i = 1:obj.n                                         %逐点计算
             bragg_Str.wave_Lambda = 1/obj.q(i);  %输入波长
             bragg_Str.phot_Energy = obj.ph_Energy(i); %计算相应的光子能量
             formfactor_Str = Furion_formfactor_read(bragg_Str,atomic_sym,path_Str);%计算形状因子（总体）
             
             F0(i) = formfactor_Str.f0;%形状因子 f0
             F1(i) = formfactor_Str.f1;
             F2(i) = formfactor_Str.f2;
             ph_Energy1(i) = bragg_Str.phot_Energy; 
            end
            obj.f0 = F0;  
            obj.f1 = F1;
            obj.f2 = F2;
            obj.ph_Energy = ph_Energy1;
        end
     end
    
     methods      %复合物的形状因子
        function obj=compound_F(obj,compound_Sym)
            F0=zeros(1,obj.n);            
            a=strsplit(compound_Sym);              %分割字符串 比如‘H_2 O’->['H_2','O']
            for i = 1:length(a)
                b = strsplit(a{i},'_');            %在次分割 ‘H_2’->['H','2']
                if length(b)==2
                obj.element_F(b{1});              %计算元素的f0形状因子
                F0=F0+obj.f0*str2double(b{2});
                else
                    obj.element_F(b{1}); 
                    F0=F0+obj.f0;
                end
            end
            obj.f0 =F0;                             %所有元素f0的叠加就是总的分子的形状因子
        end
     end
    
     methods %作 q --> f0 图
       function plot_f(obj,atomic_sym)
            plot(obj.q/(1e10),obj.f0,'LineWidth',2,'color','red');%作图 横坐标散射矢量，纵坐标，原子形状因子
            set(gca,'ygrid','on','xgrid','on');
            set(gca,'FontSize',14); 
            xlabel('q [$\frac{sin\theta}{\lambda}$][$A^{-1}$]','interpreter','latex','FontSize',16);
            ylabel('$f_0$ [electron units]','interpreter','latex','FontSize',16);
            title(atomic_sym);
        end
     end  
end

