function  [] = oscillator_optimization

theta = linspace(0.5,20,300);
R = linspace(0.85,1,300);
R1 = 0.90;
R2 = 0.92;
R3 = 0.94;
R4 = 0.96;
R5 = 0.98;
N_mirror = 360./(2*theta);
OSCI_eff1 = R1.^N_mirror;
OSCI_eff2 = R2.^N_mirror;
OSCI_eff3 = R3.^N_mirror;
OSCI_eff4 = R4.^N_mirror;
OSCI_eff5 = R5.^N_mirror;
figure;
plot(N_mirror,OSCI_eff1,'LineWidth',2,'Color',[0 0.498 0])
hold on
plot(N_mirror,OSCI_eff2,'LineWidth',2,'Color',[.078 .169 .549])
hold on
plot(N_mirror,OSCI_eff3,'LineWidth',2,'Color',[0.870, 0.490, 0])
hold on
plot(N_mirror,OSCI_eff4,'LineWidth',2,'Color',[.494 .184 .557])
hold on
plot(N_mirror,OSCI_eff5,'LineWidth',2,'Color',[1 0 0])
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
xlim([10 70])
ylabel('Efficiency of oscillator','interpreter','latex','FontSize',22);
xlabel('Number of mirrors','interpreter','latex','FontSize',22);
set(gcf,'InvertHardcopy','off','Color',[1 1 1],'Units','centimeters',...
        'Position',[10 10 20 15]);    
legend({'R = 90$\%$','R = 92$\%$','R = 94$\%$','R = 96$\%$','R = 98$\%$'},...
        'Interpreter','latex','fontsize',18,'linewidth',1);
    
    

[Theta,reflect] = meshgrid(theta,R);
n_mirror = 360./(2*Theta);
eff_OSCI = reflect.^n_mirror;
figure1 = figure(1);
subplot(1,2,1)
plot(theta,N_mirror,'LineWidth',2,'Color',[0 0 1])
ylim([0 100])
%xlim([10 60])
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
ylabel('Number of mirrors','interpreter','latex','FontSize',22);
xlabel('Grazing angle [deg]','interpreter','latex','FontSize',22);
set(gcf,'InvertHardcopy','off','Color',[1 1 1],'Units','centimeters',...
        'Position',[10 10 20 15]);


subplot(1,2,2)
[A,l]= contourf(n_mirror,reflect,eff_OSCI,[0,.05,.1,.2,.3,.4,.5,.6,...
                .7,.8,.9],'ShowText','on','LineWidth',1);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
ylabel('Reflectivity of single mirror','interpreter','latex','FontSize',22);
xlabel('Number of mirrors','interpreter','latex','FontSize',22);
title('Efficiency of oscillator','interpreter','latex','FontSize',22);
set(gcf,'InvertHardcopy','off','Color',[1 1 1],'Units','centimeters',...
        'Position',[10 10 20 15]);
clabel(A,l,'FontSize',12,'LabelSpacing',250);
ylim([0.9 1])
xlim([10 60])

annotation(figure1,'textbox',[0.160 0.807 0.040 0.068],'String',{'(a)'},...
    'LineWidth',1,'Interpreter','latex',...
    'FontSize',18,'EdgeColor',[1 1 1]);
annotation(figure1,'textbox',[0.600 0.807 0.040 0.068],'String',{'(b)'},...
    'LineWidth',1,'Interpreter','latex',...
    'FontSize',18,'EdgeColor',[1 1 1]);
%print(gcf,'-djpeg','-r300',[path,'\FEL1_beam_size_M1.jpg'])

