function  S3FEL_beam_size_FEL4_M1()
%% ******************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen

% This function is used to calculate the beam parameters at M1
% 
% Modification history
%     04-19-2021 written by C. Yang.

%% *************************************************************** %%
format long
FWHM = [188,188,188,188,188,188]*1e-6;
theta = [12.4,23.4,35.2,46.9,58.6,69.7]*1e-6;
wave_Lambda = [5,10,15,20,25,30]*1e-9;
L_distance = 75;
L_source = 20;

[out_SigmaI,sigma_WaistI,f_Rayleigh] = Furion_gauss_Inverse_propa ...
                              (FWHM,theta,L_distance,L_source,wave_Lambda,2);
%% *************************************************************** %%
%                            plot FWHM at beam waist
subplot(1,2,1);
plot(wave_Lambda*1e9,sigma_WaistI*2.355*1e6)
ylabel('Source size (FWHM) [$\mu$m]','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
strings={'(a)'};
annotation('textbox',[0.3,0.7,0.1,0.1],'LineStyle','-','interpreter',...
           'latex','LineWidth',1,'String',strings,'FontSize',18)
%% *************************************************************** %%
%                          plot FWHM at undulator Exit    
subplot(1,2,2);
plot(wave_Lambda*1e9,FWHM*1e6)
ylabel('Beam size (FWHM)$@$Exit [$\mu$m]','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
%% *************************************************************** %%
%    beam size @M1£» Grazing angle for M1 being fully covered  at different wavelength
figure;
subplot(1,2,1);
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

subplot(1,2,2);
plot(wave_Lambda*1e9,6*out_SigmaI/0.8*1e3)      % 2sigma
ylabel('Grazing angle$@$M1 [mm]','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
   
%% *************************************************************** %%
%                         footprint on M1 and M2

figure;
subplot(1,2,2);
plot(wave_Lambda(1:3)*1e9,2*out_SigmaI(1:3)*1e3/sin(10e-3))      % 2sigma
hold on
plot(wave_Lambda(1:3)*1e9,4*out_SigmaI(1:3)*1e3/sin(10e-3))      % 2sigma
hold on
plot(wave_Lambda(1:3)*1e9,6*out_SigmaI(1:3)*1e3/sin(10e-3))      % 2sigma
ylabel('Footprint$@\theta = 10 $mrad [mm]','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
legend({'2*$\sigma_{beam}$','4*$\sigma_{beam}$','6*$\sigma_{beam}$'}...
       ,'Interpreter','latex','fontsize',18,'linewidth',1);
strings={'(a)'};
annotation('textbox',[0.3,0.7,0.1,0.1],'LineStyle','-','interpreter',...
           'latex','LineWidth',1,'String',strings,'FontSize',18)
       
subplot(1,2,1);
plot(wave_Lambda(3:end)*1e9,2*out_SigmaI(3:end)*1e3/sin(20e-3))      % 2sigma
hold on
plot(wave_Lambda(3:end)*1e9,4*out_SigmaI(3:end)*1e3/sin(20e-3))      % 2sigma
hold on
plot(wave_Lambda(3:end)*1e9,6*out_SigmaI(3:end)*1e3/sin(20e-3))      % 2sigma
ylabel('Footprint$@\theta = 20 $mrad [mm]','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
legend({'2*$\sigma_{beam}$','4*$\sigma_{beam}$','6*$\sigma_{beam}$'}...
       ,'Interpreter','latex','fontsize',18,'linewidth',1);



figure;
subplot(1,2,2)
plot(wave_Lambda*1e9,2*out_SigmaI*1e3/sin(20e-3))      % 2sigma
hold on
plot(wave_Lambda*1e9,4*out_SigmaI*1e3/sin(20e-3))      % 4sigma
hold on
plot(wave_Lambda*1e9,6*out_SigmaI*1e3/sin(20e-3))      % 6sigma
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
       
       
subplot(1,2,1)
plot(wave_Lambda*1e9,2*out_SigmaI*1e3/sin(10e-3))      % 2sigma
hold on
plot(wave_Lambda*1e9,4*out_SigmaI*1e3/sin(10e-3))      % 4sigma
hold on
plot(wave_Lambda*1e9,6*out_SigmaI*1e3/sin(10e-3))      % 6sigma
ylabel('Beam size$@$M1 [mm]','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
legend({'2*$\sigma_{beam}$','4*$\sigma_{beam}$','6*$\sigma_{beam}$'}...
       ,'Interpreter','latex','fontsize',18,'linewidth',1);
strings={'(a)'};
annotation('textbox',[0.3,0.7,0.1,0.1],'LineStyle','-','interpreter',...
           'latex','LineWidth',1,'String',strings,'FontSize',18)
%% *************************************************************** %%     
figure;
subplot(1,2,1)
plot(wave_Lambda*1e9,2.355*out_SigmaI*1e3)      % 2sigma
ylabel('Beam size$@$M1 [mm]','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);

strings={'(a)'};
annotation('textbox',[0.3,0.7,0.1,0.1],'LineStyle','-','interpreter',...
           'latex','LineWidth',1,'String',strings,'FontSize',18)

