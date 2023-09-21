function S3FEL_system_efficiency_FEL3()
%% ******************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen

% This function is used to calculate the system efficiency of FEL-1
% 

%% ******************************************************************** %%
%                             M3c and M4c
format long
clear;clc;
Furion_physical_constants;
path_Str = Furion_filepath();
addpath(genpath(pwd));

%% *************************************************************** %%

wave_Lambda = linspace(0.2,15,2000)*1e-9;
phot_Energy = c_Speed*h_Plank./(wave_Lambda*e_Charge);
gra_theta1 = 8.73e-3;
Grazing_str1 = Furion_grazing_incident(gra_theta1,phot_Energy,'Ni',path_Str,1); % M1,M2
gra_theta2 = 17.45e-3;
Grazing_str2 = Furion_grazing_incident(gra_theta2,phot_Energy,'Ni',path_Str,1); % M3,M4


%% *************************************************************** %%
%                                                                %
reflectivity1 = (Grazing_str2.R_intensity).^8;    % 表面超快动力学催化研究实验站
reflectivity2 = (Grazing_str2.R_intensity).^7;    % 极紫外光刻

           
subplot(1,2,1);
plot(wave_Lambda*1e9,reflectivity1)
hold on
plot(wave_Lambda*1e9,reflectivity2)

ylabel('Reflectivity','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',3);
%legend({'表面超快动力学催化研究实验站和$//$星际化学实验站','极紫外掩膜实验站和$\\$极紫外光刻胶实验站',...
%        },'Interpreter',...
%        'latex','fontsize',18,'linewidth',1);
strings={'(a)'};
annotation('textbox',[0.3,0.7,0.1,0.1],'LineStyle','-','interpreter',...
           'latex','LineWidth',1,'String',strings,'FontSize',18)
%% *************************************************************** %%
reflectivity1 = (Grazing_str2.R_intensity).^8.*Efficiency/100;    % 表面超快动力学催化研究实验站
reflectivity2 = (Grazing_str2.R_intensity).^7.*Efficiency/100;    % 极紫外光刻
        
subplot(1,2,2);
plot(wave_Lambda*1e9,reflectivity1)
hold on
plot(wave_Lambda*1e9,reflectivity2)
% hold on
% plot(wave_Lambda*1e9,reflectivity3)
ylabel('Reflectivity','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',3);
legend({'生物大分子质谱实验站','雾霾研究实验站',...
        '表面散射动力学实验站'},'Interpreter',...
        'latex','fontsize',18,'linewidth',1);