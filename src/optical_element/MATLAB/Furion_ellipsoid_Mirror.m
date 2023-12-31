classdef Furion_ellipsoid_Mirror<w_oe
    %波动光学圆柱镜  
    properties
        r; %圆柱镜面曲率半径  
        r1;
        r2;
    end
    
    methods
        function obj=Furion_ellipsoid_Mirror( beam_in,ds,di,chi,theta,surface,r1,r2,grating)   
            obj = obj@w_oe( beam_in,ds,di,chi,theta,surface,grating) ;  %初始化父类  optical_element的参数      
           obj.r1=r1; %物距
            obj.r2 =r2;%像距
            obj.reflect;%反射光束          
        end
    end   
    
      methods %面型反射,追迹
        function tracing(obj)
           obj.g_mirror = g_Furion_ellipsoid_Mirror( obj.gbeam_in,obj.ds,obj.di,obj.chi,obj.theta,obj.surface,obj.r1,obj.r2,obj.grating)   ;
        end
      end
    
end

