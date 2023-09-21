format long
clear;clc;
Furion_physical_constants;
path_Str = Furion_filepath();
addpath(genpath(pwd));

FWHM = [221,305,366,411,447]*1e-6;
theta = [3.9,5.1,6.4,7.9,9.1]*1e-6;
wave_Lambda = [1,1.55,2,2.5,3]*1e-9;
L_distance = 137;
L_source = 80;
[out_SigmaI,sigma_WaistI,f_Rayleigh] = Furion_gauss_Inverse_propa ...
                              (FWHM,theta,L_distance,L_source,wave_Lambda,1);

gra_theta = linspace(0.1,4,300)*pi/180;
B4C_melt  = ones(1,300)*0.68;                 
phot_Energy = c_Speed*h_Plank./(wave_Lambda*e_Charge);
Dose_eV_atom1 = dose_Compound_main(1.5e-3,out_SigmaI(1),gra_theta,phot_Energy(1),'B4C');
Dose_eV_atom2 = dose_Compound_main(1.5e-3,out_SigmaI(1),gra_theta,phot_Energy(2),'B4C');
Dose_eV_atom3 = dose_Compound_main(1.5e-3,out_SigmaI(1),gra_theta,phot_Energy(3),'B4C');
Dose_eV_atom4 = dose_Compound_main(1.5e-3,out_SigmaI(1),gra_theta,phot_Energy(4),'B4C');
Dose_eV_atom5 = dose_Compound_main(1.5e-3,out_SigmaI(1),gra_theta,phot_Energy(5),'B4C');

subplot(1,2,2)
plot(gra_theta*180/pi,Dose_eV_atom1)
hold on
plot(gra_theta*180/pi,Dose_eV_atom2)
hold on
plot(gra_theta*180/pi,Dose_eV_atom3)
hold on
plot(gra_theta*180/pi,Dose_eV_atom4)
hold on
plot(gra_theta*180/pi,Dose_eV_atom5)
hold on
plot(gra_theta*180/pi,B4C_melt)
ylabel('Dose [eV/atom]','interpreter','latex','FontSize',22);
xlabel('Grazing angle [deg]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',3);
legend({'1.0 nm','1.5 nm','2.0 nm','2.5 nm','3.0 nm'},'Interpreter',...
        'latex','fontsize',18,'linewidth',1);
strings={'B$_4$C-melt'};
annotation('textbox',[0.3,0.7,0.1,0.1],'LineStyle','-','interpreter',...
           'latex','LineWidth',1,'String',strings,'FontSize',18)
