classdef  g_Furion_cyliner_parabolic_focus_Mirror < g_oe%追迹phase转换成角度
  properties 
     center;     
  end
methods
function obj = g_Furion_cyliner_parabolic_focus_Mirror( beam_in,ds,di,chi,theta,surface,r2,grating)   
    obj=obj@g_oe( beam_in,ds,di,chi,theta,surface,grating) ;      %输入参数给父类   
    obj.set_center(beam_in,ds,di,chi,theta,surface,r2,grating); %求出中心坐标系中的交点和法向量  
    obj.reflect(beam_in,ds,di,chi,theta);               %反射光束线
end
end

methods%在光学镜坐标系中，计算光束和光学元器件的交点
    %[X2,Y2,Z2]是交点，默认情况是平面镜的交叉点计算方法
    function [X2,Y2,Z2,T]=intersection(obj)
        
       T=obj.center.T;
       [X2,Y2,Z2]=obj.cneter_to_oe_p(obj.center.X2,obj.center.Y2,obj.center.Z2)  ;
      
    end
end
methods%在光学平面坐标系中，平面镜的法线方向
    function [Nx,Ny,Nz]=normal(obj)
        [Nx,Ny,Nz]=obj.cneter_to_oe_v(obj.center.Nx,obj.center.Ny,obj.center.Nz) ; 
    end
end
methods%光束和光学元件交点的坐标 从center坐标系转换到光学元器件坐标系
    function  [X2,Y2,Z2]=cneter_to_oe_p(obj,X,Y,Z)  
         n=obj.beam_in.n;
         OS1=([X;Y;Z+obj.center.r2-0.5*obj.center.p])+repmat([0; obj.center.r2*sin(2*obj.center.theta);0],1,n);
         OS = Furion_rotx(obj.theta)*OS1;
         X2=OS(1,:) ;Y2=OS(2,:);Z2=OS(3,:);
    end 
end
methods%光学元器件法线 从center坐标系中转换到光学元器件坐标系中
    function  [Nx,Ny,Nz]=cneter_to_oe_v(obj,L,M,N)            
         OV=(Furion_rotx(obj.theta)*[L;M;N]);
         Nx=OV(1,:) ;Ny=OV(2,:) ;Nz=OV(3,:);
    end 
end

methods%设置转换为center坐标的类
    function set_center(obj, beam_in,ds,di,chi,theta,surface,r2,grating)
          obj.center = g_cyliner_parabolic_focus( beam_in,ds,di,chi,theta,surface,r2,grating) ;
        
    end
end
end
