classdef beam <handle 
    %波动光学中的光束    
    properties   
        wavelength;     % 波长，单位           [m]
        X;              % 网格坐标 X方向
        Y;              % 网格坐标 Y方向
        field;          % 光束场 复数 二维矩阵        
        N;              % 网格的长度 单位 点的个数
        phase_field;    % 相位场分布
        XX;%              散点化
         YY;%散点化
%         phi;psi;n;
     
    end
    
    methods
        function obj = beam(X,Y,field,wavelength)
            obj.X =X;
            obj.Y =Y;
            obj.field =field;
            obj.wavelength =wavelength; 
            obj.N=size(X,1);                            %网格坐标X（横向，沿着行方向）方向的维度数
            %obj.path();
        end
    end    
    
   methods  % plot 强度分布图和相位分布图  输入 distance为距离 单位 [m]
        function  detector_field(obj,distance)                  
            addpath(genpath('.\display'));                            %添加 显示二维强度函数的路径
             if (nargin<2)                                            %如果参数小于2个，直接 作图
                  Furion_intensity_detector(obj.X,obj.Y,obj.field,0); %作图函数 输入 X 网格 Y 网格 field 复数场 
                  Furion_phase_detector(obj.X,obj.Y,obj.field,2);  
             else
                  bs=obj.translation(distance);                        %如果2个参数，先将光线传播一段距离 distance，
                  Furion_intensity_detector(bs.X,bs.Y,bs.field,0);     %然后作图显示强度分布
                  Furion_phase_detector(obj.X,obj.Y,obj.field,1);      %作图显示相位分布
             end          
        end
   end  
      
   methods % 光束线传播一段距离   distance 距离 单位[m]  
        function  beam_tanslated = translation(obj,distance)       
             flag = 2;%选择传播子
             L = max(obj.X(1,:))-min(obj.X(1,:));%空间采样的尺寸
             if flag ==1                 
                 out_Field = Furion_fresnel_spatialh (obj.X,obj.Y,obj.field,obj.wavelength,distance); 
                 %菲涅尔传播子、实域空间采样
             elseif flag ==2
                 out_Field = Furion_fresnel_spectralh (obj.N,1/L,obj.field,obj.wavelength,distance);
                 %菲涅尔传播子，频域空间采样
             elseif flag == 3
                 out_Field = Furion_angular_spectrum (obj.N,1/L,obj.field,obj.wavelength,distance);
             else
                 out_Field = fresnel_propagation_mono_2D(obj.field,L,L,obj.wavelength,distance) ;
             end
                  beam_tanslated = beam(obj.X,obj.Y,out_Field,obj.wavelength);     %生成新的光束       
        end
   end
       
    methods%重采样  %适用于平面镜、柱面镜  %重新采样 L重新采样的尺寸大小 单位 [m]
        function  beam_=resize1(obj,L)   
           x = linspace(-L/2,L/2,obj.N);                                        %重新采样x轴方向
            y = x';                                                             %重新采样Y轴方向
            [X_r,Y_r] = meshgrid(x,y);   
            %创建重新采样的网格点
 
            
            F = scatteredInterpolant(obj.X(:),obj.Y(:),obj.field(:),'linear');  %散点插值  一维数组
            Field_new = F(X_r(:),Y_r(:));                                       %插值得到新的采样
            Field_new_1 =reshape(Field_new,obj.N,obj.N);                        %矩阵一维转换为二维
           beam_ = beam(X_r,Y_r,Field_new_1,obj.wavelength);                    %创建新的光束         
        end
    end
    
     methods%重采样  %适用于平面镜、柱面镜  %重新采样 L重新采样的尺寸大小 单位 [m]
        function  beam_=resize2(obj,L,N)   %   改变size和抽样点数
           x = linspace(-L/2,L/2,N);                                        %重新采样x轴方向
            y = x';                                                             %重新采样Y轴方向
            [X_r,Y_r] = meshgrid(x,y);   
            %创建重新采样的网格点
 
            
            F = scatteredInterpolant(obj.X(:),obj.Y(:),obj.field(:),'linear');  %散点插值  一维数组
            Field_new = F(X_r(:),Y_r(:));                                       %插值得到新的采样
            Field_new_1 =reshape(Field_new,N,N);                        %矩阵一维转换为二维
           beam_ = beam(X_r,Y_r,Field_new_1,obj.wavelength);                    %创建新的光束         
        end
     end
    
         methods%重采样  %适用于平面镜、柱面镜  %重新采样 L重新采样的尺寸大小 单位 [m]
        function  beam_=resize3(obj,Lx, Ly,N)   %   改变size和抽样点数
           x = linspace(-Lx/2,Lx/2,N);                                        %重新采样x轴方向
            y = linspace(-Ly/2, Ly/2, N)';                                                             %重新采样Y轴方向
            [X_r,Y_r] = meshgrid(x,y);   
            %创建重新采样的网格点
 
            
            F = interp2(obj.X,obj.Y,obj.field,X_r,Y_r,'cubic',0);  %散点插值  一维数组
            %Field_new = F(X_r(:),Y_r(:));                                       %插值得到新的采样
            %Field_new_1 =reshape(Field_new,N,N);                        %矩阵一维转换为二维
           beam_ = beam(X_r,Y_r,F,obj.wavelength);                    %创建新的光束         
        end
    end
  
methods       %计算光束的总功率
    function p = power(obj)
          x = obj.X(1,:);
          y = obj.Y(:,1);
          p = trapz(y,trapz(x,abs(obj.field).^2,2));
        % p= sum(sum(abs(obj.field).^2))*dx*dy;%振幅的平方求和
    end
end

end

