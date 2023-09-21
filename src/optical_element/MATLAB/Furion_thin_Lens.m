function    out_Field = Furion_thin_Lens(X,Y,in_Field,wavelength,focus_length,flag)
%% ******************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% July, 2022, Shenzhen
%
% This function is used to calculate the wave going through a thin lens.
% Input:
%    X,Y,in_Field,wavelength,focus_length,flag(=1,=2,3)
%
% output: out_Field
%% ******************************************************************** %%
k = 2*pi/wavelength;
if flag == 1
    out_Field = in_Field.*exp(-1i*k*X.^2/2/focus_length);
elseif flag == 2
    out_Field = in_Field.*exp(-1i*k*Y.^2/2/focus_length);
else
    out_Field = in_Field.*exp(-1i*k*(X.^2+Y.^2)/2/focus_length);
end