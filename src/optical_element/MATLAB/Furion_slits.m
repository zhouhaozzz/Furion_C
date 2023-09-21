classdef Furion_slits<handle
    %¾ØÐÎslits
    
    properties
        beam_out;%slitsÊä³ö¹âÊø
    end
    
    methods 
        function obj = Furion_slits(beam_in,center_x,center_y,width,height) 
            xx = beam_in.X(:);
            yy = beam_in.Y(:);
            vv = beam_in.field(:);
            n = length(xx);
            N = beam_in.N;
       % coord =zeros(1,n);
        for i = 1:n
            if ~(abs(xx(i)-center_x)<width/2 && abs(yy(i)-center_y)<height/2)
                vv(i) =0;
                i
            end
        end
       X=reshape(xx,[N,N]);
       Y=reshape(yy,[N,N]);
       V =reshape(vv,[N,N]);
        %k=find(coord);
        obj.beam_out = beam(X,Y,V,beam_in.wavelength);
        end
    end
    
end

