classdef Furion_plane_Mirror<w_oe
    %平面反射镜    
    properties   
 
    end
    
    methods
        function obj= Furion_plane_Mirror( beam_in,ds,di,chi,theta,surface,grating)              
                 obj=obj@w_oe( beam_in,ds,di,chi,theta,surface,grating) ;%输入参数给父类    
                 %初始化父类的参数，包括 入射光束、光学元器件法线方向、掠入射角、像距、物距              
                 %------------------------------------------
                 obj.grating = grating;
                 obj.reflect();
        end
    end   
    
    methods %光学追迹
        function tracing(obj)
           obj.g_mirror = g_Furion_plane_Mirror( obj.gbeam_in,obj.ds,obj.di,obj.chi,obj.theta,no_surfe(),obj.grating);
        end
    end
      methods   % 构造波动光束 不考虑畸变，将增加的相位直接加在原来的相位对应的位置之上；
        function  wbeam_out=creat_w_beam(obj,s_surface)     % 经过光学元器件后增加的相位（不考虑矩阵畸变）；
        if obj.grating.m ==0          
            wbeam=obj.beam_in;
            Phase = obj.g_mirror.Phase + s_surface ;
            phase1 = reshape(Phase,[wbeam.N, wbeam.N]);                             % 将增加的散点相位转化为二维网格矩阵相位      ；
            Field_new = abs(wbeam.field).*exp(1i*(wbeam.phase_field+phase1));       % 通过增加的相位构建新的光的标量复数场分布    ；
%             Field_new( isnan(Field_new))=0;
            wbeam_out = beam(wbeam.X,wbeam.Y,Field_new,wbeam.wavelength);                 % 生成新的光束                              ；
        else
            Cff = obj.g_mirror.Cff;
             X_ =obj.g_mirror.X_;Y_ =obj.g_mirror.Y_;
            Phase =obj.g_mirror.Phase+s_surface;
            beam_in = obj.beam_in;
            phase_0 = Phase' + beam_in.phase_field(:);                        % 相位增量
            if obj.chi ==0 || obj.chi ==180
                X=beam_in.XX*Cff;
                Y=beam_in.YY*Cff;
            else
                 X=beam_in.XX*Cff;
                 Y=beam_in.YY*Cff;
            end
                    F = scatteredInterpolant(X_',Y_',phase_0);                    % 相位原坐标插值
                    F.Method = 'nearest';
                    F.ExtrapolationMethod='nearest';
                    phase_interp = F(X',Y');                            %用追迹后的坐标插值追迹前的相位
                    F1 = scatteredInterpolant(X_',Y_',abs(beam_in.field(:)));              %用追迹后的坐标插值追迹前的强度值
                    F1.Method = 'nearest';
                    F1.ExtrapolationMethod='nearest';
                    field_interp =   F1(X',Y');%delta_h = obj.surface.value(obj.a.Z2,obj.a.X2);
                    
          
            phase1 = reshape(phase_interp,[beam_in.N, beam_in.N]); % 一维数组转换为二维数组
            field1 = reshape(field_interp,[beam_in.N, beam_in.N]); % 一维数组转化为二维数组
            Field_new = abs(field1).*exp(1i*(phase1))./sqrt(obj.g_mirror.Cff);     %    通过插值后的振幅和相位组合成新的复数场 
            X_new=reshape(X,[beam_in.N, beam_in.N]);
            Y_new=reshape(Y,[beam_in.N, beam_in.N]);
            wbeam_out = beam(X_new,Y_new,Field_new,beam_in.wavelength);  %产生新的光束      
        end
        end
    end
end

