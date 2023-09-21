function formfactor_Str = Furion_formfactor_read(bragg_Str,atomic_sym,path_Str)
%% ************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen
%
% This function is used to read the atomic form factor f0, f1, f2
% atomic form factor f = f0(k) + f1(hw) + if2(hw)
% Input:
%     theta_Bragg: Bragg angle  [deg]
%     pho_Energy: photon energy [eV]
%     atomic_sym: Symbol of element (lowercase)
%
%% ************************************************************** %%
%         Read the fitting coefficients of atomic form factor

format long

wav_Lambda = bragg_Str.wave_Lambda*1e10;   % [A]
for i = 1:length(atomic_sym)
    if mod(i,2) == 1
       atomic_Sym(i) = upper(atomic_sym(i));
    else
       atomic_Sym(i) = lower(atomic_sym(i));
    end
end
file_f0_co = 'atomsf.lib';                 % the fitting coefficient file 
data_f0_co = textread([path_Str.path_formfactor,file_f0_co],...
             '%s','delimiter', ' ','headerlines', 31);
index_atom = find(strcmp(data_f0_co, atomic_Sym));
index_atom = index_atom(1);
data_f0_Co = data_f0_co((index_atom+3):(index_atom+11));
Data_f0_Co = str2num(char(data_f0_Co));
for k = 1:4
    fit_inter(k) = Data_f0_Co(k+1)*exp(-Data_f0_Co(k+5)...
                   *(sind(bragg_Str.theta_Bragg)/wav_Lambda).^2);
end
form_fa_f0 = sum(fit_inter)+ Data_f0_Co(1);

%% ************************************************************** %%
%         Read the dispersion part f1 and f2 of form factor

atomic_sym = lower(atomic_sym);
file_f1_f2 = [atomic_sym,'.nff'];

[pho_energy,data_f1,data_f2] = textread([path_Str.path_formfactor,file_f1_f2],'%f %f %f','delimiter', ' ','headerlines', 1);
form_fa_f1 = interp1(pho_energy,data_f1,bragg_Str.phot_Energy);
form_fa_f2 = interp1(pho_energy,data_f2,bragg_Str.phot_Energy);
formfactor = form_fa_f0 + form_fa_f1 + 1i*form_fa_f2;

formfactor_Str.f0 = form_fa_f0;
formfactor_Str.f1 = form_fa_f1;
formfactor_Str.f2 = form_fa_f2;
formfactor_Str.f  = formfactor;





