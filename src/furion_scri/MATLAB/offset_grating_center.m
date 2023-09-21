function offset_grating_center()
%% *************************************************************** %%
format long

A1 = [sind(2*0.8243)/2,cosd(0.8243),-(cosd(0.8243))^2;...
      sind(2*1.1658)/2,cosd(1.1658),-(cosd(1.1658))^2;...
     sind(2*1.4278)/2,cosd(1.4278),-(cosd(1.4278))^2];
B1 = [15,15,15]';          %  mm

A2 = [sind(2*0.5871)/2,cosd(0.5871),-(cosd(0.5871))^2;...
      sind(2*0.8303)/2,cosd(0.8303),-(cosd(0.8303))^2;
      sind(2*1.0169)/2,cosd(1.0169),-(cosd(1.0169))^2];
B2 = [15,15,15]';          %  mm

X1 = A1\B1;
Xm1 = X1(1);R1 = X1(2);Ym1 = X1(3);
X2 = A2\B2;
Xm2 = X2(1);R2 = X2(2);Ym2 = X2(3);
%% *************************************************************** %%

FWHM = [221,305,366,411,447]*1e-6;
theta = [3.9,5.1,6.4,7.9,9.1]*1e-6;
wave_Lambda = [1,1.55,2,2.5,3]*1e-9;
L_distance = 137;
L_source = 80;

[out_SigmaI,sigma_WaistI,f_Rayleigh] = Furion_gauss_Inverse_propa ...
                              (FWHM,theta,L_distance,L_source,wave_Lambda,1);
C_ff = 3.5;
n_Density = 230e3;
m_Order =1;
r_Entrance = 217;
r_Exit = 108;
s_Source = sigma_WaistI*2.355;
ferror_M = 100e-9;
ferror_G = 100e-9;
s_Ex_slit = 10e-6;
n_Total = 45e3;
[alpha,beta,r_G_mono,b2,b3,blaz,r_Source,r_FerrorM,r_FerrorG,r_Ex_slit,r_D_limit] ...
    = VLS_PGM_cal(wave_Lambda,n_Density,m_Order,C_ff,r_Entrance,r_Exit,...
    s_Source,ferror_M,ferror_G,s_Ex_slit,n_Total);
theta= (180-(alpha+beta))/2;

W_b1 = 30./cosd(alpha)-Xm1*sind(2*theta)./cosd(alpha)- R1*2*cosd(theta)./cosd(alpha)+Ym1*2*(cosd(theta)).^2./cosd(alpha); % mm
W_b2 = 30./cosd(alpha)-Xm2*sind(2*theta)./cosd(alpha)- R2*2*cosd(theta)./cosd(alpha)+Ym2*2*(cosd(theta)).^2./cosd(alpha); % mm

figure;
plot(wave_Lambda*1e9,W_b1)
hold on
plot(wave_Lambda*1e9,W_b2*1e3)

ylabel('offset-center [$\mu$m]','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 18 15]);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
legend({'50$\quad$mm$^{-1}$ G1','150 mm$^{-1}$ G2'},'Interpreter','latex','fontsize',18,'linewidth',1);

delt_alpha = r_G_mono.*(sind(alpha)-sqrt(1-C_ff^2*(cosd(alpha)).^2))./(cosd(alpha)...
             -C_ff^2*cosd(alpha).*sind(alpha)./sqrt((1-C_ff^2*(cosd(alpha)).^2)))
delt_beta = r_G_mono.*(sqrt(1-(cosd(beta)/C_ff).^2)-sind(beta))./(sind(beta).*cosd(beta)...
            ./(C_ff^2*sqrt(1-(cosd(beta)/C_ff).^2))-cosd(beta))
        
delta_theta = (abs(delt_alpha)-abs(delt_beta))/2
