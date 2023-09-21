function [beam_sigma,waist_sigma,z_Distance] = cylindrical_mirror_focus()
%% ******************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen

% This function is used to inversely propagate a Gaussian beam to beam
% waist£¬and return the distance between the input and the waist. Then
% move the waist to source point and calculate the beam size from the 
% waist to target plane.
% 
% Input:
%      sigma: the rms of the intensity of the input Gaussian beam [m]
%      theta: angle of beam divergence [rad]
%      L_distance£º distance from the input to the target plane [m]
%      L_source:   from the undulator exit to source point
%      wave_Lambda£ºwavelength  [m]
% Output:
%      beam_sigma: sigma of the beam at the target plane
%      z_Distance: Distance from the input to the beam waist

%% ******************************************************************** %%
r_mi = 196;
r_mi_p = 98;
g_theta = 7e-3;
R_meridian1 = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta)); % M2

r_mi = 207;
r_mi_p = 118;
g_theta = 7.5e-3;
R_meridian2 = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta)); % M4




R_meridian = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta));

% R_sagittal = 2*sin(g_theta)./(1./r_si+1./r_si_p);
% R_meridian1 = 2./(1./r_mi)./(sin(g_theta));
% R_sagittal1 = 2*sin(g_theta)./(1./r_si);

%% *************************************************************** %%
%                        CDI endstation


r_mi = 66;
r_mi_p = 6;          %  horizontal
g_theta = 10e-3;
R_meridian = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta));


r_mi = 37;
r_mi_p = 4;          % vertical
g_theta = 10e-3;
R_meridian = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta));


%% *************************************************************** %%
%                        ×ÛºÏÉ¢Éä endstation


r_mi = 85;
r_mi_p = 6;          %  horizontal
g_theta = 10e-3;
R_meridian = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta));


r_mi = 56;
r_mi_p = 4;          % vertical
g_theta = 10e-3;
R_meridian = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta));

%% *************************************************************** %%
%                        RIXS endstation


r_mi = 94;
r_mi_p = 10;          %  horizontal
g_theta = 10e-3;
R_meridian = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta));


r_mi = 66;
r_mi_p = 7;          % vertical
g_theta = 10e-3;
R_meridian = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta));

%% *************************************************************** %%
%                            XPS endstation


r_mi = 98;
r_mi_p = 6.8;          %  horizontal
g_theta = 10e-3;
R_meridian = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta));


r_mi = 69;
r_mi_p = 4.8;          % vertical
g_theta = 10e-3;
R_meridian = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta));
