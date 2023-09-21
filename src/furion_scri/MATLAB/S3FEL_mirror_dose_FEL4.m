function S3FEL_mirror_dose_FEL4()
%% *************************************************************** %%

format long
clear;clc;
Furion_physical_constants;
path_Str = Furion_filepath();
addpath(genpath(pwd));

pulse_Energy = 1.5e-3;
FWHM = [188,188,188,188,188,188]*1e-6;
theta = [12.4,23.4,35.2,46.9,58.6,69.7]*1e-6;
wave_Lambda = [5,10,15,20,25,30]*1e-9;
phot_Energy = c_Speed*h_Plank./(wave_Lambda*e_Charge);
L_distance = 55;
L_source = 30;
[out_SigmaI,sigma_WaistI,f_Rayleigh] = Furion_gauss_Inverse_propa ...
                              (FWHM,theta,L_distance,L_source,wave_Lambda,2);
                          

Dose_eV_atom1 = dose_Element_main(pulse_Energy,out_SigmaI,10e-3,phot_Energy,'C');
Dose_eV_atom2 = dose_Element_main(pulse_Energy,out_SigmaI,20e-3,phot_Energy,'C');
figure;
plot(wave_Lambda/1e-9,Dose_eV_atom1)
hold on
plot(wave_Lambda/1e-9,Dose_eV_atom2)
hold on
plot(linspace(5,30,300),ones(1,300)*0.40);
ylabel('Dose [eV/atom]','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 18 15]);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',3);
legend({'$\theta = 10$mrad','$\theta = 20$mrad'},'Interpreter',...
        'latex','fontsize',18,'linewidth',1);
strings={'$D_{melt}$ of $\alpha$-C'};
annotation('textbox',[0.3,0.7,0.35,0.1],'LineStyle','-','interpreter',...
           'latex','LineWidth',1,'String',strings,'FontSize',18)        