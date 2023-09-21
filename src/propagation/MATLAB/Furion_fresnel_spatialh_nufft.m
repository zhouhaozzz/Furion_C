function out_Field = Furion_fresnel_spatialh_nufft (X,Y,in_Field,wave_Lambda,distance)
%% ******************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen

% This function is used to calculate wave propagation in free space by
% using fresnel diffraction model.
%% ******************************************************************** %%
format long;
[Nx,~] = size(in_Field);
L_size = max(X(1,:))-min(X(1,:));
spatial_Fre=1/wave_Lambda;
h_response = exp(1i*2*pi*spatial_Fre*distance)*exp((1i*2*pi*spatial_Fre*(X.^2+Y.^2))/(2*distance))...
             /(1i*wave_Lambda*distance);

H_response = fft2(h_response);    
In_Field   = fft2(in_Field);
out_Field  = ifftshift(ifft2(H_response.*In_Field))*(L_size/Nx)^2;
