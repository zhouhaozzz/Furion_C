classdef  g_paraboid_focus< g_cyliner_parabolic_focus%追迹phase转换成角度
  properties 

  end
methods
function obj = g_paraboid_focus( beam_in,ds,di,chi,theta,surface,r2,grating)   
    obj=obj@g_cyliner_parabolic_focus( beam_in,ds,di,chi,theta,surface,r2,grating) ;%输入参数给父类
end
end

methods%在光学镜坐标系中，计算光束和光学元器件的交点
    %[X2,Y2,Z2]是交点，默认情况是平面镜的交叉点计算方法
    function [X2,Y2,Z2,T]=intersection(obj)
        L1=obj.L1;M1=obj.M1;N1=obj.N1;
        X1=obj.X1;Y1=obj.Y1;Z1=obj.Z1;
        
        A = M1.^2+L1.^2;
        B = 2*(N1.*obj.p+M1.*Y1+L1.*X1);
        C = X1.^2+Y1.^2+2*obj.p.*Z1;
        T = (-B+(B.^2-4*A.*C).^0.5)./(2*A);
        X2 = X1+T.*L1;                                                              %Nx=0
        Y2 = Y1+T.*M1; 
        Z2 = Z1+T.*N1;        
        obj.T=T;
    end
end



methods%在光学平面坐标系中，平面镜的法线方向
    function [Nx,Ny,Nz]=normal(obj)
        Y2=obj.Y2;%Z2=obj.Z2;
        X2=obj.X2;
        Nx = -X2./(X2.^2+Y2.^2+obj.p^2).^0.5;
        Ny = -Y2./(X2.^2+Y2.^2+obj.p^2).^0.5;  
        Nz = -obj.p./(X2.^2+Y2.^2+obj.p^2).^0.5; 
        obj.Nx=Nx;
        obj.Ny=Ny;
        obj.Nz=Nz;
    end
end

end
