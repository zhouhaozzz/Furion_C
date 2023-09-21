function [] = S3FEL_herror_StrehlR_FEL4(N)
%% ******************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen

% This function is used to calculate the height error of optical mirror
% system by using Strehl Ratio.
% 
% Input:
%      N: number of optics
%
% Modification history
%     04-19-2021 written by C. Yang.
%% *************************************************************** %%
format long
N = 7;
x = linspace(5e-9,30e-9,300);    %  wavelength
y = linspace(5e-3,30e-3,300)';  %  grazing angle
[X,Y] = meshgrid(x,y);
h_error = X./(14*sqrt(N)*2*Y);

subplot(1,2,1);
meshz(X*1e9,Y*1e3,h_error*1e9)

ylabel('Grazing angle [$\mu$m]','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
strings={'nm'};
annotation('textbox',[0.3,0.7,0.1,0.1],'LineStyle','-','interpreter',...
           'latex','LineWidth',1,'String',strings,'FontSize',18)
box on;colorbar;
view(2)

x = linspace(5e-9,30e-9,300);    %  wavelength
y1 = 10e-3;                      %  grazing angle
y2 = 15e-3;                     %  grazing angle
y3 = 20e-3;                     %  grazing angle
h_error1 = x./(14*sqrt(N)*2*y1);
h_error2 = x./(14*sqrt(N)*2*y2);
h_error3 = x./(14*sqrt(N)*2*y3);

subplot(1,2,2);
plot(x*1e9,h_error1*1e9)
hold on;
plot(x*1e9,h_error2*1e9)
hold on;
plot(x*1e9,h_error3*1e9)
ylabel('Height error [nm]','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
legend({'$\alpha$ = 10 mrad','$\alpha$ = 15 mrad','$\alpha$ = 20 mrad'}...
       ,'Interpreter','latex','fontsize',18,'linewidth',1);