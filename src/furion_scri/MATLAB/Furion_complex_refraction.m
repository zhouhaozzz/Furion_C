function n_Refraction_str = Furion_complex_refraction(phot_Energy,atomic_sym,path_Str)
%% ************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen
%
% This function is used to calculate the complex index of infraction of
% simple substance.

% Input:
%     pho_Energy: photon energy [eV]
%     atomic_sym: Symbol of element (lowercase)
%     path_Str:

% Output:
%    n_Refraction_str: the output data structure includes chi,n,delta,beta 
%   
%    n = 1-¦Ä+i¦Â;  n = 1+chi/2;

% Modification history
%    03-20-2021 written by C. Yang




%% ************************************************************** %%
format long
global r_Electr avogadro h_Plank c_Speed e_Charge
%% ************************************************************** %%

wave_Lambda = c_Speed*h_Plank./(phot_Energy*e_Charge);  %  [m]
atomic_Str = Furion_atomic_read(atomic_sym,path_Str);
molar_Mass = atomic_Str.molar_Mass_re;  %   g/mol
ma_Density = atomic_Str.masss_Density;  %   g/cm^3
ato_number = atomic_Str.atomic_number;  %   

atomic_sym = lower(atomic_sym);         %
file_f1_f2 = [atomic_sym,'.nff'];       %

[pho_energy,data_f1,data_f2] = textread([path_Str.path_formfactor,...
             file_f1_f2],'%f %f %f','delimiter', ' ','headerlines', 1);
form_fa_f1 = interp1(pho_energy,data_f1,phot_Energy)-ato_number;
form_fa_f2 = interp1(pho_energy,data_f2,phot_Energy);


chi_Materi = -r_Electr*wave_Lambda.^2/pi*ma_Density/molar_Mass*1e6*avogadro.*(ato_number+...
               form_fa_f1+1i*form_fa_f2);    %   Chi   n = 1+Chi/2
complex_Nn = 1+1/2*chi_Materi;               %   Complex index of refraction  n = 1-¦Ä+i¦Â
delta_Comp = -1/2*real(chi_Materi);          %   delta ¦Ä
beta_Comp  = 1/2*imag(chi_Materi);           %   beta ¦Â

n_Refraction_str.chi_Materi = chi_Materi;
n_Refraction_str.complex_Nn = complex_Nn;    %   complex index of refraction
n_Refraction_str.delta = delta_Comp;
n_Refraction_str.beta  = beta_Comp;




