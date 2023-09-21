classdef  g_Furion_plane_Mirror < g_oe%追迹phase转换成角度
  properties
  
  end
methods
function obj = g_Furion_plane_Mirror( beam_in,ds,di,chi,theta,surface,grating)   
         obj=obj@g_oe( beam_in,ds,di,chi,theta,surface,grating) ;%输入参数给父类    
         obj.reflect(beam_in,ds,di,chi,theta);%反射光束线
end
end
end
