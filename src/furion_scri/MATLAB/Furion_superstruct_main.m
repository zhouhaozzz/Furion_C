%% ************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen
%
% This script aim to calculate the perfect crystal diffraction, including 
% Bragg diffraction and Laue diffraction. 
%
% Input: 
%
%% ************************************************************** %%  
format long
clear;clc;
Furion_physical_constants;
path_Str = Furion_filepath();
addpath(genpath(pwd));
%% ************************************************************** %%
atomic_sym  = 'Si';
phot_Energy  = 5000;               % [eV]
thick = 10e-10;
period = 20e-10;
thickness= 10e-6;
ang_asymmetry= 0;
scan_range   = 15;
flag = 2;
delta_theta = 0;
deltad_d = 0;
%% ************************************************************** %%
superstruct_chi_str = Furion_superstruct_chi(phot_Energy,thick,period,atomic_sym,path_Str);
[de_Xaxis,R0_amplitud,RH_amplitud,I0_intensity,IH_intensity] = Furion_multilayer_reflection(superstruct_chi_str,delta_theta,deltad_d,thickness,ang_asymmetry,scan_range,flag);


figure;plot(de_Xaxis,IH_intensity,'r')
%figure;plot(de_Xaxis/pi*180+63.281,IH_intensity,'r')
%figure;plot(de_Xaxis+phot_Energy,I0_intensity,'r')
ylabel('Reflectivity','interpreter','latex','FontSize',22);
%ylabel('Transmissivity','interpreter','latex','FontSize',22);
xlabel('Photon energy [eV]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 20 15]);
set(gca,'TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
%legend({'Thermal 1.24W','3$\sigma$ beam','Crystal edge'},'Interpreter','latex','fontsize',18,'linewidth',1);
%xlim([4999.5 5000.5])
%title('My Title','interpreter','latex','FontSize',22)