function Do = fresnel_propagation_mono_2D(Di,L1,L2,lambda,z)   
             
           M = size(Di); %get input field array size  
           dXY1= L1./M(1); %sample interval 
           dXY2= L2./M(2); %sample interval 
           fx = -1/(2*dXY1):1/L1:1/(2*dXY1)-1/L1; %freq coords  
           fy = -1/(2*dXY2):1/L2:1/(2*dXY2)-1/L2; %freq coords  
             
           [fx,fy] = meshgrid(fx,fy);  
%            fx = fx';  
%            fy = fy';  
%       exp(1i*2*pi/lambda*z).*
  
           H = exp(-1i*pi*lambda*z.*(fx.^2+fy.^2)); %trans func  
           H = ifftshift(H); %shift trans func  
           di = fft2(fftshift(Di)); %shift, fft src fields  
           do = H.*di; %multiply  
           Do = ifftshift(ifft2(do)); %inv fft, center obs field  
             
       end  