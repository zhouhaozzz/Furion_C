function [] = oscillator_N_gainlength()

N_Gain = linspace(0,20,50);
R_totall = linspace(0.01,0.5,50)';
[N,R] = meshgrid(N_Gain,R_totall);
%R_totall = 0.1;
G = exp(N_Gain);
eta = 1./(G.*R_totall);
figure;
[A,l] = contourf(N,R,eta,[0,0.01,.05,.1,.3,.5,...
                .7,.9],'ShowText','on','LineWidth',1);
ylabel('Oscillator efficiency','interpreter','latex','FontSize',22);
xlabel('Number of gain length','interpreter','latex','FontSize',22);
title('Recycle fraction: $\eta$','interpreter','latex','FontSize',22);
set(gcf,'InvertHardcopy','off','Color',[1 1 1],'Units','centimeters',...
        'Position',[10 10 20 15]);  
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
        'latex','fontsize',20,'linewidth',1.5);
clabel(A,l,'FontSize',12,'LabelSpacing',100);
colormap('summer')
ylim([0 .5])
xlim([0 10])

