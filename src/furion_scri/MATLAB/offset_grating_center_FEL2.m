function offset_grating_center_FEL2()
%% *************************************************************** %%
format long

A1 = [sind(2*1.303)/2,cosd(1.303),-(cosd(1.303))^2;...
      sind(2*2.578)/2,cosd(2.578),-(cosd(2.578))^2;...
     sind(2*3.328)/2,cosd(3.328),-(cosd(3.328))^2];
L = 35;  % mm
 
B1 = [L/2,L/2,L/2]';          %  mm


X1 = A1\B1;
Xm1 = X1(1);R1 = X1(2);Ym1 = X1(3);


%% *************************************************************** %%

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
r_Exit = 74;
s_Source = sigma_WaistI*2.355;
ferror_M = 100e-9;
ferror_G = 100e-9;
s_Ex_slit = 20e-6;
n_Total = 60e3;
[alpha,beta,r_G_mono,b2,b3,blaz,r_Source,r_FerrorM,r_FerrorG,r_Ex_slit,r_D_limit] ...
    = VLS_PGM_cal(wave_Lambda,n_Density,m_Order,C_ff,r_Entrance,r_Exit,...
    s_Source,ferror_M,ferror_G,s_Ex_slit,n_Total);
theta= (180-(alpha+beta))/2;

W_b1 = L./cosd(alpha)-Xm1*sind(2*theta)./cosd(alpha)- R1*2*cosd(theta)./cosd(alpha)+Ym1*2*(cosd(theta)).^2./cosd(alpha); % mm

figure;
plot(wave_Lambda*1e9,W_b1*1e3)


ylabel('offset-center [$\mu$m]','interpreter','latex','FontSize',22);
xlabel('Wavelength [nm]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 18 15]);
set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);



%% *************************************************************** %%

delt_alpha = r_G_mono.*(sind(alpha)-sqrt(1-C_ff^2*(cosd(alpha)).^2))./(cosd(alpha)...
             -C_ff^2*cosd(alpha).*sind(alpha)./(1-C_ff^2*(cosd(alpha)).^2))
delt_beta = r_G_mono.*(sqrt(1-(cosd(beta)/C_ff).^2)-sind(beta))./(sind(beta).*cosd(beta)...
            ./(C_ff^2*sqrt(1-(cosd(beta)/C_ff).^2))-cosd(beta))
        
delta_theta = (delt_alpha+delt_beta)/2


