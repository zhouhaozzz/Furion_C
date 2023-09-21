function S3FEL_VLS_PGM_FEL1()

C_ff = linspace(1,5,1000);
wave_Lambda = 2e-9;
n_Density = 150e3;
m_Order =1;
r_Entrance = 211;
r_Exit = 130;
s_Source = 2.355*35e-6;
ferror_M = 100e-9;
ferror_G = 100e-9;
s_Ex_slit = 20e-6;
n_Total = 45e3;
[alpha,beta,r_G_mono,b2,b3,blaz,r_Source,r_FerrorM,r_FerrorG,r_Ex_slit,r_D_limit] ...
    = VLS_PGM_cal(wave_Lambda,n_Density,m_Order,C_ff,r_Entrance,r_Exit,...
    s_Source,ferror_M,ferror_G,s_Ex_slit,n_Total);
subplot(1,2,1);
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
    
C_ff = 1.5;
wave_Lambda = linspace(1,3,1000)*1e-9;
n_Density = 150e3;
m_Order =1;
r_Entrance = 211;
r_Exit = 130;
s_Source = 2.355*35e-6;
ferror_M = 100e-9;
ferror_G = 100e-9;
s_Ex_slit = 20e-6;
n_Total = 45e3;
[r_G_mono,b2,b3,blaz,r_Source,r_FerrorM,r_FerrorG,r_Ex_slit,r_D_limit] ...
    = VLS_PGM_cal(wave_Lambda,n_Density,m_Order,C_ff,r_Entrance,r_Exit,...
    s_Source,ferror_M,ferror_G,s_Ex_slit,n_Total);

subplot(1,2,2);
plot(wave_Lambda*1e9,r_G_mono)
hold on;plot(wave_Lambda*1e9,r_FerrorG)
hold on;plot(wave_Lambda*1e9,r_FerrorM)
hold on;plot(wave_Lambda*1e9,r_Source) 
hold on;plot(wave_Lambda*1e9,r_Ex_slit) 
hold on;plot(wave_Lambda*1e9,r_D_limit) 
ylabel('Energy resolution $\Delta\lambda/\lambda$','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 40 15]);
set(gca,'TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
legend({'Resolution total','Grating slop','Mirror slop','Source','Slit',...
        'Diffraction'},'Interpreter','latex','fontsize',18,'linewidth',1);
strings={'(a)'};
annotation('textbox',[0.3,0.7,0.35,0.1],'LineStyle','-','interpreter',...
           'latex','LineWidth',1,'String',strings,'FontSize',18)