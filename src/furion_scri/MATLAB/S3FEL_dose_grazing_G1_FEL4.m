function S3FEL_dose_grazing_G1_FEL4()
format long
clear;clc;
Furion_physical_constants;
path_Str = Furion_filepath();
addpath(genpath(pwd));

pulse_Energy = 10e-3;
FWHM = [188,188,188,188,188,188]*1e-6;
theta = [12.4,23.4,35.2,46.9,58.6,69.7]*1e-6;
wave_Lambda = [5,10,15,20,25,30]*1e-9;
phot_Energy = c_Speed*h_Plank./(wave_Lambda*e_Charge);
L_distance = 70;
L_source = 30;
[out_SigmaI,sigma_WaistI,f_Rayleigh] = Furion_gauss_Inverse_propa ...
                              (FWHM,theta,L_distance,L_source,wave_Lambda,2);



gra_theta = linspace(0.1,15,300)*pi/180;
alpha_C_melt  = ones(1,300)*0.4;                 
Dose_eV_atom1 = dose_Compound_main(1e-3,out_SigmaI(1),gra_theta,phot_Energy(1),'C');
Dose_eV_atom2 = dose_Compound_main(1e-3,out_SigmaI(1),gra_theta,phot_Energy(2),'C');
Dose_eV_atom3 = dose_Compound_main(1e-3,out_SigmaI(1),gra_theta,phot_Energy(3),'C');
Dose_eV_atom4 = dose_Compound_main(1e-3,out_SigmaI(1),gra_theta,phot_Energy(4),'C');
Dose_eV_atom5 = dose_Compound_main(1e-3,out_SigmaI(1),gra_theta,phot_Energy(5),'C');
Dose_eV_atom6 = dose_Compound_main(1e-3,out_SigmaI(1),gra_theta,phot_Energy(6),'C');

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
plot(gra_theta*180/pi,Dose_eV_atom6)
hold on
plot(gra_theta*180/pi,alpha_C_melt)
ylabel('Dose [eV/atom]','interpreter','latex','FontSize',22);
xlabel('Grazing angle [deg]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',3);
legend({'5 nm','10 nm','15 nm','20 nm','25 nm','30 nm'},'Interpreter',...
        'latex','fontsize',18,'linewidth',1);
strings={'$\alpha$-C-melt'};
annotation('textbox',[0.3,0.7,0.1,0.1],'LineStyle','-','interpreter',...
           'latex','LineWidth',1,'String',strings,'FontSize',18)