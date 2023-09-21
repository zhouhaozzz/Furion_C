format long
FWHM = [221,305,366,411,447]*1e-6;
theta = [3.9,5.1,6.4,7.9,9.1]*1e-6;
wave_Lambda = [1,1.55,2,2.5,3]*1e-9;
L_distance = 137;
L_source = 80;

[out_SigmaI,sigma_WaistI,f_Rayleigh] = Furion_gauss_Inverse_propa ...
                              (FWHM,theta,L_distance,L_source,wave_Lambda,1);

%% *************************************************************** %%
%    Theoretical grating resolution, if the grating is illuminated by 4¦Ò
len_Grating = 300;        % mm
n_Density = 150e3;        % l/mm
reso_Grating =  300*n_Density;

%% *************************************************************** %%
%    Angle setting for an optimum 4¦Ò illumination of a 300 mm
c_Speed  = 299792458;              % speed of light[m/sec]
r_mi = 216;
r_mi_p = 138;
grazing_G = asin(4*out_SigmaI/(len_Grating*1e-3));
alpha_G = 90 - grazing_G*180/pi;
beta_G = asin(sind(alpha_G)-n_Density*wave_Lambda)*180/pi;
theta_M = (180-(alpha_G+beta_G))/2;          % grazing angle of pre-mirror
C_ff = cosd(beta_G)./cosd(alpha_G);
R_meridian = 2./(1./r_mi+1./r_mi_p)./(sind(theta_M)); % radius of pre-mirror
n_total = out_SigmaI*2.355./(sind(90-alpha_G))*n_Density;
delta_t = n_total*1.*wave_Lambda./c_Speed;
R_4sigma = out_SigmaI*4./(sind(90-alpha_G))*n_Density;

figure;
plot(wave_Lambda*1e9,delta_t*1e15)
hold on;
plot(wave_Lambda*1e9,delta_t*4/2.355*1e15)
ylabel('$\Delta\tau$ [fs]','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 20 15]);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
legend({'4*$\sigma_{beam}$','FWHM'}...
       ,'Interpreter','latex','fontsize',18,'linewidth',1);
strings={'(a)'};
annotation('textbox',[0.3,0.7,0.1,0.1],'LineStyle','-','interpreter',...
           'latex','LineWidth',1,'String',strings,'FontSize',18)

%% *************************************************************** %%
%                         Fix radius pre-mirror (grating work point 2nm)
alpha_3nm = 89.392360557591672;
beta_3nm = 88.176808178618899;
angle_In = alpha_3nm + beta_3nm;
alpha_G = asin(n_Density*wave_Lambda./2/cosd(angle_In/2))*180/pi + angle_In/2;
beta_G = -asin(n_Density*wave_Lambda./2/cosd(angle_In/2))*180/pi + angle_In/2;
theta_M = (180 - (alpha_G + beta_G))/2;
C_ff = cosd(beta_G)./cosd(alpha_G);
footprint = out_SigmaI*4./(sind(90-alpha_G));
reso_Grating =  footprint*n_Density;
n_total = out_SigmaI*2.355./(sind(90-alpha_G))*n_Density;
delta_t = n_total*1.*wave_Lambda./c_Speed;



n_Density = 150e3;
m_Order =1;
r_Entrance = -138;
r_Exit = 138;
s_Source = sigma_WaistI*2.355*138/217;
ferror_M = 100e-9;
ferror_G = 100e-9;
s_Ex_slit = 10e-6;
n_Total = n_total*4/2.355;
[alpha,beta,r_G_mono,b2,b3,blaz,r_Source,r_FerrorM,r_FerrorG,r_Ex_slit,r_D_limit] ...
    = VLS_PGM_cal(wave_Lambda,n_Density,m_Order,C_ff,r_Entrance,r_Exit,...
    s_Source,ferror_M,ferror_G,s_Ex_slit,n_Total);

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
wave_lambda = 1.24e-9;
n_Density = 150e3;
m_Order =1;
r_Entrance = 217;
r_Exit = 138;
sigma_waist = interp1(wave_Lambda,sigma_WaistI,wave_lambda);
s_Source = sigma_waist*2.355;
ferror_M = 100e-9;
ferror_G = 100e-9;
s_Ex_slit = 10e-6;
n_Total = 60e3;
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
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
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
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
legend({'Bazed angle','$90^\circ-$ alpha'},'Interpreter','latex','fontsize',18,'linewidth',1);

strings={'N = 150 $1/mm$'};
annotation('textbox',[0.3,0.7,0.1,0.1],'LineStyle','-','interpreter',...
           'latex','LineWidth',1,'String',strings,'FontSize',18)

%% *************************************************************** %%
%                 pulse stretching @ resolution @ grazing angle
c_Speed  = 299792458;              % speed of light[m/sec]
FWHM = [221,305,366,411,447]*1e-6;
theta = [3.9,5.1,6.4,7.9,9.1]*1e-6;
wave_Lambda = [1,1.55,2,2.5,3]*1e-9;
L_distance = 137;
L_source = 80;

[out_SigmaI,sigma_WaistI,f_Rayleigh] = Furion_gauss_Inverse_propa ...
                              (FWHM,theta,L_distance,L_source,wave_Lambda,1);
C_ff = 3;
n_Density = 150e3;
m_Order =1;
r_Entrance = 217;
r_Exit = 138;
s_Source = sigma_WaistI*2.355;
ferror_M = 100e-9;
ferror_G = 100e-9;
s_Ex_slit = 10e-6;
n_Total = 60e3;
[alpha,beta,r_G_mono,b2,b3,blaz,r_Source,r_FerrorM,r_FerrorG,r_Ex_slit,r_D_limit] ...
    = VLS_PGM_cal(wave_Lambda,n_Density,m_Order,C_ff,r_Entrance,r_Exit,...
    s_Source,ferror_M,ferror_G,s_Ex_slit,n_Total);

footprint = out_SigmaI*6./(sind(90-alpha));
n_total = out_SigmaI*2.355./(sind(90-alpha))*n_Density;
delta_t = n_total*1.*wave_Lambda./c_Speed;


subplot(1,2,2);plot(wave_Lambda*1e9,delta_t*1e15)
hold on
ylabel('$\Delta \tau$ [fs]','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
legend({'50 mm$^{-1}$','150 mm$^{-1}$'},'Interpreter','latex','fontsize',18,'linewidth',1);
subplot(1,2,1);plot(wave_Lambda*1e9,out_SigmaI*2.355*1e3)
ylabel('Beam size@G1G2 (FWHM) [mm]','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
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
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
 legend({'50 mm$^{-1}$ C$_{ff}=1.8$','150$\quad$mm$^{-1}$ C$_{ff}=6$'},'Interpreter','latex','fontsize',18,'linewidth',1);
subplot(1,2,2)
plot(wave_Lambda*1e9,90-alpha)
ylabel('Grazing angle of G1G2 [deg] ','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
 legend({'150 mm$^{-1}$ C$_{ff}=2.0$','50$\quad$mm$^{-1}$ C$_{ff}=1.8$'},'Interpreter','latex','fontsize',18,'linewidth',1);
strings={'(a)'};
annotation('textbox',[0.3,0.7,0.1,0.1],'LineStyle','-','interpreter',...
           'latex','LineWidth',1,'String',strings,'FontSize',18)

figure;plot(wave_Lambda*1e9,(180-(alpha+beta))/2)
ylabel('Grazing angle of M5c [deg] ','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 18 15]);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
legend({'150 mm$^{-1}$ C$_{ff}=2.0$','50$\quad$mm$^{-1}$ C$_{ff}=1.8$'},'Interpreter','latex','fontsize',18,'linewidth',1);

subplot(1,2,2);plot(wave_Lambda*1e9,footprint*1e3*4/6)
ylabel('Footprint@4$\sigma$ [mm] ','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
legend({'50$\quad$mm$^{-1}$ C$_{ff}=1.8$','150 mm$^{-1}$ C$_{ff}=6.0$'},'Interpreter','latex','fontsize',18,'linewidth',1);