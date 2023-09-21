function S3FEL_mirror_focus_FEL2()
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
%                           M3c and M4c
r_mi = 96;          
r_mi_p = 39.5;
r_si = 95;
r_si_p = 32;
g_theta = 20e-3;


R_meridian = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta));
R_sagittal = 2*sin(g_theta)./(1./r_si+1./r_si_p);


R_meridian1 = 2./(1./r_mi)./(sin(g_theta));
R_sagittal1 = 2*sin(g_theta)./(1./r_si);

%% ******************************************************************** %%
%                               生物大分子实验站

r_mi = 118;
r_mi_p = 140.84;          %  horizontal
g_theta = 17.45e-3;
R_meridian = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta));



r_mi = 124;
r_mi_p = 127.4;          % vertical
g_theta = 17.45e-3;
R_meridian = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta));



R_meridian1 = 2./(1./r_mi)./(sin(g_theta));
R_sagittal1 = 2*sin(g_theta)./(1./r_si);


%% *************************************************************** %%
%                                雾霾实验站

r_mi = 118;
r_mi_p = 156;          %  horizontal
g_theta = 17.45e-3;
R_meridian = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta));


r_mi = 124;
r_mi_p = 157;          % vertical
g_theta = 17.45e-3;
R_meridian = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta));


R_meridian1 = 2./(1./r_mi)./(sin(g_theta));
R_sagittal1 = 2*sin(g_theta)./(1./r_si);

%% *************************************************************** %%
%                              表面散射实验站                                 %


r_mi = 118;
r_mi_p = 238;          %  horizontal
g_theta = 17.45e-3;
R_meridian = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta));


r_mi = 124;
r_mi_p = 227;          % vertical
g_theta = 17.45e-3;
R_meridian = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta));
