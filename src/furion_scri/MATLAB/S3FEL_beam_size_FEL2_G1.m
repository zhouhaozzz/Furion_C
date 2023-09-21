function  S3FEL_beam_size_FEL2_G1()
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
format long
FWHM = [157.5,157.5,157.5,157.5,157.5,157.5]*1e-6;
theta = [6.4,8.5,16.8,25.2,30,42]*1e-6;
wave_Lambda = [2.3,3,6,9,13.5,15]*1e-9;
L_distance = 92;
L_source = 40;

[out_SigmaI,sigma_WaistI,f_Rayleigh] = Furion_gauss_Inverse_propa ...
                              (FWHM,theta,L_distance,L_source,wave_Lambda,2);


%% *************************************************************** %%
%                          plot beam size at G1

figure;
subplot(1,2,1)
plot(wave_Lambda*1e9,2*out_SigmaI*1e3)      % 2sigma
hold on
plot(wave_Lambda*1e9,4*out_SigmaI*1e3)      % 4sigma
hold on
plot(wave_Lambda*1e9,6*out_SigmaI*1e3)      % 6sigma
ylabel('Beam size$@$M1 [mm]','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
legend({'2*$\sigma_{beam}$','4*$\sigma_{beam}$','6*$\sigma_{beam}$'}...
       ,'Interpreter','latex','fontsize',18,'linewidth',1);
strings={'(a)'};
annotation('textbox',[0.3,0.7,0.1,0.1],'LineStyle','-','interpreter',...
           'latex','LineWidth',1,'String',strings,'FontSize',18)
%n = linspace(10,200,300)*1e3;        % line density
N_total = out_SigmaI*2.355*50e3;
delta_t = N_total.*1*wave_Lambda./c_Speed;
%% *************************************************************** %%

C_ff = linspace(1,10,1000);
wave_lambda = 13.5e-9;
n_Density = 150e3;
m_Order =1;
r_Entrance = 132;
r_Exit = 83;
% sigma_waist = interp1(wave_Lambda,sigma_WaistI,wave_lambda);
% s_Source = sigma_waist*2.355;
s_Source = sigma_WaistI(5)*2.355;
ferror_M = 100e-9;
ferror_G = 100e-9;
s_Ex_slit = 50e-6;
n_Total = 20e3;
[alpha,beta,r_G_mono,b2,b3,blaz,r_Source,r_FerrorM,r_FerrorG,r_Ex_slit,r_D_limit] ...
    = VLS_PGM_cal(wave_lambda,n_Density,m_Order,C_ff,r_Entrance,r_Exit,...
    s_Source,ferror_M,ferror_G,s_Ex_slit,n_Total);
figure
subplot(1,2,2)
plot(C_ff,r_G_mono)
hold on;plot(C_ff,r_FerrorG)
hold on;plot(C_ff,r_FerrorM)
hold on;plot(C_ff,r_Source)
hold on;plot(C_ff,r_Ex_slit)
hold on;plot(C_ff,r_D_limit)
ylabel('Energy resolution $\Delta\lambda/\lambda$','interpreter','latex','FontSize',22);
xlabel('$C_{ff}$','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
 legend({'Resolution total','Grating slop','Mirror slop','Source','Slit',...
        'Diffraction'},'Interpreter','latex','fontsize',18,'linewidth',1);

figure;
subplot(1,2,1)
plot(C_ff,alpha)
hold on;
plot(C_ff,beta)

% hold on;
% plot(C_ff,blaz)
ylabel('Angle [deg]','interpreter','latex','FontSize',22);
xlabel('$C_{ff}$','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
legend({'alpha','beta'},'Interpreter','latex','fontsize',18,'linewidth',1);
subplot(1,2,2)
plot(C_ff,blaz)
hold on
plot(C_ff,90-alpha)
hold on
plot(C_ff,90-alpha+blaz)
hold on;
plot(C_ff,90-beta)
ylabel('Angle [deg]','interpreter','latex','FontSize',22);
xlabel('$C_{ff}$','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
legend({'Bazed angle','$90^\circ- \alpha$'},'Interpreter','latex',...
        'fontsize',18,'linewidth',1);

strings={'N = 150 $1/mm$'};
annotation('textbox',[0.3,0.7,0.1,0.1],'LineStyle','-','interpreter',...
           'latex','LineWidth',1,'String',strings,'FontSize',18)

%% *************************************************************** %%
%                 pulse stretching @ resolution @ grazing angle
c_Speed  = 299792458;              % speed of light[m/sec]
FWHM = [157.5,157.5,157.5,157.5,157.5,157.5]*1e-6;
theta = [6.4,8.5,16.8,25.2,30,42]*1e-6;
wave_Lambda = [2.3,3,6,9,13.5,15]*1e-9;
L_distance = 92;
L_source = 40;


[out_SigmaI,sigma_WaistI,f_Rayleigh] = Furion_gauss_Inverse_propa ...
                              (FWHM,theta,L_distance,L_source,wave_Lambda,2);
C_ff = 2;
n_Density = 150e3;
m_Order =1;
r_Entrance = 132;
r_Exit = 82;
s_Source = sigma_WaistI*2.355;
ferror_M = 100e-9;
ferror_G = 100e-9;
s_Ex_slit = 20e-6;
n_Total = 60e3;
[alpha,beta,r_G_mono,b2,b3,blaz,r_Source,r_FerrorM,r_FerrorG,r_Ex_slit,r_D_limit] ...
    = VLS_PGM_cal(wave_Lambda,n_Density,m_Order,C_ff,r_Entrance,r_Exit,...
    s_Source,ferror_M,ferror_G,s_Ex_slit,n_Total);

footprint = out_SigmaI*6./(sind(90-alpha));
n_total = out_SigmaI*2.355./(sind(90-alpha))*n_Density;
delta_t = n_total*1.*wave_Lambda./c_Speed;


subplot(1,2,2);plot(wave_Lambda*1e9,delta_t*1e12)
hold on
ylabel('$\Delta \tau$ [ps]','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
%legend({'150 mm$^{-1}$','150 mm$^{-1}$'},'Interpreter','latex','fontsize',18,'linewidth',1);
subplot(1,2,1);plot(wave_Lambda*1e9,out_SigmaI*2.355*1e3)
ylabel('Beam size@G1G2 (FWHM) [mm]','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
strings={'(a)'};
annotation('textbox',[0.3,0.7,0.1,0.1],'LineStyle','-','interpreter',...
           'latex','LineWidth',1,'String',strings,'FontSize',18)
figure;
subplot(1,2,1)
plot(wave_Lambda*1e9,1./r_G_mono)

ylabel('Resolving power $\lambda/\Delta\lambda$','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
 legend({'50 mm$^{-1}$ C$_{ff}=1.8$','150$\quad$mm$^{-1}$ C$_{ff}=2$'},...
         'Interpreter','latex','fontsize',18,'linewidth',1);
subplot(1,2,2)
plot(wave_Lambda*1e9,blaz)
hold on
plot(wave_Lambda*1e9,90-alpha)
ylabel('Grazing angle of Grating [deg] ','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
 legend({'150 mm$^{-1}$ C$_{ff}=2.0$','50$\quad$mm$^{-1}$ C$_{ff}=1.8$'},...
         'Interpreter','latex','fontsize',18,'linewidth',1);
strings={'(a)'};
annotation('textbox',[0.3,0.7,0.1,0.1],'LineStyle','-','interpreter',...
           'latex','LineWidth',1,'String',strings,'FontSize',18)

figure;plot(wave_Lambda*1e9,(180-(alpha+beta))/2)
ylabel('Grazing angle of M5c [deg] ','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 18 15]);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
legend({'150 mm$^{-1}$ C$_{ff}=2.0$','50$\quad$mm$^{-1}$ C$_{ff}=1.8$'},...
        'Interpreter','latex','fontsize',18,'linewidth',1);

subplot(1,2,2);
plot(wave_Lambda*1e9,footprint*1e3)
hold on
plot(wave_Lambda*1e9,footprint*1e3*4/6)
hold on
plot(wave_Lambda*1e9,footprint*1e3*2/6)
ylabel('Footprint [mm] ','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
legend({'6$\sigma$ beam','4$\sigma$ beam','2$\sigma$ beam'},...
'Interpreter','latex','fontsize',18,'linewidth',1);