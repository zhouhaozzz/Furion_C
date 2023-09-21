function  S3FEL_beam_size_FEL1_M1()
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
path = 'E:\深圳粒子院\深圳FEL光束线\束线设计报告\FEL-1光束线\FEL1光束线图片\可研报告20210913';
format long
FWHM = [221,305,366,411,447]*1e-6;
theta = [3.9,5.1,6.4,7.9,9.1]*1e-6;
wave_Lambda = [1,1.55,2,2.5,3]*1e-9;
L_distance = 171;
L_source = 15;

[out_SigmaI,sigma_WaistI,f_Rayleigh] = Furion_gauss_Inverse_propa ...
                           (FWHM,theta,L_distance,L_source,wave_Lambda,1);
                          
%% *************************************************************** %%
%                 plot FWHM at beam waist and undulator Exit              %

figure1 = figure(1);
subplot1 = subplot(1,2,1);
plot(wave_Lambda*1e9,sigma_WaistI*2.355*1e6,'MarkerFaceColor',[1 0 0],...
    'MarkerSize',10,'Marker','diamond','LineWidth',2,'Color',[1 0 0])
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
ylabel('Source size (FWHM) [$\mu$m]','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'InvertHardcopy','off','Color',[1 1 1],'Units','centimeters',...
        'Position',[10 10 40 15]);
xlim(subplot1,[1 3]);
ylim(subplot1,[110 150]);

subplot2 = subplot(1,2,2);
plot(wave_Lambda*1e9,FWHM*1e6,'MarkerFaceColor',[0 0.498 0],...
    'MarkerSize',10,'Marker','diamond','LineWidth',2,'Color',[0 0.498 0])
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
ylabel('Beam size (FWHM)$@$Exit [$\mu$m]','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'InvertHardcopy','off','Color',[1 1 1],'Units','centimeters',...
        'Position',[10 10 40 15]);
xlim(subplot2,[1 3]);
ylim(subplot2,[200 450]);

annotation(figure1,'textbox',[0.160 0.807 0.040 0.068],'String',{'(a)'},...
    'LineWidth',1,'Interpreter','latex',...
    'FontSize',18,'EdgeColor',[1 1 1]);
annotation(figure1,'textbox',[0.600 0.807 0.040 0.068],'String',{'(b)'},...
    'LineWidth',1,'Interpreter','latex',...
    'FontSize',18,'EdgeColor',[1 1 1]);
print(gcf,'-djpeg','-r300',[path,'\FEL1_source_size.jpg'])

%% *************************************************************** %%
%        beam size at M1 and grazing angle for M1 being fully             %
%                  covered  at different wavelength                       %

figure2 = figure(2);
subplot3 = subplot(1,2,1);
plot(wave_Lambda*1e9,2*out_SigmaI*1e3,'MarkerFaceColor',[0 0.498 0],...
    'MarkerSize',10,'Marker','diamond','LineWidth',2,'Color',[0 0.498 0])      % 2sigma
hold on
plot(wave_Lambda*1e9,4*out_SigmaI*1e3,'MarkerFaceColor',[1 0 0],...
    'MarkerSize',10,'Marker','diamond','LineWidth',2,'Color',[1 0 0])      % 4sigma
hold on
plot(wave_Lambda*1e9,6*out_SigmaI*1e3,'MarkerFaceColor',[.078 .169 .549],...
    'MarkerSize',10,'Marker','diamond','LineWidth',2,'Color',[.078 .169 .549])      % 6sigma
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
ylabel('Beam size$@$M1 [mm]','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
xlim(subplot3,[1 3]);
ylim(subplot3,[0 5]);
legend({'2*$\sigma_{beam}$','4*$\sigma_{beam}$','6*$\sigma_{beam}$'}...
       ,'Interpreter','latex','Position',[0.150 0.580 0.099 0.214],...
        'Linewidth',1,'Fontsize',18);

subplot4 = subplot(1,2,2);
plot(wave_Lambda*1e9,6*out_SigmaI*1e3/780*1e3,'MarkerFaceColor',[0 0 1],...
    'MarkerSize',10,'Marker','diamond','LineWidth',2,'Color',[0 0 1])
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
ylabel('Grazing angle$@$M1 [mrad]','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
xlim(subplot4,[1 3]);
ylim(subplot4,[2 6]);
set(gcf,'InvertHardcopy','off','Color',[1 1 1],'Units','centimeters',...
        'Position',[10 10 40 15]);

annotation(figure2,'textbox',[0.160 0.807 0.040 0.068],'String',{'(a)'},...
    'LineWidth',1,'Interpreter','latex',...
    'FontSize',18,'EdgeColor',[1 1 1]);
annotation(figure2,'textbox',[0.600 0.807 0.040 0.068],'String',{'(b)'},...
    'LineWidth',1,'Interpreter','latex',...
    'FontSize',18,'EdgeColor',[1 1 1]);
print(gcf,'-djpeg','-r300',[path,'\FEL1_beam_size_M1.jpg'])

%% *************************************************************** %%
%               footprint on M1 for different grazing angle               %
%  footprint on M1 for different grazing angle and different wavelength   %
figure3 = figure(3);
subplot5 = subplot(1,2,1);
footprint1 = 6*out_SigmaI*1e3/6;                   % grazing 6 mrad
footprint2 = 6*out_SigmaI*1e3/7;                   % grazing 7 mrad
footprint3 = 6*out_SigmaI*1e3/8;                   % grazing 8 mrad
footprint4 = 6*out_SigmaI*1e3/9;                   % grazing 9 mrad
footprint5 = 6*out_SigmaI*1e3/10;                  % grazing 10 mrad
plot(wave_Lambda*1e9,footprint1,'MarkerFaceColor',[0 0.498 0],...
    'MarkerSize',10,'Marker','diamond','LineWidth',2,'Color',[0 0.498 0])           
hold on
plot(wave_Lambda*1e9,footprint2,'MarkerFaceColor',[1 0 0],...
    'MarkerSize',10,'Marker','diamond','LineWidth',2,'Color',[1 0 0])
hold on
plot(wave_Lambda*1e9,footprint3,'MarkerFaceColor',[.078 .169 .549],...
    'MarkerSize',10,'Marker','diamond','LineWidth',2,'Color',[.078 .169 .549])
hold on
plot(wave_Lambda*1e9,footprint4,'MarkerFaceColor',[.494 .184 .557],...
    'MarkerSize',10,'Marker','diamond','LineWidth',2,'Color',[.494 .184 .557])
hold on
plot(wave_Lambda*1e9,footprint5,'MarkerFaceColor',[0.870 0.490 0],...
    'MarkerSize',10,'Marker','diamond','LineWidth',2,'Color',[0.870 0.490 0])
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
ylabel('Footprint$@$M1 $6\sigma$ [m]','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
xlim(subplot5,[1 3]);
ylim(subplot5,[0 1]);
grid(subplot5,'on');
set(gcf,'InvertHardcopy','off','Color',[1 1 1],'Units','centimeters',...
        'Position',[10 10 40 15]);
legend({'$\alpha = 6$mrad','$\alpha = 7$mrad','$\alpha = 8$mrad',...
      '$\alpha = 9$mrad','$\alpha = 10$mrad'},'Interpreter','latex',...
      'Position',[0.156 0.539 0.110 0.265],'fontsize',18,'linewidth',1);

ang_Grazing = linspace(5,15,100)';                 % grazing angle [mrad]
[x,y] = meshgrid(6*out_SigmaI*1e3,ang_Grazing);    %
[x1,y2] = meshgrid(wave_Lambda*1e9,ang_Grazing);
subplot6 = subplot(1,2,2);
meshz(x1,y,x./y)
xlim(subplot6,[1 3]);
ylim(subplot6,[5 15]);
zlim(subplot6,[0 1]);
ylabel('Grazing angle $@$M1 $6\sigma$ [mrad]','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
zlabel('Footprint $@ 6\sigma$ [m]','interpreter','latex','FontSize',22);
set(gcf,'InvertHardcopy','off','Color',[1 1 1],'Units','centimeters',...
        'Position',[10 10 40 15]);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
set(subplot6,'BoxStyle','full','FontSize',20,'LineWidth',1.5,...
        'TickLabelInterpreter','latex','XTick',[1 1.5 2 2.5 3],'YTick',...
        [5 7 9 11 13 15],'ZTick',[0 0.2 0.4 0.6 0.8 1]);
set(get(gca,'Children'),'linewidth',2);
colorbar('peer',subplot6,'FontSize',18);
view(subplot6,[-51.1 34]);
set(gca,'box','on')
grid(subplot6,'on');
ax = gca;
ax.BoxStyle = 'full';

annotation(figure3,'textbox',[0.160 0.807 0.040 0.068],'String',{'(a)'},...
    'LineWidth',1,'Interpreter','latex',...
    'FontSize',18,'EdgeColor',[1 1 1]);
annotation(figure3,'textbox',[0.570 0.807 0.040 0.068],'String',{'(b)'},...
    'LineWidth',1,'Interpreter','latex',...
    'FontSize',18,'EdgeColor',[1 1 1]);
print(gcf,'-djpeg','-r300',[path,'\FEL1_footprint_M1.jpg'])

%% *************************************************************** %%
%   footprint on M1 for different grazing angle at the case of beam jitter
figure(4);                                 %   beam size fluctuations
footprint1 = 6*out_SigmaI*(1+0.1)*1e3/6;                   % grazing 6 mrad  
footprint2 = 6*out_SigmaI*(1+0.1)*1e3/7;                   % grazing 7 mrad
footprint3 = 6*out_SigmaI*(1+0.1)*1e3/8;                   % grazing 8 mrad
footprint4 = 6*out_SigmaI*(1+0.1)*1e3/9;                   % grazing 9 mrad
footprint5 = 6*out_SigmaI*(1+0.1)*1e3/10;                  % grazing 10 mrad
plot(wave_Lambda*1e9,footprint1,'MarkerFaceColor',[0 0.498 0],...
    'MarkerSize',10,'Marker','diamond','LineWidth',2,'Color',[0 0.498 0])           
hold on
plot(wave_Lambda*1e9,footprint2,'MarkerFaceColor',[1 0 0],...
    'MarkerSize',10,'Marker','diamond','LineWidth',2,'Color',[1 0 0])
hold on
plot(wave_Lambda*1e9,footprint3,'MarkerFaceColor',[.078 .169 .549],...
    'MarkerSize',10,'Marker','diamond','LineWidth',2,'Color',[.078 .169 .549])
hold on
plot(wave_Lambda*1e9,footprint4,'MarkerFaceColor',[.494 .184 .557],...
    'MarkerSize',10,'Marker','diamond','LineWidth',2,'Color',[.494 .184 .557])
hold on
plot(wave_Lambda*1e9,footprint5,'MarkerFaceColor',[0.870 0.490 0],...
    'MarkerSize',10,'Marker','diamond','LineWidth',2,'Color',[0.870 0.490 0])
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
ylabel('Footprint$@$M1 $6\sigma$ [m]','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
xlim([1 3]);
ylim([.2 .8]);
grid on;
set(gcf,'InvertHardcopy','off','Color',[1 1 1],'Units','centimeters',...
        'Position',[10 10 20 15]);
set(gca,'TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
legend({'$\alpha = 6$mrad','$\alpha = 7$mrad','$\alpha = 8$mrad',...
        '$\alpha = 9$mrad','$\alpha = 10$mrad'},'Interpreter','latex',...
        'Position',[0.220 0.590 0.110 0.265],'fontsize',18,'linewidth',1);
print(gcf,'-djpeg','-r300',[path,'\FEL1_footprint_M1_jitter.jpg'])
