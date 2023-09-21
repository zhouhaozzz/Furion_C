function debye_Waller = Furion_Debyefactor_cal(bragg_Str,Temper,atomic_Str)
%% ************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen
%
% This function is used to calculate Debye-Waller factor that corrects 
% the atomic form factor. It is only valid for cubic structures. 
% Input:
%     theta_Bragg: Bragg angle  [deg]
%     pho_Energy: photon energy [eV]
%     Temper: temperature [K]
%     atomic_Str: atomic constants structure 
%
%% ************************************************************** %%
syms n;
format long
global h_Plank k_Boltz avogadro

%% ************************************************************** %%
%                    Debye-Waller factor

re_Atomic_m = atomic_Str.molar_Mass_re;
tempe_Debye = atomic_Str.debye_Tempera;
atomic_Mass = re_Atomic_m/avogadro/1000;             %  [kg]
wave_Lambda = bragg_Str.wave_Lambda;                 %  [m]
intermedi_X = tempe_Debye./Temper;
quantity_Phi= quad(@(x)x./(exp(x)-1),0,intermedi_X)/intermedi_X;
quantity_B0 = 3*h_Plank^2/(2*k_Boltz*tempe_Debye*atomic_Mass);
quantity_BT = 4*quantity_B0*quantity_Phi/intermedi_X;
quantity_M  = (quantity_B0+quantity_BT)*(sind(bragg_Str.theta_Bragg)./wave_Lambda).^2;
debye_Waller= exp(-quantity_M);


