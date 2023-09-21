function [beam_sigma,waist_sigma,z_Distance] = ansys_Power_distribute()
%% ******************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen

% This function is used to inversely propagate a Gaussian beam to beam
% waist，and return the distance between the input and the waist. Then
% move the waist to source point and calculate the beam size from the 
% waist to target plane.
% 
% Input:
%      sigma: the rms of the intensity of the input Gaussian beam [m]
%      theta: angle of beam divergence [rad]
%      L_distance： distance from the input to the target plane [m]
%      L_source:   from the undulator exit to source point
%      wave_Lambda：wavelength  [m]
% Output:
%      beam_sigma: sigma of the beam at the target plane
%      z_Distance: Distance from the input to the beam waist

%% *************************************************************** %%
format long
% FWHM = [221,305,366,411,447]*1e-6;
% theta = [3.9,5.1,6.4,7.9,9.1]*1e-6;
% wave_Lambda = [1,1.55,2,2.5,3]*1e-9;

FWHM = [136,245]*1e-6;
theta = [2.7,5.3]*1e-6;
wave_Lambda = [0.33,1]*1e-9;

L_source = 80;
N = 150;


%% *************************************************************** %%
%                         安全光闸（距离墙2m）
%L_distance = 106;
L_distance = 48;
[out_SigmaI,sigma_WaistI,f_Rayleigh] = Furion_gauss_Inverse_propa ...
                              (FWHM,theta,L_distance,L_source,wave_Lambda,1);
sigma = out_SigmaI(1)*1e3;              
y = linspace(-3,3,N)';              %   mm
x = linspace(-3,3,N);             %   mm
[X,Y] = meshgrid(x,y);
power_xy = exp(-Y.^2./(2*sigma.^2)).*exp(-X.^2./(2*sigma.^2));
Power1 = trapz(y,trapz(x,power_xy,2));
%coeffi = 100/Power1;      %  基波
coeffi = 4/Power1;        %  高次谐波
Power2 = coeffi*power_xy;

figure;
meshz(X,Y,Power2)
XX = repmat(x,N,1);
XX = XX(:);               % mm
YY = repmat(y,N,1);       % mm
PP = Power2(:);           % W/mm2


header1 = 'X(mm)      Y(mm)        Power_density(W/mm2)';
out = [XX YY PP];
outputFile = 'Power_density_SS_H';
fid = fopen(outputFile,'wt');
fprintf(fid,'%s\n',header1);
fprintf(fid,'%-14.11e        %-14.11e      %-14.11e\n',out');
fclose(fid);


%% *************************************************************** %%
%                              M1


N = 300;
%sigma = 0.9355;                         %   mm 基波M1
sigma = 0.84085;                          %   M5 3nm 
%sigma = 0.2144;                         %   mm 高次谐波
%theta = 7e-3;                           %   mrad M1
theta = 20.94e-3;                        %   mrad M5 3nm

y = linspace(-25,25,N)';              %   mm
x = linspace(-200,200,N);             %   mm
[X,Y] = meshgrid(x,y);
% power_xy = 0.127490449020668*exp(-Y.^2./(2*sigma.^2)).*exp(-X.^2./(2*(sigma./tan(theta)).^2));
% Power = trapz(y,trapz(x,power_xy,2));
power_xy = exp(-Y.^2./(2*sigma.^2)).*exp(-X.^2./(2*(sigma./tan(theta)).^2));
Power1 = trapz(y,trapz(x,power_xy,2));
coeffi = 13.5375/Power1;        %  M5 
%coeffi = 4/Power1;        %  高次谐波
Power2 = coeffi*power_xy;

power_xy1 = Power2*0.05; % 基波
%power_xy1 = Power2*0.1;  % 高次谐波

XX = repmat(x,N,1);
XX = XX(:);               % mm
YY = repmat(y,N,1);       % mm
PP = power_xy1(:);        % W/mm2

figure;
meshz(X,Y,power_xy1)

header1 = 'X(mm)      Y(mm)        Power_density(W/mm2)';
out = [XX YY PP];
%outputFile = 'Power_density_M1';
outputFile = 'Power_density_M5';
fid = fopen(outputFile,'wt');
fprintf(fid,'%s\n',header1);
fprintf(fid,'%-14.11e        %-14.11e      %-14.11e\n',out');
fclose(fid);

