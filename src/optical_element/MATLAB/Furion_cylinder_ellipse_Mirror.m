classdef Furion_cylinder_ellipse_Mirror<w_oe
    %波动光学圆柱镜  
    properties
        r; %圆柱镜面曲率半径  
        r1;
        r2;
        flag;
    end
    
    methods
        function obj=Furion_cylinder_ellipse_Mirror( beam_in,ds,di,chi,theta,surface,r1,r2,grating,flag)   
            obj = obj@w_oe( beam_in,ds,di,chi,theta,surface,grating) ;  %初始化父类  optical_element的参数      
           obj.r1=r1; %物距
            obj.r2 =r2;%像距
            obj.flag=flag;
            obj.reflect;%反射光束   
            
        end
    end   
    
      methods %面型反射,追迹
        function tracing(obj)
           obj.g_mirror = g_Furion_cylinder_ellipse_Mirror( obj.gbeam_in,obj.ds,obj.di,obj.chi,obj.theta,obj.surface,obj.r1,obj.r2,obj.grating)   ;
        end
      end
    
      methods   % 构造波动光束 不考虑畸变，将增加的相位直接加在原来的相位对应的位置之上；
        function  wbeam_out=creat_w_beam(obj,s_surface)     % 经过光学元器件后增加的相位（不考虑矩阵畸变）；
%         if obj.grating.m ==0          
%             wbeam=obj.beam_in;
%             Phase = obj.g_mirror.Phase + s_surface ;
%             phase1 = reshape(Phase,[wbeam.N, wbeam.N]);                             % 将增加的散点相位转化为二维网格矩阵相位      ；
%             Field_new = abs(wbeam.field).*exp(1i*(wbeam.phase_field+phase1));       % 通过增加的相位构建新的光的标量复数场分布    ；
% %             Field_new( isnan(Field_new))=0;
%             wbeam_out = beam(wbeam.X,wbeam.Y,Field_new,wbeam.wavelength);                 % 生成新的光束                              ；
%         else
            
             X_ =obj.g_mirror.X_;Y_ =obj.g_mirror.Y_;
            Phase =obj.g_mirror.Phase+s_surface;
            beam_in = obj.beam_in;
            phase_0 = Phase' + beam_in.phase_field(:);                        % 相位增量
           
                X=beam_in.XX;
                Y=beam_in.YY;      
                   
                    F = scatteredInterpolant(X_',Y_',phase_0);                    % 相位原坐标插值
                    F.Method = 'linear';
                    F.ExtrapolationMethod='linear';
                    phase_interp = F(X',Y');                            %用追迹后的坐标插值追迹前的相位
                    F1 = scatteredInterpolant(X_',Y_',abs(beam_in.field(:)));              %用追迹后的坐标插值追迹前的强度值
                    F1.Method = 'linear';
                    F1.ExtrapolationMethod='linear';
                    field_interp =   F1(X',Y');%delta_h = obj.surface.value(obj.a.Z2,obj.a.X2);
                    
          
            phase10 = reshape(phase_interp,[beam_in.N, beam_in.N]); % 一维数组转换为二维数组
            field10 = reshape(field_interp,[beam_in.N, beam_in.N]); % 一维数组转化为二维数组
            X_new1=reshape(X,[beam_in.N, beam_in.N]);
             Y_new1=reshape(Y,[beam_in.N, beam_in.N]);
             if (obj.flag ==0)
                 Field_new = abs(field10).*exp(1i*(phase10)); 
                  wbeam_out = beam(X_new1,Y_new1,Field_new,beam_in.wavelength);  %产生新的光束 
             else
            %
            L=max(max(beam_in.X))-min(min(beam_in.X));
              x = linspace(-L/2,L/2,10001);                                        %重新采样x轴方向
            y = x';                                                             %重新采样Y轴方向
            [X_r,Y_r] = meshgrid(x,y);   
             phase1 = interp2(X_new1,Y_new1,phase10,X_r,Y_r,'cubic',0); 
             field1 = interp2(X_new1,Y_new1,field10,X_r,Y_r,'cubic',0); 
            %
            Field_new = abs(field1).*exp(1i*(phase1)); %    通过插值后的振幅和相位组合成新的复数场 
%             X_new=reshape(X,[beam_in.N, beam_in.N]);
%             Y_new=reshape(Y,[beam_in.N, beam_in.N]);
            wbeam_out = beam(X_r,Y_r,Field_new,beam_in.wavelength);  %产生新的光束 
             end
        end
        end
%       end
end

