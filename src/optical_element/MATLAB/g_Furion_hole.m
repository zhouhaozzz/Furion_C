classdef g_Furion_hole<handle
    %矩形slits
    
    properties
        beam_out;%slits输出光束
    end
    
    methods 
        function obj = g_Furion_hole(beam_in,center_x,center_y,r) 
        n = beam_in.n;%
        coord =zeros(1,n);%
        for i = 1:n
            if sqrt((beam_in.XX(i)-center_x).^2 + (beam_in.YY(i)-center_y).^2)<r %判断光束是不是在小孔内部
                coord(i)=i;
            end
       end
        k=find(coord);%
        obj.beam_out = g_beam(beam_in.XX(k),beam_in.YY(k),beam_in.phi(k),beam_in.psi(k),beam_in.lambda);
        %输出光束
        end
    end
    
end

