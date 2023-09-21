%% *************************************************************** %%
%                          pulse strething


clear;format long;
global e_Charge h_Plank c_Speed
e_Charge = 1.602176565e-19;        % charge unit[C]
h_Plank  = 6.62607004e-34;         % Plank constant [J-sec]
c_Speed  = 299792458;              % speed of light[m/sec]

wavelenth   = linspace(1,3,300)*1e-9;
N_density   = linspace(30,200,300)';
[Wavelenth,Density] = meshgrid(wavelenth,N_density);

Delta_t   = N
[delta_t,Pho_ene] = meshgrid(Delta_t,Pho_ene);
[delta_t,Wavelen] = meshgrid(Delta_t,wavelen);
resolution1   = 2*log(2)/pi/c_Speed.*Wavelen./delta_t;
resolution2   = 2*log(2)/pi/c_Speed.*wavelen./70e-15;