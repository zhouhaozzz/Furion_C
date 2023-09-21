function [x_grid,y_grid,rad_intens,time_ith,Temperature_xy,X,Temper_xy] = Furion_diamond_thermal(bragg_Str,t_max)
%% ************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen

%                         Parameters of crystal                           %
%% ************************************************************** %%
format long;
global e_Charge h_Plank c_Speed
e_Charge = 1.602176565e-19;        % charge unit[C]
h_Plank  = 6.62607004e-34;         % Plank constant [J-sec]
c_Speed  = 299792458;              % speed of light[m/sec]

crystal_Densi = 3520;             % diamond density: kg/m^3
Temperature_0 = 300;              % initial temperature
Temperature_1 = 300;              % initial temperature
pulse_Radius  = 30e-06;        % transverse radius = 0.6R_p (R_p FWHM)
heat_conducti = 900;             % Thermal conductivity [W/m/K] (100K 5585),(200K 2658),(300K 1722),(400K 1265) 
specific_Heat = 514;              % Specific heat [J/kg/K] (100K 29),(200K 214),(300K 514),(400K 854)
phot_Energy   = bragg_Str.phot_Energy;

% data_crysta = dir([pwd,'\Diamond_mu.dat']);
% data_attenu = importdata(data_crysta(1).name,' ',1);
% pho_Energy1 = data_attenu.data(:,1)';
% coe_attenua = data_attenu.data(:,2)'*100;                     % unit:m-1
% index_atten = find(abs(pho_Energy1-phot_Energy)==min(abs(pho_Energy1-phot_Energy)));
% pho_attenua = coe_attenua(index_atten);
pho_attenua = 1025;       % mu:  12keV(315), 9keV(1025), 7keV(2301), 4.5keV(9224) 


incident_Angl = bragg_Str.theta_Bragg;
gamma_00 = sind(incident_Angl);
radius_x = pulse_Radius/sind(incident_Angl);
radius_y = pulse_Radius;
%time_ith = (0:0.1:5e3)*1e-6;
dtelta_0 = 10e-6;
%time_nth = linspace(0,t_max,400);
time_ith = (0:dtelta_0:t_max);


X = linspace(-pulse_Radius*8,pulse_Radius*8,100);
Y = linspace(-pulse_Radius*8,pulse_Radius*8,100);

[x_grid,y_grid] = meshgrid(X,Y');
rad_intens = exp(-(x_grid/radius_x).^2-(y_grid/radius_y).^2);

X = 0;
Y = 0;

%% ************************************************************** %%
%                          Thermal process                                %
%% ************************************************************** %%
Temperature_xy(1) = Temperature_0;

for g = 1:length(X)
    x = X(g);
    g
for k = 1:length(Y)
    
    y = Y(k);
    for n = 1:(length(time_ith)-1)   
        Temperature_1 = Temperature_0;
        for m = 0:n   
            pulse_Energy  = 20e-6;
            spread_Time   = pulse_Radius.^2.*specific_Heat.*crystal_Densi./4./heat_conducti; % temperature spreading time
            beta_x = 1+gamma_00.^2.*(time_ith(n+1)-time_ith(m+1))./spread_Time;
            beta_y = 1+(time_ith(n+1)-time_ith(m+1))./spread_Time;
            Delta_T_1 = pho_attenua*pulse_Energy/(pi*specific_Heat*crystal_Densi*pulse_Radius^2);
            Temperature_1 = Temperature_1 + Delta_T_1./sqrt(beta_x*beta_y).*exp(-x.^2./...
                            (radius_x.^2.*beta_x)-y.^2./(radius_y.^2.*beta_y));
        end
        Temperature_xy(n+1) = Temperature_1;

    end

    Temper_xy_9us(g,k) = Temperature_xy(10);
    Temper_xy_8us(g,k) = Temperature_xy(9);
    Temper_xy_7us(g,k) = Temperature_xy(8);
    Temper_xy_6us(g,k) = Temperature_xy(7);
    Temper_xy_5us(g,k) = Temperature_xy(6);
    Temper_xy_4us(g,k) = Temperature_xy(5);
    Temper_xy_3us(g,k) = Temperature_xy(4);
    Temper_xy_2us(g,k) = Temperature_xy(3);
    Temper_xy_1us(g,k) = Temperature_xy(2);
end
end
Temper_xy.t9us = Temper_xy_9us;
Temper_xy.t8us = Temper_xy_8us;
Temper_xy.t7us = Temper_xy_7us;
Temper_xy.t6us = Temper_xy_6us;
Temper_xy.t5us = Temper_xy_5us;
Temper_xy.t4us = Temper_xy_4us;
Temper_xy.t3us = Temper_xy_3us;
Temper_xy.t2us = Temper_xy_2us;
Temper_xy.t1us = Temper_xy_1us;
save('Temper_xy.mat','Temper_xy')
% Temperature4p5keV.x_grid = x_grid;
% Temperature4p5keV.y_grid = y_grid;
% Temperature4p5keV.Temper_xy_200us = Temper_xy;
% Temperature4p5keV.rad_intens = rad_intens;
%save('Temperature4p5keV.mat','Temperature4p5keV')