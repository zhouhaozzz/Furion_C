function S3FEL_dose_grazing_G1_FEL2()
format long
clear;clc;
Furion_physical_constants;
path_Str = Furion_filepath();
addpath(genpath(pwd));

pulse_Energy = 1e-3;
FWHM = [157.5,157.5,157.5,157.5,157.5,157.5]*1e-6;
theta = [6.4,8.5,16.8,25.2,30,42]*1e-6;
wave_Lambda = [2.3,3,6,9,13.5,15]*1e-9;
L_distance = 92;
L_source = 40;
phot_Energy = c_Speed*h_Plank./(wave_Lambda*e_Charge);
[out_SigmaI,sigma_WaistI,f_Rayleigh] = Furion_gauss_Inverse_propa ...
                              (FWHM,theta,L_distance,L_source,wave_Lambda,2);



gra_theta = linspace(0.1,15,300)*pi/180;
Ni_melt  = ones(1,300)*0.45;                 
Dose_eV_atom1 = dose_Element_main(1e-3,out_SigmaI(1),gra_theta,phot_Energy(1),'Ni');
Dose_eV_atom2 = dose_Element_main(1e-3,out_SigmaI(1),gra_theta,phot_Energy(3),'Ni');
Dose_eV_atom3 = dose_Element_main(1e-3,out_SigmaI(1),gra_theta,phot_Energy(4),'Ni');
Dose_eV_atom4 = dose_Element_main(1e-3,out_SigmaI(1),gra_theta,phot_Energy(5),'Ni');
Dose_eV_atom5 = dose_Element_main(1e-3,out_SigmaI(1),gra_theta,phot_Energy(6),'Ni');

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
plot(gra_theta*180/pi,Ni_melt)
ylabel('Dose [eV/atom]','interpreter','latex','FontSize',22);
xlabel('Grazing angle [deg]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',3);
legend({'2.3 nm','6 nm','9 nm','13.5 nm','15 nm'},'Interpreter',...
        'latex','fontsize',18,'linewidth',1);
strings={'Ni-melt'};
annotation('textbox',[0.3,0.7,0.1,0.1],'LineStyle','-','interpreter',...
           'latex','LineWidth',1,'String',strings,'FontSize',18)