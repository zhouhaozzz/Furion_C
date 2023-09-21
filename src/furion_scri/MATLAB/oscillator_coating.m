function  [] = oscillator_coating()
format long
clear;clc;
path_Str = Furion_filepath();
addpath(genpath(pwd));
Furion_physical_constants;

%% *************************************************************** %%
gra_theta = 4.5*pi/180;
wave_Lambda = linspace(0.2,15,3000)*1e-9;
% wave_Lambda = linspace(0.2,30,6000)*1e-9;
phot_Energy = c_Speed*h_Plank./(wave_Lambda*e_Charge);
Grazing_str1 = Furion_grazing_incident(gra_theta,phot_Energy,'Pt',path_Str,1);
Grazing_str2 = Furion_grazing_incident(gra_theta,phot_Energy,'Au',path_Str,1);
Grazing_str3 = Furion_grazing_incident(gra_theta,phot_Energy,'Ni',path_Str,1);
Grazing_str4 = Furion_grazing_incident(gra_theta,phot_Energy,'Ru',path_Str,1);
Grazing_str5 = Furion_grazing_compound(gra_theta,phot_Energy,'B4C',path_Str,1);

figure
plot(wave_Lambda/1e-9,Grazing_str1.R_intensity,'LineWidth',2,'Color',[0 0.498 0])        
hold on
plot(wave_Lambda/1e-9,Grazing_str2.R_intensity,'LineWidth',2,'Color',[.078 .169 .549])
hold on
plot(wave_Lambda/1e-9,Grazing_str3.R_intensity,'LineWidth',2,'Color',[0.870, 0.490, 0])
hold on
plot(wave_Lambda/1e-9,Grazing_str4.R_intensity,'LineWidth',2,'Color',[.494 .184 .557])
hold on
plot(wave_Lambda/1e-9,Grazing_str5.R_intensity,'LineWidth',2,'Color',[1 0 0])
ylabel('Reflectivity','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'InvertHardcopy','off','Color',[1 1 1],'Units','centimeters',...
        'Position',[10 10 20 15]);  
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',3);
legend({'Pt','Au','Ni','Ru','B$_4$C'},'Interpreter','latex','fontsize',18,'linewidth',1);
strings={'Grazing incident angle: 4.5$^\circ$'};
annotation('textbox',[0.3,0.7,0.1,0.1],'LineStyle','-','interpreter',...
           'latex','LineWidth',1,'String',strings,'FontSize',18)

%% *************************************************************** %%
gra_theta2 = linspace(0.1,20,1500)'*pi/180;
wave_Lambda = linspace(0.2,15,1500)*1e-9;
phot_Energy = c_Speed*h_Plank./(wave_Lambda*e_Charge);
[E_p,G_a] = meshgrid(phot_Energy,gra_theta2);
W_l = c_Speed*h_Plank./(E_p*e_Charge);

Grazing_str6 = Furion_grazing_incident(G_a,E_p,'Ru',path_Str,1);
figure;
[A,l] = contourf(W_l/1e-9,G_a*180/pi,Grazing_str6.R_intensity,[0,0.01,.05,.1,.3,.5,.6,...
                .7,.8,.9,.95,.98],'ShowText','on','LineWidth',1);
ylabel('Grazing angle [deg]','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
title('Coating: Ru','interpreter','latex','FontSize',22);
set(gcf,'InvertHardcopy','off','Color',[1 1 1],'Units','centimeters',...
        'Position',[10 10 20 15]);  
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
clabel(A,l,'FontSize',12,'LabelSpacing',200);

%% *************************************************************** %%
gra_theta = linspace(0.1,20,1500)*pi/180;
wave_Lambda = 13.5*1e-9;
% wave_Lambda = linspace(0.2,30,6000)*1e-9;
phot_Energy = c_Speed*h_Plank./(wave_Lambda*e_Charge);
Grazing_str1 = Furion_grazing_incident(gra_theta,phot_Energy,'Pt',path_Str,1);
Grazing_str2 = Furion_grazing_incident(gra_theta,phot_Energy,'Au',path_Str,1);
Grazing_str3 = Furion_grazing_incident(gra_theta,phot_Energy,'Ni',path_Str,1);
Grazing_str4 = Furion_grazing_incident(gra_theta,phot_Energy,'Ru',path_Str,1);
Grazing_str5 = Furion_grazing_compound(gra_theta,phot_Energy,'B4C',path_Str,1);

figure
plot(gra_theta*180/pi,Grazing_str1.R_intensity,'LineWidth',2,'Color',[.494 .184 .557])        
hold on
plot(gra_theta*180/pi,Grazing_str2.R_intensity,'LineWidth',2,'Color',[0.870, 0.490, 0])
hold on
plot(gra_theta*180/pi,Grazing_str3.R_intensity,'LineWidth',2,'Color',[.078 .169 .549])
hold on
plot(gra_theta*180/pi,Grazing_str4.R_intensity,'LineWidth',2,'Color',[0 0.498 0])
hold on
plot(gra_theta*180/pi,Grazing_str5.R_intensity,'LineWidth',2,'Color',[1 0 0])
ylabel('Reflectivity','interpreter','latex','FontSize',22);
xlabel('Grazing incident angle [deg]','interpreter','latex','FontSize',22);

set(gcf,'InvertHardcopy','off','Color',[1 1 1],'Units','centimeters',...
        'Position',[10 10 20 15]);  
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',3);
legend({'Pt','Au','Ni','Ru','B$_4$C'},'Interpreter','latex','fontsize',18,'linewidth',1);
strings={'Wavelength: 13.5nm'};
annotation('textbox',[0.3,0.7,0.1,0.1],'LineStyle','-','interpreter',...
           'latex','LineWidth',1,'String',strings,'FontSize',18)
%% *************************************************************** %%
%                          polarization sigma  pi                         % 
gra_theta = 4.5*pi/180;
wave_Lambda = linspace(0.2,15,3000)*1e-9;
phot_Energy = c_Speed*h_Plank./(wave_Lambda*e_Charge);
Grazing_str1 = Furion_grazing_incident(gra_theta,phot_Energy,'Ru',path_Str,1);
Grazing_str2 = Furion_grazing_incident(gra_theta,phot_Energy,'Ru',path_Str,2);

figure
plot(wave_Lambda/1e-9,Grazing_str1.R_intensity,'LineWidth',2,'Color',[0 0.498 0])        
hold on
plot(wave_Lambda/1e-9,Grazing_str2.R_intensity,'LineWidth',2,'Color',[0.870, 0.490, 0])
title('Coating: Ru','interpreter','latex','FontSize',22);
ylabel('Reflectivity','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'InvertHardcopy','off','Color',[1 1 1],'Units','centimeters',...
        'Position',[10 10 20 15]);  
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',3);
legend({'$\sigma$ polarization','$\pi$ polarization'},'Interpreter',...
        'latex','fontsize',18,'linewidth',1);
strings={'Grazing incident angle: 4.5$^\circ$'};
annotation('textbox',[0.3,0.7,0.1,0.1],'LineStyle','-','interpreter',...
           'latex','LineWidth',1,'String',strings,'FontSize',18)
figure;
plot(wave_Lambda/1e-9,Grazing_str1.R_phase,'LineWidth',2,'Color',[0 0.498 0])        
hold on
plot(wave_Lambda/1e-9,Grazing_str2.R_phase,'LineWidth',2,'Color',[0.870, 0.490, 0])

ylabel('Phase shift','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'InvertHardcopy','off','Color',[1 1 1],'Units','centimeters',...
        'Position',[10 10 20 15]);  
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',3);
legend({'$\sigma$ polarization','$\pi$ polarization'},'Interpreter',...
        'latex','fontsize',18,'linewidth',1);
strings={'Grazing incident angle: 4.5$^\circ$'};
annotation('textbox',[0.3,0.7,0.1,0.1],'LineStyle','-','interpreter',...
           'latex','LineWidth',1,'String',strings,'FontSize',18)
%% *************************************************************** %%
gra_theta = linspace(0,20,2000)*pi/180;
wave_Lambda = 13.5*1e-9;
phot_Energy = c_Speed*h_Plank./(wave_Lambda*e_Charge);
Grazing_str1 = Furion_grazing_incident(gra_theta,phot_Energy,'Ru',path_Str,1);
Grazing_str2 = Furion_grazing_incident(gra_theta,phot_Energy,'Ru',path_Str,2);

figure
plot(gra_theta*180/pi,Grazing_str1.R_intensity,'LineWidth',2,'Color',[0 0.498 0])        
hold on
plot(gra_theta*180/pi,Grazing_str2.R_intensity,'LineWidth',2,'Color',[0.870, 0.490, 0])
title('Coating: Ru','interpreter','latex','FontSize',22);
ylabel('Reflectivity','interpreter','latex','FontSize',22);
xlabel('Grazing angle [deg]','interpreter','latex','FontSize',22);
set(gcf,'InvertHardcopy','off','Color',[1 1 1],'Units','centimeters',...
        'Position',[10 10 20 15]);  
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',3);
legend({'$\sigma$ polarization','$\pi$ polarization'},'Interpreter',...
        'latex','fontsize',18,'linewidth',1);
strings={'Wavelength: 13.5 nm'};
annotation('textbox',[0.3,0.7,0.1,0.1],'LineStyle','-','interpreter',...
           'latex','LineWidth',1,'String',strings,'FontSize',18)
figure;
plot(gra_theta*180/pi,Grazing_str1.R_phase,'LineWidth',2,'Color',[0 0.498 0])        
hold on
plot(gra_theta*180/pi,Grazing_str2.R_phase,'LineWidth',2,'Color',[0.870, 0.490, 0])
title('Coating: Ru','interpreter','latex','FontSize',22);
ylabel('Phase shift','interpreter','latex','FontSize',22);
xlabel('Grazing angle [deg]','interpreter','latex','FontSize',22);
set(gcf,'InvertHardcopy','off','Color',[1 1 1],'Units','centimeters',...
        'Position',[10 10 20 15]);  
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',3);
legend({'$\sigma$ polarization','$\pi$ polarization'},'Interpreter',...
        'latex','fontsize',18,'linewidth',1);
strings={'Wavelength: 13.5 nm'};
annotation('textbox',[0.3,0.7,0.1,0.1],'LineStyle','-','interpreter',...
           'latex','LineWidth',1,'String',strings,'FontSize',18)



