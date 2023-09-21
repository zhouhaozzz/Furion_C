clear;format long;
global e_Charge h_Plank c_Speed
e_Charge = 1.602176565e-19;        % charge unit[C]
h_Plank  = 6.62607004e-34;         % Plank constant [J-sec]
c_Speed  = 299792458;              % speed of light[m/sec]

wavelen   = linspace(1,3,300)*1e-9;
Pho_ene = c_Speed*h_Plank./(wavelen*e_Charge);
Delta_t   = linspace(10,70,300)*1e-15;
[delta_t,Pho_ene] = meshgrid(Delta_t,Pho_ene);
[delta_t,Wavelen] = meshgrid(Delta_t,wavelen);
resolution1   = 2*log(2)/pi/c_Speed.*Wavelen./delta_t;
resolution2   = 2*log(2)/pi/c_Speed.*wavelen./70e-15;

resolut   = Delta_E./Pho_ene;
figure;
surf(delta_t*1e15,Wavelen*1e9,resolution1);
shading interp;   
xlabel('Pulse duration [fs]','interpreter','latex','FontSize',22);
ylabel('Wavelength [nm]','interpreter','latex','FontSize',22);
zlabel('$\Delta E/E$','interpreter','latex','FontSize',22);
xlim([10 70])
ylim([1 3])
set(gcf,'Units','centimeters','Position',[10 10 20 15]);
set(gca,'TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
set(gca,'box','on')
ax = gca;
ax.BoxStyle = 'full';
figure;plot(wavelen*1e9,resolution2)




