classdef Furion_toroid_Mirror<w_oe
    %波动光学圆柱镜  
    properties
        R1; %圆柱镜面曲率半径  
        R2;
        rho1;
        rho2;
    end
    
    methods
        function obj=Furion_toroid_Mirror( beam_in,ds,di,chi,theta,surface,R1,R2,rho1,rho2,grating)  
            obj = obj@w_oe( beam_in,ds,di,chi,theta,surface,grating) ;  %初始化父类  optical_element的参数      
            obj.R1 =R1;
            obj.R2=R2;
            obj.rho1=rho1;
            obj.rho2 =rho2;
            obj.reflect;%反射光束          
        end
    end   
    
      methods %光学追迹
        function tracing(obj)
           obj.g_mirror =  g_Furion_toroid_Mirror( obj.gbeam_in,obj.ds,obj.di,obj.chi,obj.theta,no_surfe(),obj.R1,obj.R2,obj.rho1,obj.rho2,grating)  ;
          
        end
      end
    
end

