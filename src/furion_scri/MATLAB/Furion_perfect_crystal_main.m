%function [de_Xaxis,R0_amplitud,RH_amplitud,I0_intensity,IH_intensity] = Furion_perfect_crystal_main(atomic_sym,crystal_Sym,temperature,cry_thickness,cry_asymmetry,scan_range)
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

atomic_sym   = 'C';
crystal_Sym  = 'Diamond';
temperature  = 293;              % [K]
phot_Energy  = 8000;               % [eV]
miller_Str.h = 1;
miller_Str.k = 1;
miller_Str.l = 1;
cry_thickness= 30e-6;
cry_asymmetry= 0;
scan_range   = 5;
flag = 2;
delta_theta = 0;
deltad_d =0;

atomic_Str = Furion_atomic_read(atomic_sym,path_Str);
[crystal_Str,atomic_Posi] = Furion_crystal_read(crystal_Sym,path_Str);
%[crystal_Str_modify,deltad_d] = diamond_thermalexp(temperature,crystal_Str);
bragg_Str = Furion_bragg_cal(phot_Energy,crystal_Str,miller_Str);
formfactor_Str = Furion_formfactor_read(bragg_Str,atomic_sym,path_Str);
debye_Waller = Furion_Debyefactor_cal(bragg_Str,temperature,atomic_Str);
struc_Str = Furion_strucfactor_cal(formfactor_Str,debye_Waller,bragg_Str,atomic_Posi,miller_Str);
[de_Xaxis,R0_amplitud,RH_amplitud,I0_intensity,IH_intensity] = ...
    Furion_thin_Rocking(bragg_Str,delta_theta,deltad_d,struc_Str,cry_thickness,cry_asymmetry,scan_range,flag);

figure;plot(de_Xaxis+phot_Energy,IH_intensity,'r')
%figure;plot(de_Xaxis,IH_intensity,'r')
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