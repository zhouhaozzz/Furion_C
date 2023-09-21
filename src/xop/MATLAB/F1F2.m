classdef F1F2 < handle
    %F0 此处显示有关此类的摘要
    %   此处显示详细说明    
    properties 
      n_Refraction_str;   %折射率结构 
      atomic_sym;         %元素符号          字符
      n;                  %数据点数量       双精度
      ph_Energy;          %光子能量 单位 eV 双精度
     formfactor_Str;%结构因子
    end
    
     methods              %初始化
           function obj = F1F2(e_range,n,atomic_sym)%输入光子能量范围 ev
               Furion_physical_constants; 
               obj.atomic_sym = atomic_sym;% 
               %************** ↑ ↑ ↑ ***************初始化
                e=e_range(1):(e_range(2)-e_range(1))/(n-1):e_range(2);   %设置q值横坐标
                           %元素波矢量
                path_Str             =  Furion_filepath();
                obj.n                =  n;                       %元素数量
                obj.ph_Energy        =  e;               
                obj.n_Refraction_str =  Furion_complex_refraction(e,atomic_sym,path_Str);
                obj.formfactor_Str   =  Furion_formfactor_read_dis(e,atomic_sym,path_Str);
                %计算复折射率 包括参数 delta beta chi 和 n = 1 - delta + ibeta ；                    
            end %设置范围和点数
     end  
     
     methods %作 q --> f1 图
       function plot_f1(obj)
           f1=obj.formfactor_Str.f1;
            plot(log10(obj.ph_Energy),f1,'LineWidth',2,'color','red');%作图 横坐标散射矢量，纵坐标，原子形状因子
            set(gca,'ygrid','on','xgrid','on');
            set(gca,'FontSize',14); 
            xlabel('eV ','interpreter','latex','FontSize',16);
            ylabel('$f_1$ [electron units]','interpreter','latex','FontSize',16);
            title(obj.atomic_sym);
        end
     end  
     
     methods %作 q --> f2 图
       function plot_f2(obj)
           f2= obj.formfactor_Str.f2;
            plot(log10(obj.ph_Energy),f2,'LineWidth',2,'color','red');%作图 横坐标散射矢量，纵坐标，原子形状因子
            set(gca,'ygrid','on','xgrid','on');
            set(gca,'FontSize',14); 
            xlabel('eV [log10] ','interpreter','latex','FontSize',16);
            ylabel('$f_2$ [electron units][linear]','interpreter','latex','FontSize',16);
            title(obj.atomic_sym);
        end
     end  
     
      methods %作 q -->delta 图
       function plot_delta(obj)        
            delta = obj.n_Refraction_str.delta;%            
            plot(log10(obj.ph_Energy),delta','LineWidth',2,'color','red');%作图 横坐标散射矢量，纵坐标，原子形状因子
            set(gca,'ygrid','on','xgrid','on');
            set(gca,'FontSize',14); 
            xlabel('eV [log10] ','interpreter','latex','FontSize',16);
            ylabel('$\delta$ [linear]','interpreter','latex','FontSize',16);
            title([obj.atomic_sym ,'\delta']);                              %设置标题
        end
      end  
     
      methods %作 q --> beta 图
       function plot_beta(obj)
            beta =  obj.n_Refraction_str.beta;
            plot(log10(obj.ph_Energy),beta','LineWidth',2,'color','red');%作图 横坐标散射矢量，纵坐标，原子形状因子
            set(gca,'ygrid','on','xgrid','on');
            set(gca,'FontSize',14); 
            xlabel('eV [log10] ','interpreter','latex','FontSize',16);
            ylabel('$\beta$ [linear]','interpreter','latex','FontSize',16);
            title([obj.atomic_sym ,'\beta']);  
        end
     end 
end

