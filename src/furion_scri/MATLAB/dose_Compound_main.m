function Dose_eV_atom = dose_Compound_main(pulse_Energy,sigma,gra_theta,phot_Energy,compound_Sym)    
%% *************************************************************** %% 
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen

% This function aims to estimate the absorbed dose for blazing incident of
% X ray optics with compound coating, such as off-set mirror and K-B mirror.

% Input:
%    Pulse_Energy(J)
%    radius(cm) 
%    rho (g/cm^3)
%    Absorption_coeff(cm)
% Output:
%    Dose_eV_atom: absorbed dose [eV/atom]

% Modification history
%     04-19-2021 written by C. Yang.

%% *************************************************************** %%
format long
global avogadro e_Charge
Furion_physical_constants;
path_Str = Furion_filepath();
addpath(genpath(pwd));

Grazing_str = Furion_grazing_compound(gra_theta,phot_Energy,...
              compound_Sym,path_Str,1);
L_penetrati = Grazing_str.L_penetration;   % penetration length
R_intensity = Grazing_str.R_intensity;       % reflection

compound_Str = Furion_compound_read(compound_Sym,path_Str);
molar_Mass = compound_Str.molar_Mass;  %   g/mol
ma_Density = compound_Str.mas_Density; %   g/cm^3
ato_number = compound_Str.atomic_num;  %   
elemnt_Fra = compound_Str.elemnt_Fra;  %

n_Atom_inter1 = ma_Density*1e6*avogadro;
n_Atom_inter2 = 0;
for k = 1:length(ato_number)    
    n_Atom_inter2 = n_Atom_inter2 + elemnt_Fra(k)./molar_Mass(k);
end
atom_num_den = n_Atom_inter1*n_Atom_inter2;            %  n = rho/A*Na; atomic number density
Dose_eV_atom = (1-R_intensity).*pulse_Energy.*sin(gra_theta)...
               /e_Charge./(2*pi*sigma.^2)./L_penetrati./atom_num_den; % [eV/atom]


% wave_Lambda = linspace(1,3,1000)*1e-9;
% wave_Lambda = [1,1.55,2,2.5,3]*1e-9;
% phot_Energy = c_Speed*h_Plank./(wave_Lambda*e_Charge);
% Dose_eV_atom = dose_Compound_main(1.5e-3,0.4e-3,8.7e-3,phot_Energy,'B4C');
% figure;
% plot(wave_Lambda/1e-9,Dose_eV_atom)
% ylabel('Dose [eV/atom]','interpreter','latex','FontSize',22);
% xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
% set(gcf,'Units','centimeters','Position',[10 10 20 15]);
% set(gca,'TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
% set(get(gca,'Children'),'linewidth',3);