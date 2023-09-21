classdef Furion_hole<handle
    %¾ØÐÎslits
    
    properties
        beam_out;%slitsÊä³ö¹âÊø
    end
    
    methods 
        function obj = Furion_hole(beam_in,center_x,center_y,r) 
            mask=(beam_in.X-center_x).^2+(beam_in.Y-center_y).^2<r^2;
            V=beam_in.field.*mask;
%             xx = beam_in.X(:);
%             yy = beam_in.Y(:);
%             vv = beam_in.field(:);
%             n = length(xx);
%             N = beam_in.N;
%        % coord =zeros(1,n);
%         for i = 1:n
%             if ~(sqrt((xx(i)-center_x).^2 + (yy(i)-center_y).^2)<r)
%                 vv(i) =0;
%             end
%         end
%        X=reshape(xx,[N,N]);
%        Y=reshape(yy,[N,N]);
%        V =reshape(vv,[N,N]);
        %k=find(coord);
        obj.beam_out = beam(beam_in.X,beam_in.Y,V,beam_in.wavelength);
        end
    end
    
end

