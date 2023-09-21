function out_field = Furion_angular_spectrum (N,deltax_Fre,in_Field,wave_Lambda,distance)
%% ******************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen

% This function is used to calculate wave propagation in free space by
% using angular spectrum diffraction model.
%% ******************************************************************** %%
format long;
spatial_Fre = 1/wave_Lambda;
inter_index = (-(N-1)/2:(N-1)/2)*deltax_Fre;

[spatial_Fx,spatial_Fy] = meshgrid(inter_index,inter_index');
spatial_Fz = sqrt(spatial_Fre.^2 - spatial_Fx.^2 - spatial_Fy.^2);
filter_fre = (spatial_Fre.^2-spatial_Fx.^2 - spatial_Fy.^2)>0;
spatial_Fz = spatial_Fz.*filter_fre;

In_Field = fftshift(fft2(in_Field));
angular_Sp = In_Field.*exp(1i*2*pi*spatial_Fz*distance);
out_field = ifft2(ifftshift(angular_Sp));


