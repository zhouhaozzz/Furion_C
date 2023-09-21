function multilayer_chi_str = Furion_multilayer_chi(phot_Energy,thick1,thick2,atomic_sym1,atomic_sym2,path_Str)
%% ************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen
%
% This function is used to calculate the complex index of infraction of
% materials, and susceptibility.

% Input:
%     pho_Energy: photon energy [eV]
%     thick1: thickness of material 1 [m]
%     thick2: thickness of material 2 [m]
%     atomic_sym1:  element symbol of material 1 (lowercase)
%     atomic_sym2£º element symbol of material 2 (lowercase)
%     path_Str:

% Output:
%    multilayer_chi_str: the output data structure includes photon energy,
%    Bragg angle,wavelength,chi0,chih,chihbar 
%   

%% ************************************************************** %%
format long
global h_Plank c_Speed e_Charge
%% ************************************************************** %%
n_Refraction_str1 = Furion_complex_refraction(phot_Energy,atomic_sym1,path_Str);
n_Refraction_str2 = Furion_complex_refraction(phot_Energy,atomic_sym2,path_Str);
chi_M1 = n_Refraction_str1.chi_Materi;
chi_M2 = n_Refraction_str2.chi_Materi;

period_Multilayer = thick1+thick2;
Ratio1 = thick1/period_Multilayer;
Ratio2 = thick2/period_Multilayer;

chi_0 = Ratio1*chi_M1 + Ratio2*chi_M2;
chi_h = chi_M1*Ratio1*sinc(Ratio1)*exp(-1i*pi*Ratio1)+...
        chi_M2*Ratio2*sinc(Ratio2)*exp(-1i*pi*(1+Ratio1));
chi_hb= chi_M1*Ratio1*sinc(Ratio1)*exp(1i*pi*Ratio1)+...
        chi_M2*Ratio2*sinc(Ratio2)*exp(1i*pi*(1+Ratio1));
    
wave_Lambda = c_Speed*h_Plank/(phot_Energy*e_Charge);  %  [m]
theta_Bragg = asind(wave_Lambda/2/period_Multilayer);

multilayer_chi_str.theta_Bragg = theta_Bragg;
multilayer_chi_str.phot_Energy = phot_Energy;
multilayer_chi_str.wave_Lambda = wave_Lambda;
multilayer_chi_str.chi_0 = chi_0;
multilayer_chi_str.chi_h = chi_h;
multilayer_chi_str.chi_hb = chi_hb;
    
    
