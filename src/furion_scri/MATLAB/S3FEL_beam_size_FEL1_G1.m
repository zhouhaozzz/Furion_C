function  S3FEL_beam_size_FEL1_G1()
%% ******************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen

% This function is used to calculate the beam parameters at M1
% 
% Modification history
%     04-19-2021 written by C. Yang.

%% *************************************************************** %%
%                               at M1
path = 'E:\深圳粒子院\深圳FEL光束线\束线设计报告\FEL-1光束线\FEL1光束线图片\可研报告20211008';
format long
FWHM = [221,305,366,411,447]*1e-6;
theta = [3.9,5.1,6.4,7.9,9.1]*1e-6;
wave_Lambda = [1,1.55,2,2.5,3]*1e-9;
L_distance = 202;
L_source = 15;

[out_SigmaI,sigma_WaistI,f_Rayleigh] = Furion_gauss_Inverse_propa ...
                              (FWHM,theta,L_distance,L_source,wave_Lambda,1);

%% *************************************************************** %%

C_ff = linspace(1,10,100);
wave_lambda = 1.24e-9;
n_Density = 230e3;
m_Order =1;
r_Entrance = 217;
r_Exit = 108;
sigma_waist = interp1(wave_Lambda,sigma_WaistI,wave_lambda);
s_Source = sigma_waist*2.355;
ferror_M = 100e-9;
ferror_G = 100e-9;
s_Ex_slit = 10e-6;
n_Total = 40e3;
[alpha,beta,r_G_mono,b2,b3,blaz,r_Source,r_FerrorM,r_FerrorG,r_Ex_slit,r_D_limit] ...
    = VLS_PGM_cal(wave_lambda,n_Density,m_Order,C_ff,r_Entrance,r_Exit,...
    s_Source,ferror_M,ferror_G,s_Ex_slit,n_Total);

%% *************************************************************** %%
%                        plot resolution VS Cff                           %
figure(1)
semilogy(C_ff,r_G_mono,'LineWidth',2,'Color',[0 0.498 0])
hold on;semilogy(C_ff,r_FerrorG,'LineWidth',2,'Color',[1 0 0])
hold on;semilogy(C_ff,r_FerrorM,'LineWidth',2,'Color',[.078 .169 .549])
hold on;semilogy(C_ff,r_Source,'LineWidth',2,'Color',[.494 .184 .557])
hold on;semilogy(C_ff,r_Ex_slit,'LineWidth',2,'Color',[0.870 0.490 0])
hold on;semilogy(C_ff,r_D_limit)
ylabel('Energy resolution $\Delta\lambda/\lambda$','interpreter','latex','FontSize',22);
xlabel('$C_{ff}$','interpreter','latex','FontSize',22);
xlim([1 10])
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
set(gcf,'InvertHardcopy','off','Color',[1 1 1],'Units','centimeters',...
        'Position',[10 10 20 15]);
legend({'Resolution total','Grating slop','Mirror slop','Source','Slit',...
        'Diffraction'},'Interpreter','latex','fontsize',18,'linewidth',1);
print(gcf,'-djpeg','-r300',[path,'\FEL1_reso_Cff_G.jpg'])

%% *************************************************************** %%
%               plot grazing angle and blazed angle VS Cff                %
figure(2);
plot(C_ff,blaz,'LineWidth',2,'Color',[0 0.498 0])
hold on;
plot(C_ff,90-alpha,'LineWidth',2,'Color',[1 0 0])
ylabel('Angle [deg]','interpreter','latex','FontSize',22);
xlabel('$C_{ff}$','interpreter','latex','FontSize',22);
xlim([1 10])
ylim([0 1])
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
set(gcf,'InvertHardcopy','off','Color',[1 1 1],'Units','centimeters',...
        'Position',[10 10 20 15]);
legend({'Blazed angle','$90^\circ-$ alpha'},'Interpreter','latex',...
        'fontsize',18,'linewidth',1);
print(gcf,'-djpeg','-r300',[path,'\FEL1_blazed_Angle_Cff.jpg'])
    
%% *************************************************************** %%
%                 pulse stretching @ resolution @ grazing angle
c_Speed  = 299792458;              % speed of light[m/sec]
FWHM = [221,305,366,411,447]*1e-6;
theta = [3.9,5.1,6.4,7.9,9.1]*1e-6;
wave_Lambda = [1,1.55,2,2.5,3]*1e-9;
L_distance = 202;
L_source = 15;

[out_SigmaI,sigma_WaistI,f_Rayleigh] = Furion_gauss_Inverse_propa ...
                              (FWHM,theta,L_distance,L_source,wave_Lambda,1);
alpha = [89.633647775033694  89.543910439640669  89.481931276445863  89.420799203016244  89.365536645590765]
C_ff = 3.5;
n_Density = 230e3;
m_Order =1;
r_Entrance = 217;
r_Exit = 108;
s_Source = sigma_WaistI*2.355;
ferror_M = 100e-9;
ferror_G = 100e-9;
s_Ex_slit = 10e-6;
n_Total = 4*out_SigmaI*n_Density./sind(90-alpha);
[alpha,beta,r_G_mono,b2,b3,blaz,r_Source,r_FerrorM,r_FerrorG,r_Ex_slit,r_D_limit] ...
    = VLS_PGM_cal(wave_Lambda,n_Density,m_Order,C_ff,r_Entrance,r_Exit,...
    s_Source,ferror_M,ferror_G,s_Ex_slit,n_Total);
footprint = out_SigmaI*4./(sind(90-alpha));                  % 4σ
n_total = out_SigmaI*2.355./(sind(90-alpha))*n_Density;
delta_t = n_total*1.*wave_Lambda./c_Speed;

%% *************************************************************** %%
%                    plot pulse stretching VS wavelength                  %
figure3 = figure(3);
subplot1 = subplot(1,2,1);
plot(wave_Lambda*1e9,out_SigmaI*2.355*1e3,'MarkerFaceColor',[0 0.498 0],...
    'MarkerSize',10,'Marker','diamond','LineWidth',2,'Color',[0 0.498 0])
ylabel('Beam size@G1G2 (FWHM) [mm]','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
xlim(subplot1,[1 3]);
ylim(subplot1,[.5 2]);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
set(gcf,'InvertHardcopy','off','Color',[1 1 1],'Units','centimeters',...
        'Position',[10 10 40 15]);

subplot2 = subplot(1,2,2);
plot(wave_Lambda*1e9,delta_t*1e15,'MarkerFaceColor',[1 0 0],...
    'MarkerSize',10,'Marker','diamond','LineWidth',2,'Color',[1 0 0])
ylabel('$\Delta \tau$ [fs]','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
xlim(subplot2,[1 3]);
ylim(subplot2,[50 300]);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
set(gcf,'InvertHardcopy','off','Color',[1 1 1],'Units','centimeters',...
        'Position',[10 10 40 15]);
annotation(figure3,'textbox',[0.160 0.807 0.040 0.068],'String',{'(a)'},...
    'LineWidth',1,'Interpreter','latex',...
    'FontSize',18,'EdgeColor',[1 1 1]);
annotation(figure3,'textbox',[0.600 0.807 0.040 0.068],'String',{'(b)'},...
    'LineWidth',1,'Interpreter','latex',...
    'FontSize',18,'EdgeColor',[1 1 1]);
print(gcf,'-djpeg','-r300',[path,'\FEL1_pulse_Streching_G.jpg'])    
    
%% *************************************************************** %%
%                        plot angle VS wavelength                         %
figure4 = figure(4); 
subplot3 = subplot(1,2,1);
plot(wave_Lambda*1e9,alpha,'MarkerFaceColor',[0 0.498 0],...
    'MarkerSize',10,'Marker','diamond','LineWidth',2,'Color',[0 0.498 0])
hold on
plot(wave_Lambda*1e9,beta,'MarkerFaceColor',[1 0 0],...
    'MarkerSize',10,'Marker','diamond','LineWidth',2,'Color',[1 0 0])
ylabel('Angle [deg] ','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
xlim(subplot3,[1 3]);
ylim(subplot3,[88 90]);
legend({'$\alpha$','$\beta$'},'Interpreter','latex','fontsize',18,'linewidth',1);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
set(gcf,'InvertHardcopy','off','Color',[1 1 1],'Units','centimeters',...
        'Position',[10 10 40 15]);

subplot4 = subplot(1,2,2);
plot(wave_Lambda*1e9,(180-(alpha+beta))/2,'MarkerFaceColor',[1 0 0],...
    'MarkerSize',10,'Marker','diamond','LineWidth',2,'Color',[1 0 0])
ylabel('Grazing angle of M5 [deg] ','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
xlim(subplot4,[1 3]);
ylim(subplot4,[0 2]);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
set(gcf,'InvertHardcopy','off','Color',[1 1 1],'Units','centimeters',...
        'Position',[10 10 40 15]);
annotation(figure4,'textbox',[0.160 0.807 0.040 0.068],'String',{'(a)'},...
    'LineWidth',1,'Interpreter','latex',...
    'FontSize',18,'EdgeColor',[1 1 1]);
annotation(figure4,'textbox',[0.600 0.807 0.040 0.068],'String',{'(b)'},...
    'LineWidth',1,'Interpreter','latex',...
    'FontSize',18,'EdgeColor',[1 1 1]);
print(gcf,'-djpeg','-r300',[path,'\FEL1_mono_Angle_G.jpg'])

%% *************************************************************** %%
%                        plot resolution VS Cff                           %
figure5 = figure(5);
subplot5 = subplot(1,2,1);
plot(wave_Lambda*1e9,1./r_G_mono,'MarkerFaceColor',[1 0 0],...
    'MarkerSize',10,'Marker','diamond','LineWidth',2,'Color',[1 0 0])
ylabel('Resolving power $\lambda/\Delta\lambda$','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
xlim(subplot5,[1 3]);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
set(gcf,'InvertHardcopy','off','Color',[1 1 1],'Units','centimeters',...
        'Position',[10 10 40 15]);

subplot6 = subplot(1,2,2);   
plot(wave_Lambda*1e9,footprint*1e3,'MarkerFaceColor',[0 0.498 0],...
    'MarkerSize',10,'Marker','diamond','LineWidth',2,'Color',[0 0.498 0])
ylabel('Footprint@4$\sigma$ [mm] ','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
xlim(subplot6,[1 3]);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
set(gcf,'InvertHardcopy','off','Color',[1 1 1],'Units','centimeters',...
        'Position',[10 10 40 15]);
annotation(figure5,'textbox',[0.160 0.807 0.040 0.068],'String',{'(a)'},...
    'LineWidth',1,'Interpreter','latex',...
    'FontSize',18,'EdgeColor',[1 1 1]);
annotation(figure5,'textbox',[0.600 0.807 0.040 0.068],'String',{'(b)'},...
    'LineWidth',1,'Interpreter','latex',...
    'FontSize',18,'EdgeColor',[1 1 1]);
print(gcf,'-djpeg','-r300',[path,'\FEL1_reso_footprint_G.jpg'])
