function Dose_eV_atom = dose_Element_main(pulse_Energy,sigma,gra_theta,phot_Energy,atomic_sym)    
%% *************************************************************** %% 
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen

% This function aims to estimate the absorbed dose for blazing incident of
% X ray optics with elementary substance coating, such as off-set mirror 
% and K-B mirror.

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



Grazing_str = Furion_grazing_incident(gra_theta,phot_Energy,atomic_sym,...
              path_Str,1);
L_penetrati = Grazing_str.L_penetration;   % penetration length
R_intensity = Grazing_str.R_intensity;       % reflection

atomic_Str = Furion_atomic_read(atomic_sym,path_Str);
molar_Mass = atomic_Str.molar_Mass_re;  %   g/mol
ma_Density = atomic_Str.masss_Density; %   g/cm^3

atom_num_den = ma_Density/molar_Mass*1e6*avogadro;  %  n = rho/A*Na; atomic number density
Dose_eV_atom = (1-R_intensity).*pulse_Energy.*sin(gra_theta)...
               /e_Charge./(2*pi*sigma.^2)./L_penetrati./atom_num_den; % [eV/atom]

end

% wave_Lambda = linspace(3,6,3000)*1e-9;
% phot_Energy = c_Speed*h_Plank./(wave_Lambda*e_Charge);
% Dose_eV_atom = dose_Element_main(1.5e-3,0.77e-3,14e-3,phot_Energy,'Ni');
% figure;
% plot(wave_Lambda/1e-9,Dose_eV_atom)
% ylabel('Dose [eV/atom]','interpreter','latex','FontSize',22);
% xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
% set(gcf,'Units','centimeters','Position',[10 10 18 15]);
% set(gca,'TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
% set(get(gca,'Children'),'linewidth',3);
% strings={'$D_{melt}=0.45$eV/atom'};
% annotation('textbox',[0.3,0.7,0.35,0.1],'LineStyle','-','interpreter','latex','LineWidth',1,'String',strings,'FontSize',18)

