classdef g_Furion_spherical_Mirror<g_oe
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
r;%圆柱面镜的曲率半径
   end
 methods  
    function obj = g_Furion_spherical_Mirror( beam_in,ds,di,chi,theta,surface,r,grating)
    
       obj=obj@g_oe( beam_in,ds,di,chi,theta,surface,grating) ; 
       obj.r=r;
       obj.reflect(beam_in,ds,di,chi,theta) ;
end
 end
 
 methods%在光学平面坐标系中，圆柱面镜的法线方向
    function [Nx,Ny,Nz]=normal(obj)
       Ny=-(obj.Y2-obj.r)/obj.r; 
       Nz=-obj.Z2/obj.r;  
       Nx = -obj.X2/obj.r;
    end
 end

     methods
        function [X2,Y2,Z2,T]=intersection(obj)
            r1=obj.r;
            %L1=obj.L1;N1=obj.N1;M1=obj.M1;Y1=obj.Y1;Z1=obj.Z1;X1=obj.X1;
            %r=obj.r;
            A=obj.N1*0+1;%计算一元二次方程2次项系数
            B=2.*(obj.N1.*obj.Z1+obj.Y1.*obj.M1-r1.*obj.M1+obj.X1.*obj.L1);%计算一元二次方程一次项系数
            C=obj.Y1.^2+obj.Z1.^2-2*r1.*obj.Y1+obj.X1.^2;%计算一元二次方程常数项系数
            T=(-B+(B.^2-4*A.*C).^0.5)./(2*A);%一元二次方程的解析解
            X2= obj.X1+T.*obj.L1;     
            Y2= obj.Y1+T.*obj.M1;   
            Z2= obj.Z1+T.*obj.N1;   
        end
    end
 
end
