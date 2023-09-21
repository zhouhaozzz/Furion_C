function S3FEL_mirror_reflectivity_FEL4()
%% *************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen

% This function is aim to calculate the reflectivity of mirrors of FEL-3 
% with different coating.

%% *************************************************************** %%
format long
clear;clc;
path_Str = Furion_filepath();
addpath(genpath(pwd));
Furion_physical_constants;

%% *************************************************************** %%
gra_theta = 20e-3;
wave_Lambda = linspace(0.2,30,6000)*1e-9;
phot_Energy = c_Speed*h_Plank./(wave_Lambda*e_Charge);
Grazing_str1 = Furion_grazing_incident(gra_theta,phot_Energy,'Au',path_Str,1);
Grazing_str2 = Furion_grazing_incident(gra_theta,phot_Energy,'Ru',path_Str,1);
Grazing_str3 = Furion_grazing_compound(gra_theta,phot_Energy,'B4C',path_Str,1);
Grazing_str4 = Furion_grazing_compound(gra_theta,phot_Energy,'C',path_Str,1);

figure
subplot(1,2,1);
plot(wave_Lambda/1e-9,Grazing_str1.R_intensity)        
hold on
plot(wave_Lambda/1e-9,Grazing_str2.R_intensity)
hold on
plot(wave_Lambda/1e-9,Grazing_str3.R_intensity)
hold on
plot(wave_Lambda/1e-9,Grazing_str4.R_intensity)

ylabel('Reflectivity','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',3);
legend({'Au','Ru','B4C','$\alpha$-C'},'Interpreter','latex','fontsize',18,'linewidth',1);
strings={'(a)'};
strings={'Grazing incident angle: 20 mrad'};
annotation('textbox',[0.3,0.7,0.1,0.1],'LineStyle','-','interpreter',...
           'latex','LineWidth',1,'String',strings,'FontSize',18)
hold on
plot(linspace(-0.5,30,3000),ones(1,3000)*0.9)

gra_theta = 20e-3;
gra_theta1 = 10e-3;
Grazing_str5 = Furion_grazing_incident(gra_theta1,phot_Energy,'C',path_Str,1);
Grazing_str6 = Furion_grazing_compound(gra_theta1,phot_Energy,'B4C',path_Str,1);
Grazing_str7 = Furion_grazing_incident(gra_theta,phot_Energy,'C',path_Str,1);
Grazing_str8 = Furion_grazing_compound(gra_theta,phot_Energy,'B4C',path_Str,1);
subplot(1,2,2);
plot(wave_Lambda/1e-9,Grazing_str5.R_intensity)        
hold on
plot(wave_Lambda/1e-9,Grazing_str6.R_intensity)
hold on
plot(wave_Lambda/1e-9,Grazing_str7.R_intensity)
hold on
plot(wave_Lambda/1e-9,Grazing_str8.R_intensity)
ylabel('Reflectivity','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 18 15]);
set(gca,'TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',3);
legend({'Ni 8.7mrad','B4C 8.7mrad','Ni 14mrad','B4C 14mrad'},'Interpreter',...
        'latex','fontsize',18,'linewidth',1);
hold on
plot(linspace(-1,7,3000),ones(1,3000)*0.9)
%% *************************************************************** %%
gra_theta2 = linspace(5,30,1300)'*1e-3;
wave_Lambda = linspace(0.2,30,1300)*1e-9;
phot_Energy = c_Speed*h_Plank./(wave_Lambda*e_Charge);
[E_p,G_a] = meshgrid(phot_Energy,gra_theta2);
W_l = c_Speed*h_Plank./(E_p*e_Charge);

Grazing_str9 = Furion_grazing_incident(G_a,E_p,'Ni',path_Str,1);
Grazing_str10 = Furion_grazing_compound(G_a,E_p,'C',path_Str,1);
figure;
subplot(1,2,2)
surf(W_l/1e-9,G_a/1e-3,Grazing_str9.R_intensity)
shading interp
ylabel('Grazing angle [mrad]','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
box on
view(2)
subplot(1,2,2)
surf(W_l/1e-9,G_a/1e-3,Grazing_str10.R_intensity)
shading interp
ylabel('Grazing angle [mrad]','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
colorbar('FontSize',8);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
box on
view(2)
%% *************************************************************** %%
gra_theta = linspace(0.1,15,200)*pi/180;
wave_Lambda = [5,10,15,20,25,30]*1e-9;
phot_Energy = c_Speed*h_Plank./(wave_Lambda*e_Charge);
Grazing_str1 = Furion_grazing_compound(gra_theta,phot_Energy(1),'C',path_Str,1);
Grazing_str2 = Furion_grazing_compound(gra_theta,phot_Energy(2),'C',path_Str,1);
Grazing_str3 = Furion_grazing_compound(gra_theta,phot_Energy(3),'C',path_Str,1);
Grazing_str4 = Furion_grazing_compound(gra_theta,phot_Energy(4),'C',path_Str,1);
Grazing_str5 = Furion_grazing_compound(gra_theta,phot_Energy(5),'C',path_Str,1);
Grazing_str6 = Furion_grazing_compound(gra_theta,phot_Energy(6),'C',path_Str,1);
figure;
subplot(1,2,1)
plot(gra_theta*180/pi,Grazing_str1.R_intensity)
hold on
plot(gra_theta*180/pi,Grazing_str2.R_intensity)
hold on
plot(gra_theta*180/pi,Grazing_str3.R_intensity)
hold on
plot(gra_theta*180/pi,Grazing_str4.R_intensity)
hold on
plot(gra_theta*180/pi,Grazing_str5.R_intensity)
hold on
plot(gra_theta*180/pi,Grazing_str6.R_intensity)
ylabel('Reflectivity','interpreter','latex','FontSize',22);
xlabel('Grazing angle [deg]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',3);
legend({'5 nm','10 nm','15 nm','20 nm','25 nm','30 nm'},'Interpreter',...
        'latex','fontsize',18,'linewidth',1);