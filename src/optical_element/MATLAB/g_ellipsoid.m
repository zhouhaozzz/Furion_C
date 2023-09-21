classdef  g_ellipsoid < g_cylinder_ellipse%追迹phase转换成角度
  properties 
     
  end
methods
function obj = g_ellipsoid( beam_in,ds,di,chi,theta,surface,r1,r2,grating)   
    obj=obj@ g_cylinder_ellipse( beam_in,ds,di,chi,theta,surface,r1,r2,grating)   ;%输入参数给父类  
 end
end

methods%在光学镜坐标系中，计算光束和光学元器件的交点
    %[X2,Y2,Z2]是交点，默认情况是平面镜的交叉点计算方法
    function [X2,Y2,Z2,T]=intersection(obj)
        L1=obj.L1;M1=obj.M1;N1=obj.N1;
        X1=obj.X1;Y1=obj.Y1;Z1=obj.Z1;
        a=obj.a;b=obj.b;
        A = N1.^2*b^2+a^2*M1.^2+a^2*L1.^2;
        B = 2*(b^2*N1.*Z1+a^2*M1.*Y1+a^2*L1.*X1);
        C = a^2*Y1.^2+b^2*Z1.^2-a^2*b^2+a^2*X1.^2;
        T = (-B+(B.^2-4*A.*C).^0.5)./(2*A);

        X2 = X1+T.*L1;                                                              %Nx=0
        Y2 = Y1+T.*M1; 
        Z2 = Z1+T.*N1;           
        obj.T=T;
    end
end

methods%在光学平面坐标系中，平面镜的法线方向
    function [Nx,Ny,Nz]=normal(obj)
        Y2=obj.Y2;Z2=obj.Z2;X2=obj.X2;
        a=obj.a;b=obj.b;
        Nx = -(X2/b^2)./(Y2.^2/b^4+Z2.^2/a^4+X2.^2/b^4).^0.5;
        Ny = -(Y2/b^2)./(Y2.^2/b^4+Z2.^2/a^4+X2.^2/b^4).^0.5;  
        Nz = -(Z2/a^2)./(Y2.^2/b^4+Z2.^2/a^4+X2.^2/b^4).^0.5; 
        obj.Nx=Nx;
        obj.Ny=Ny;
        obj.Nz=Nz;
    end
end
end
