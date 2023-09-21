classdef g_Furion_toroid_Mirror<g_oe
    %Furion_cylinder_spherical          >>> common approach <<<
%( X,Y,Phi,Psi,ds,di,chi,theta,r,n )
%all rotation angle is left-hand 
% coordinate column vector  -->   (x,y,z);
%row vector X Y Phi Psi;
%************************************************************************
% ID:     Furion_21070902
% ***********************************************************************
% Input:  Position X Y ;direction Phi Psi;source distance ds;image
% distance di;rotation angle chi(0 90 180 270) z_directiion
% right-hand;incident angle respect to the surface theta;the total number
% of the light rays n;
% ***********************************************************************
% Ouput:  Position X Y  and direction Phi Psi
% ***********************************************************************
%
% Modification history
%   2021-7-9 create add annotation debug ;
%   2021-7-9 add trace interface ;
%   2021-9-20 change function to class
%************************************************************************
 properties
       R;%超环面镜的大半径
       rho;%超环面镜的小半径
 end
 methods  
    function obj = g_Furion_toroid_Mirror( beam_in,ds,di,chi,theta,surface,R1,R2,rho1,rho2,grating)    
       obj=obj@g_oe( beam_in,ds,di,chi,theta,surface,grating) ; %初始化父类
       obj.R  = 2/sin(theta)/(1/R1+1/R2);
       obj.rho = 2*sin(theta)/(1/rho1+1/rho2);
       obj.reflect(beam_in,ds,di,chi,theta) ;
end
 end
 
 methods%在光学平面坐标系中，圆柱面镜的法线方向
    function [Nx,Ny,Nz]=normal(obj)
        X2 = obj.X2;Y2=obj.Y2;Z2 =obj.Z2;
        Nx0=X2;
        Ny0=Y2-obj.R-((obj.R-obj.rho).*(Y2-obj.R))./(Z2.^2+(obj.R-Y2).^2).^0.5;
        Nz0=Z2-(obj.R-obj.rho).*Z2./((obj.R-Y2).^2+Z2.^2).^0.5;
        N_mod = (Nx0.^2+Ny0.^2+Nz0.^2).^0.5;
        Nx = -Nx0./N_mod;
        Ny = -Ny0./N_mod ;
        Nz = -Nz0./N_mod;
     
    end
 end

 methods %求交点
        function [X2,Y2,Z2,T]=intersection(obj)
            L1=obj.L1;N1=obj.N1;M1=obj.M1;Y1=obj.Y1;Z1=obj.Z1;X1=obj.X1;
            n =length(L1);
            t_Start= -Y1./M1;%开始长度
            epsilon = 1e-11;%误差标准
            %--------------- ↓ ↓ ↓ -----------预先分配内存
            t_Min =-(X1.*L1+Y1.*M1+Z1.*N1-obj.R.*M1);
            t_Max = t_Start;
            T =0*X1;
            X2 = 0*X1;
            Y2 = 0*X1;
            Z2 = 0*X1;
            error_Final= 0*X1;
            %----------- ↑ ↑ ↑-----------预先分配内存--------------

           for i =1:n    %二分法 球交点                                                                         
             [ X2(i),Y2(i),Z2(i),error_Final(i),T(i)] = Furion_bisection ...
             ( t_Min(i),t_Max(i),X1(i),Y1(i),Z1(i),L1(i),M1(i),N1(i),epsilon,obj.R,obj.rho );
         i2=i
            end
        
        end
 end
 
end
