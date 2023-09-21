function n_Refraction_str = Furion_refraction_compound(phot_Energy,compound_Sym,path_Str)
%% ************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen
%
% This function is used to calculate the complex index of infraction of
% compound.

% Input:
%     pho_Energy: photon energy [eV]
%     compound_Sym: Symbol of compound
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
atomic_Sym = {'H','He','Li','Be','B','C','N','O','F','Ne','Na','Mg','Al','Si','P','S','Cl',...
              'Ar','K','Ca','Sc','Ti','V','Cr','Mn','Fe','Co','Ni','Cu','Zn','Ga','Ge','As',...
              'Se','Br','Kr','Rb','Sr','Y','Zr','Nb','Mo','Tc','Ru','Rh','Pd','Ag','Cd',...
              'In','Sn','Sb','Te','I','Xe','Cs','Ba','La','Ce','Pr','Nd','Pm','Sm','Eu','Gd', ...
              'Tb','Dy','Ho','Er','Tm','Yb','Lu','Hf','Ta','W','Re','Os','Ir','Pt','Au','Hg',...
              'Tl','Pb','Bi','Po','At','Rn','Fr','Ra','Ac','Th','Pa','U','Np','Pu','Am','Cm',...
              'Bk','Cf','Es','Fm','Md','No','Lr'};


wave_Lambda = c_Speed*h_Plank./(phot_Energy*e_Charge);  %  [m]
compound_Str = Furion_compound_read(compound_Sym,path_Str);
molar_Mass = compound_Str.molar_Mass;  %   g/mol
ma_Density = compound_Str.mas_Density; %   g/cm^3
ato_number = compound_Str.atomic_num;  %   
elemnt_Fra = compound_Str.elemnt_Fra;  %

%%                        
chi_inter1 = -r_Electr*wave_Lambda.^2/pi*ma_Density*1e6*avogadro;
chi_inter2 = 0;
for k = 1:length(ato_number)
    atom_Sym = cell2mat(lower(atomic_Sym(ato_number(k))));
    file_f1_f2 = [atom_Sym,'.nff'];
    [pho_energy,data_f1,data_f2] = textread([path_Str.path_formfactor,file_f1_f2],'%f %f %f','delimiter', ' ','headerlines', 1);
    form_fa_f1 = interp1(pho_energy,data_f1,phot_Energy)-ato_number(k);
    form_fa_f2 = interp1(pho_energy,data_f2,phot_Energy);
    
    chi_inter2 = chi_inter2 + elemnt_Fra(k)./molar_Mass(k)*(ato_number(k)+form_fa_f1+1i*form_fa_f2);
end

chi_Materi = chi_inter1.*chi_inter2;          %  Chi   n = 1+Chi/2
complex_Nn = 1+1/2*chi_Materi;               %   Complex index of refraction  n = 1-¦Ä+i¦Â
delta_Comp = -1/2*real(chi_Materi);          %   delta ¦Ä
beta_Comp  = 1/2*imag(chi_Materi);           %   beta ¦Â

n_Refraction_str.chi_Materi = chi_Materi;
n_Refraction_str.complex_Nn = complex_Nn;    %   complex index of refraction
n_Refraction_str.delta = delta_Comp;
n_Refraction_str.beta  = beta_Comp;