classdef Furion_slits1<handle
    %矩形slits
    
    properties
        beam_out;%slits输出光束
    end
    
    methods 
        function obj = Furion_slits1(beam_in,center_x,center_y,width,height) 
              X =beam_in.X;
              Y =beam_in.Y;
              V0= beam_in.field;              
              slit_X = rectpuls(X-center_x,width);%
              slit_Y = rectpuls(Y-center_y,height);         
              V =V0.*slit_X.*slit_Y;
             obj.beam_out = beam(X,Y,V,beam_in.wavelength);%产生光束
        end
    end
    
end

