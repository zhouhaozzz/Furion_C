classdef  g_Furion_paraboid_collimation_Mirror < g_Furion_cyliner_parabolic_collimation_Mirror%追迹phase转换成角度
  properties 
    
  end
methods
function obj = g_Furion_paraboid_collimation_Mirror( beam_in,ds,di,chi,theta,surface,r1,grating)   
    obj=obj@g_Furion_cyliner_parabolic_collimation_Mirror( beam_in,ds,di,chi,theta,surface,r1,grating) ;%输入参数给父类   
   
end
end

methods%设置转换为center坐标的类
    function set_center(obj, beam_in,ds,di,chi,theta,surface,r1,grating)
        obj.center =g_paraboid_collimation( beam_in,ds,di,chi,theta,surface,r1,grating)  ;
    end
end
end
