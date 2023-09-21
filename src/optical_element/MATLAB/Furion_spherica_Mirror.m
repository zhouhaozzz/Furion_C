classdef Furion_spherica_Mirror<w_oe
    %波动光学圆柱镜  
    properties
        r; %圆柱镜面曲率半径     
    end
    
    methods
        function obj=Furion_spherica_Mirror( beam_in,ds,di,chi,theta,surface,r,grating)   
            obj = obj@w_oe( beam_in,ds,di,chi,theta,surface,grating) ;  %初始化父类  optical_element的参数      
            obj.r=r;%初始化半径     
        
            obj.reflect;%反射光束          
        end
    end   
    
      methods %光学追迹
        function tracing(obj)
           obj.g_mirror = g_Furion_spherical_Mirror( obj.gbeam_in,obj.ds,obj.di,obj.chi,obj.theta,no_surfe(),obj.r,obj.grating);
        end
      end
    
end

