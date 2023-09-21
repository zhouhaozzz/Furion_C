function struc_Str = Furion_strucfactor_cal(formfactor_Str,debye_Waller,bragg_Str,atomic_Posi,miller_Str)
%% ************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen
%
% This function calculates the structure factor of the selected crystal.
%
% Input: 
%      formfactor_Str (produced by 'Furion_formfactor_read¡¯)
%      debye_Waller   (produced by 'Furion_Debyefactor_cal')
%      bragg_Str      (produced by 'Furion_bragg_cal')
%      atomic_Posi    (produced by 'Furion_crystal_read')
%      miller_Str     Miller index
%
% Output:
%      struc_Str: F_0, F_hkl, F_hkl_bar, chi_0, chi_hkl, chi_hkl_bar
%      

%% ************************************************************** %%
format long
global r_Electr

%% ************************************************************** %%

struc_Str.F_0 = 0;
struc_Str.F_hkl = 0;
struc_Str.F_hkl_bar = 0;
for k = 1:length(atomic_Posi(:,1))
    Z  = atomic_Posi(k,1);
    f0 = formfactor_Str.f0;
    f1 = formfactor_Str.f1 - Z;      % substrat the atomic number 'Z', because the data adds 'Z'.
    f2 = formfactor_Str.f2;
    fraction = atomic_Posi(k,2);
    form_Factor = f0 + f1 + 1i*f2;
    struc_Str.F_0 = struc_Str.F_0 + (Z + f1 + 1i*f2)*fraction;
    struc_Str.F_hkl = struc_Str.F_hkl + form_Factor*debye_Waller*exp(1i*2*pi*(atomic_Posi(k,3)*miller_Str.h + ...
                      atomic_Posi(k,4)*miller_Str.k + atomic_Posi(k,5)*miller_Str.l))*fraction;
    struc_Str.F_hkl_bar = struc_Str.F_hkl_bar + form_Factor*debye_Waller*exp(1i*2*pi*(-atomic_Posi(k,3)*miller_Str.h - ...
                      atomic_Posi(k,4)*miller_Str.k - atomic_Posi(k,5)*miller_Str.l))*fraction;
end

struc_Str.chi_0 = -r_Electr*bragg_Str.wave_Lambda^2/pi/bragg_Str.cell_Volume*struc_Str.F_0;
struc_Str.chi_hkl = -r_Electr*bragg_Str.wave_Lambda^2/pi/bragg_Str.cell_Volume*struc_Str.F_hkl;
struc_Str.chi_hkl_bar = -r_Electr*bragg_Str.wave_Lambda^2/pi/bragg_Str.cell_Volume*struc_Str.F_hkl_bar;


