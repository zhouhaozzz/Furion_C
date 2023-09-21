function superstruct_chi_str = Furion_superstruct_chi(phot_Energy,thick,period,atomic_sym,path_Str)
%% ************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen
%
% This function is used to calculate the complex index of infraction of
% periodic superstructure, and susceptibility.

% Input:
%     pho_Energy: photon energy [eV]
%     thick1: thickness of material 1 [m]
%     period: period of superstructure [m]
%     atomic_sym:  element symbol of material (lowercase)
%     path_Str:

% Output:
%    superstruct_chi_str: the output data structure includes photon energy,
%    Bragg angle,wavelength,chi0,chih,chihbar 
%   

%% ************************************************************** %%
format long
global h_Plank c_Speed e_Charge
%% ************************************************************** %%
n_Refraction_str1 = Furion_complex_refraction(phot_Energy,atomic_sym,path_Str);
chi_M1 = n_Refraction_str1.chi_Materi;
chi_M2 = 0;

Ratio1 = thick/period;
Ratio2 = (period-thick)/period;

chi_0 = Ratio1*chi_M1;
chi_h = chi_M1*Ratio1*sinc(Ratio1)*exp(-1i*pi*Ratio1)+...
        chi_M2*Ratio2*sinc(Ratio2)*exp(-1i*pi*(1+Ratio1));
chi_hb= chi_M1*Ratio1*sinc(Ratio1)*exp(1i*pi*Ratio1)+...
        chi_M2*Ratio2*sinc(Ratio2)*exp(1i*pi*(1+Ratio1));
    
wave_Lambda = c_Speed*h_Plank/(phot_Energy*e_Charge);  %  [m]
theta_Bragg = asind(wave_Lambda/2/period);

superstruct_chi_str.theta_Bragg = theta_Bragg;
superstruct_chi_str.phot_Energy = phot_Energy;
superstruct_chi_str.wave_Lambda = wave_Lambda;
superstruct_chi_str.chi_0 = chi_0;
superstruct_chi_str.chi_h = chi_h;
superstruct_chi_str.chi_hb = chi_hb;