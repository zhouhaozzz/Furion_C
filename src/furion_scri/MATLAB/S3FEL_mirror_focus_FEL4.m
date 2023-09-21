function S3FEL_mirror_focus_FEL4()
%% ******************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen

% This function is used to inversely propagate a Gaussian beam to beam
% waist，and return the distance between the input and the waist. Then
% move the waist to source point and calculate the beam size from the 
% waist to target plane.
% 
% Input:
%      sigma: the rms of the intensity of the input Gaussian beam [m]
%      theta: angle of beam divergence [rad]
%      L_distance： distance from the input to the target plane [m]
%      L_source:   from the undulator exit to source point
%      wave_Lambda：wavelength  [m]
% Output:
%      beam_sigma: sigma of the beam at the target plane
%      z_Distance: Distance from the input to the beam waist

%% ******************************************************************** %%
%                           M2 and M4c
r_mi = 98.5;          % M2a
r_mi_p = 38.5;
g_theta = 20e-3;
R_meridian = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta));
r_mi = 102;          % M2b
r_mi_p = 35;
g_theta = 10e-3;
R_meridian = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta));

r_mi = 106;          % M4c
r_mi_p = 41;
g_theta = 20e-3;
R_meridian = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta));



%% ******************************************************************** %%
%                               极紫外剂量标定

r_mi = 28;
r_mi_p = 6;          %  horizontal
g_theta = 20e-3;
R_meridian = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta));
%R_meridian1 = 2./(1./r_mi_p)./(sin(g_theta));


r_mi = 20;
r_mi_p = 4;          % vertical
g_theta = 20e-3;
R_meridian = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta));
%R_meridian = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta));



%% *************************************************************** %%
%                                ARPES实验站

r_mi = 44;
r_mi_p = 3;          %  horizontal
g_theta = 20e-3;
R_meridian = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta));


r_mi = 35;
r_mi_p = 2;          % vertical
g_theta = 20e-3;
R_meridian = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta));


R_meridian1 = 2./(1./r_mi)./(sin(g_theta));
R_sagittal1 = 2*sin(g_theta)./(1./r_si);

%% *************************************************************** %%
%                              变线距光栅前置镜M5c                                 %


g_theta = 43.3e-3;
r_si = 99;
r_si_p = 28;
R_sagittal = 2*sin(g_theta)./(1./r_si+1./r_si_p)






