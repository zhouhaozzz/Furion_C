function Grazing_str = Furion_grazing_compound(gra_theta,phot_Energy,compound_Sym,path_Str,flag_sp)
%% ************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen
%
% This function is used to calculate the reflection and refraction of grazing
% incident X-ray.

% Input:
%     gra_theta:  grazing angle [rad]
%     pho_Energy: photon energy [eV]
%     atomic_sym: Symbol of element (lowercase)
%     path_Str:
%     flag_sp:  flag_sp = 1, s polarization; flag_sp = 2, p polarization.

% Output:
%    Grazing_str: the output data structure includes:  
%    R_amplitud
%    T_amplitud     
%    R_intensity
%    T_intensity

% Modification history
%    03-20-2021 written by C. Yang

%% ************************************************************** %%
format long
global h_Plank c_Speed e_Charge

wave_Lambda = c_Speed*h_Plank./(phot_Energy*e_Charge);
wave_Number = 2*pi./wave_Lambda;
n_Refraction_str = Furion_refraction_compound(phot_Energy,compound_Sym,path_Str);
n_complex = n_Refraction_str.complex_Nn;    %   complex index of refraction
delta_Comp= n_Refraction_str.delta;
beta_Comp = n_Refraction_str.beta;

cri_theta = sqrt(2*delta_Comp);             % critical incident angle [rad]
raf_theta = sqrt(gra_theta.^2 - cri_theta.^2 + 2i*beta_Comp); % refraction angle [rad] 

%% ************************************************************** %%
%                    sigma and pi polarization
if flag_sp == 1
    R_amplitud = -sin(gra_theta - raf_theta)./sin(gra_theta + raf_theta);
    T_amplitud = 2*cos(gra_theta).*sin(raf_theta)./sin(gra_theta + raf_theta);
    
elseif flag_sp == 2
    R_amplitud = tan(gra_theta - raf_theta)./sin(gra_theta + raf_theta);
    T_amplitud = 2*cos(gra_theta).*sin(raf_theta)./sin(gra_theta + ...
                 raf_theta)./cos(gra_theta - raf_theta);
end
R_intensity= abs(R_amplitud).^2;
T_intensity= n_complex.*cos(raf_theta)./cos(gra_theta).*abs(T_amplitud).^2;
R_phase = angle(R_amplitud);
T_phase = angle(T_amplitud);
%% *************************************************************** %%
%                         penetration length
L_penetration = 1./(2*wave_Number.*abs(imag(raf_theta)));

Grazing_str.L_penetration = L_penetration;
Grazing_str.R_amplitud = R_amplitud;
Grazing_str.T_amplitud = T_amplitud;
Grazing_str.R_intensity = R_intensity;
Grazing_str.T_intensity = T_intensity;
Grazing_str.R_phase = R_phase;
Grazing_str.T_phase = T_phase;
