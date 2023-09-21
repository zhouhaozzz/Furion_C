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
%     atomic_sym2： element symbol of material 2 (lowercase)
%     path_Str:

% Output:
%    multilayer_chi_str: the output data structure includes photon energy,
%    Bragg angle,wavelength,chi0,chih,chihbar 
%   

%% ************************************************************** %%
format long
global h_Plank c_Speed e_Charge
%% ************************************************************** %%
n_Refraction_str1 = Furion_complex_refraction(phot_Energy,atomic_sym1,path_Str); %第一种材料的复折射率
n_Refraction_str2 = Furion_complex_refraction(phot_Energy,atomic_sym2,path_Str); %第二种材料的复折射率
chi_M1 = n_Refraction_str1.chi_Materi;                                           %第一种材料的电极化率
chi_M2 = n_Refraction_str2.chi_Materi;                                           %第二种材料的电极化率

period_Multilayer = thick1+thick2; %周期长度
Ratio1 = thick1/period_Multilayer; %第一层厚度所占的比例
Ratio2 = thick2/period_Multilayer; %第二层厚度所占的比例

chi_0 = Ratio1*chi_M1 + Ratio2*chi_M2;%电极化率加权平均
chi_h = chi_M1*Ratio1*sinc(Ratio1)*exp(-1i*pi*Ratio1)+...
        chi_M2*Ratio2*sinc(Ratio2)*exp(-1i*pi*(1+Ratio1));
chi_hb= chi_M1*Ratio1*sinc(Ratio1)*exp(1i*pi*Ratio1)+...
        chi_M2*Ratio2*sinc(Ratio2)*exp(1i*pi*(1+Ratio1));
    
wave_Lambda = c_Speed*h_Plank/(phot_Energy*e_Charge);  %  计算波长，单位[m]
theta_Bragg = asind(wave_Lambda/2/period_Multilayer);%计算布拉格角
%********************** ↓ ↓ ↓*************多层膜参数
multilayer_chi_str.theta_Bragg = theta_Bragg;%布拉格角
multilayer_chi_str.phot_Energy = phot_Energy;%光子能量
multilayer_chi_str.wave_Lambda = wave_Lambda;%波长
multilayer_chi_str.chi_0 = chi_0;
multilayer_chi_str.chi_h = chi_h;
multilayer_chi_str.chi_hb = chi_hb;
    
    
