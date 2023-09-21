classdef w_oe < handle
    %光学元器件父类 ，所有光学元器件的共同特征
    properties
        beam_in;  % 入射光束对象
        chi;      % 光学元器件法线方向
        ds;       % 物平面 到光学元器件的距离（物距）单位 [m]
        di;       % 光学元器件到 像平面的距离 （像）
        theta;    % 光束掠入射角度 [mrad]
        beam_out; % 出射光束线
        surface;  % 光学元器件面型对象
        g_mirror; % 追迹象光学几何镜子
        gbeam_in;
        grating;
    end    
    
    methods %初始化
        function obj = w_oe( beam_in,ds,di,chi,theta,surface,grating)         
          obj.chi =chi;
          obj.ds= ds;
          obj.di =di;
          obj.theta =theta;
          obj.beam_in =beam_in;  
          obj.surface=surface;  
          obj.grating =grating;
          %*********************↑初始化
        end         
    end   
    
    methods
        function reflect(obj)
              obj.create_g_beam();%产生几何光束              
              obj.tracing();%几何追迹
              g = obj.g_mirror;             
              delta_h = obj.surface.value(g.Z2,g.X2);                 % 计算光学元器件不同位置面型对应的高度 ；
              phase_s = -2*2*pi/obj.beam_in.wavelength.*delta_h.*g.cos_Alpha; % sin(\theta)=-1a.M1;通过面型高度计算产生的相位差 ；
              %-------------------------↑ ↑ ↑ ------------------计算面型误差
              obj.beam_out=obj.creat_w_beam(phase_s);             
              % 将面型误差和光学元器件造成的相位带入到原光束中，形成新的光束；
                  %从波动光束创建几何光束
            % obj.transform_coefficient(g.Cff);
             
        end
    end 
    
    methods % 追迹的光学元器件
        function tracing(obj)
           
        end
    end
    
    methods  %面型畸变
        function  transform_coefficient(obj,Cff)
            if obj.chi ==0 || obj.chi == 180
            obj.beam_out.X = obj.beam_out.X;
            obj.beam_out.Y = obj.beam_out.Y ;
            else
                obj.beam_out.X = obj.beam_out.X;
                obj.beam_out.Y = obj.beam_out.Y ;
            end
        end
    end
    
     methods %从波动光束产生几何光束      
        function create_g_beam(obj)  
         beam= obj.beam_in;
         Phase_field = Furion_phase_unwrap2(beam.field);          % 相位解包裹        
         optical_path= Phase_field/(2*pi)*beam.wavelength;        % 相位转换为光程 单位[m]
         dx = mean(diff(beam.X(1,:)));                            % X 方向的间距  单位[m]
         dy = mean(diff(beam.Y(:,1)));                            % Y方向的间距 单位[m]
         [Fx,Fy] = gradient(optical_path,dx,dy);                 % 求X方向和Y方向的梯度
         theta_x = -atan(Fx);                                    % 由梯度计算角度
         theta_y = -atan(Fy);                                    % 由梯度计算角度                                
         obj.beam_in.phase_field =Phase_field;                           %相位场分布
         
         phi = theta_x(:)';                       % x'    x 方向角度                                       
         psi = theta_y(:)';                       % y'    y 方向角度
         XX = beam.X(:)';                          %网格X坐标转换成散点坐标
         YY =beam. Y(:)';                          %网格Y坐标转换成散点坐标 
         lambda = beam.wavelength;                 % 波动波长和几何波长相同
         obj.gbeam_in = g_beam(XX,YY,phi,psi,lambda);    %产生几何光束
         obj.beam_in.XX =XX;
         obj.beam_in.YY =YY;
        end         
     end
    
       methods   % 构造波动光束 不考虑畸变，将增加的相位直接加在原来的相位对应的位置之上；
        function  wbeam_out=creat_w_beam(obj,s_phase)     % 经过光学元器件后增加的相位（不考虑矩阵畸变）；
       
          
            wbeam=obj.beam_in;
            Phase = obj.g_mirror.Phase + s_phase ;
            phase1 = reshape(Phase,[wbeam.N, wbeam.N]);                             % 将增加的散点相位转化为二维网格矩阵相位      ；
            Field_new = abs(wbeam.field).*exp(1i*(wbeam.phase_field+phase1));       % 通过增加的相位构建新的光的标量复数场分布    ；
%             Field_new( isnan(Field_new))=0;
            wbeam_out = beam(wbeam.X,wbeam.Y,Field_new,wbeam.wavelength);                 % 生成新的光束                              ；
        end
    end
end

