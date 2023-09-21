function out_field = Furion_fresnel_spectralh (N,deltax_Fre,in_Field,wave_Lambda,distance)
%******************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen

% This function is used to calculate wave propagation in free space by
% using fresnel diffraction model.

% ******************************************************************** %%
format long;%显示格式为长格式
spatial_Fre = 1/wave_Lambda;%波长的倒数
inter_index = (-(N-1)/2:(N-1)/2)*deltax_Fre;%

[spatial_Fx,spatial_Fy] = meshgrid(inter_index,inter_index');%采样网格点
filter_fre = (spatial_Fre.^2 - spatial_Fx.^2 - spatial_Fy.^2)>0;
spatial_fx = spatial_Fx.*filter_fre;
spatial_fy = spatial_Fy.*filter_fre;
spatial_Fz = spatial_Fre*(1-1/2*(spatial_fx.^2 + spatial_fy.^2)/spatial_Fre.^2);

In_Field = fftshift(fft2(in_Field));
angular_Sp = In_Field.*exp(1i*2*pi*spatial_Fz*distance);
out_field = ifft2(ifftshift(angular_Sp));