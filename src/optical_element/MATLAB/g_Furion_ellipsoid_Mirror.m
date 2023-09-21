classdef  g_Furion_ellipsoid_Mirror < g_Furion_cylinder_ellipse_Mirror%追迹phase转换成角度
  properties 
   
  end
methods
function obj = g_Furion_ellipsoid_Mirror( beam_in,ds,di,chi,theta,surface,r1,r2,grating)   
    obj=obj@g_Furion_cylinder_ellipse_Mirror( beam_in,ds,di,chi,theta,surface,r1,r2,grating) ;%输入参数给父类   
    
end
end

methods
    function set_center(obj, beam_in,ds,di,chi,theta,surface,r1,r2,grating)
        obj.center =g_ellipsoid( beam_in,ds,di,chi,theta,surface,r1,r2,grating);      
    end
end
end
