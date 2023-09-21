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

atomic_sym1  = 'Mo';
atomic_sym2  = 'Si';

phot_Energy  = 87;               % [eV]
thick1 =4.5e-9;
thick2 = 3e-9;

thickness= 10e-6;
ang_asymmetry= -30;
scan_range   = 8;


flag = 2;
delta_theta = 0;
deltad_d = 0;


multilayer_chi_str = Furion_multilayer_chi(phot_Energy,thick1,thick2,atomic_sym1,atomic_sym2,path_Str);
[de_Xaxis,R0_amplitud,RH_amplitud,I0_intensity,IH_intensity] = Furion_multilayer_reflection(multilayer_chi_str,delta_theta,deltad_d,thickness,ang_asymmetry,scan_range,flag);


figure;plot(de_Xaxis+phot_Energy,IH_intensity,'r')
%figure;plot(de_Xaxis/pi*180+63.281,IH_intensity,'r')
%figure;plot(de_Xaxis+phot_Energy,I0_intensity,'r')
ylabel('Reflectivity','interpreter','latex','FontSize',22);
%ylabel('Transmissivity','interpreter','latex','FontSize',22);
xlabel('Photon energy [eV]','interpreter','latex','FontSize',22);
set(get(gca,'Children'),'linewidth',2);
set(gcf,'InvertHardcopy','off','Color',[1 1 1],'Units','centimeters',...
        'Position',[10 10 20 15]);  
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
strings={'Mo-Si multilayer period: 7.5nm thickness of Mo: 4.5nm thickness of Si: 3.0nm '};
annotation('textbox',[0.3,0.7,0.1,0.1],'LineStyle','-','interpreter',...
           'latex','LineWidth',1,'String',strings,'FontSize',18)
%legend({'Thermal 1.24W','3$\sigma$ beam','Crystal edge'},'Interpreter','latex','fontsize',18,'linewidth',1);
%xlim([4999.5 5000.5])
%title('My Title','interpreter','latex','FontSize',22)