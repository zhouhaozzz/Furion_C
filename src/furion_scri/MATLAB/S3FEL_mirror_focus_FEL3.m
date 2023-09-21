function S3FEL_mirror_focus_FEL3()
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
%                             M2 and M4c
r_mi = 114;          
r_mi_p = 66;
% r_si = 127;
% r_si_p = 100000;
g_theta = 17.45e-3;
R_meridian1 = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta)); % M2a

r_mi = 118;          
r_mi_p = 62;
% r_si = 127;
% r_si_p = 100000;
g_theta = 8.73e-3;
R_meridian1 = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta)); % M2b

r_mi = 124;          
r_mi_p = 71;
g_theta = 17.45e-3;
R_meridian2 = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta)); % M4c

%R_sagittal = 2*sin(g_theta)./(1./r_si+1./r_si_p);


% R_meridian1 = 2./(1./r_mi)./(sin(g_theta));
% R_sagittal1 = 2*sin(g_theta)./(1./r_si);

%% ******************************************************************** %%
%                               XAS and XES

r_mi = 34;
r_mi_p = 8.7;          %  horizontal
g_theta = 17.45e-3;
R_meridian = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta));


r_mi = 20;
r_mi_p = 7.7;          % vertical
g_theta = 17.45e-3;
R_meridian = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta));


% R_meridian1 = 2./(1./r_mi)./(sin(g_theta));
% R_sagittal1 = 2*sin(g_theta)./(1./r_si);


%% ******************************************************************** %%
%                               ¼«×ÏÍâÑÚÄ¤

r_mi = 55;
r_mi_p = 8.4;          %  horizontal
g_theta = 17.45e-3;
R_meridian1 = 2./(1./r_mi_p)./(sin(g_theta));


r_mi = 40;
r_mi_p = 7.4;          % vertical
g_theta = 17.45e-3;
R_meridian = 2./(1./r_mi+1./r_mi_p)./(sin(g_theta));


R_meridian1 = 2./(1./r_mi)./(sin(g_theta));
R_sagittal1 = 2*sin(g_theta)./(1./r_si);


