function [out_SigmaI,sigma_WaistI,f_Rayleigh] = Furion_gauss_Inverse_propa ...
                              (FWHM,theta,L_distance,L_source,wave_Lambda,flag)
%% ******************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen

% This function is used to inversely propagate a Gaussian beam to beam
% waist£¬and return the distance between the input and the waist. Then
% move the waist to source point and calculate the beam size from the 
% waist to target plane.
% 
% Input:
%      FWHM: the FWHM of the intensity of the input Gaussian beam [m]
%      theta: beam divergence of FWHM [rad]
%      L_distance£º distance from the input to the target plane [m]
%      L_source:   from the undulator exit to source point
%      wave_Lambda£ºwavelength  [m]
% Output:
%      beam_sigma: sigma of the beam at the target plane
%      z_Distance: Distance from the input to the beam waist


%% ******************************************************************** %%
format long
% x = linspace(-5*sigma,5*sigma,N);
% y = linspace(-5*sigma,5*sigma,N)';
% [X,Y] = meshgrid(x,y);

if flag == 1

ampl_sigma = sqrt(2)*FWHM/2.355;                         % sigma of amplitude
ampl_width = sqrt(2)*ampl_sigma;                         % width(w) of amplitude
waist_Beam = sqrt(2*log(2))*wave_Lambda./(pi*theta);     % waist of amplitud 
sigma_Waist= waist_Beam/sqrt(2);                         % sigma of amplitude at waist
sigma_WaistI = sigma_Waist/sqrt(2);                      % sigma of Intensity at waist

f_Rayleigh = pi*waist_Beam.^2./wave_Lambda;               % Rayleigh length
%z_Distance = sqrt((ampl_width./waist_Beam).^2-1).*f_Rayleigh; % Distance to the beam waist

out_Width = waist_Beam.*sqrt(1+((L_source+L_distance)./f_Rayleigh).^2);   % width(w) of amplitude
out_Sigma = out_Width/sqrt(2);
out_SigmaI = out_Sigma/sqrt(2);

elseif flag == 2
    
waist_sigma = sqrt(2)*FWHM/2.355;                         % sigma of amplitude
waist_Beam = sqrt(2)*waist_sigma;                         % width(w) of amplitude
%waist_Beam = sqrt(2*log(2))*wave_Lambda./(pi*theta);     % waist of amplitud 
sigma_Waist= waist_Beam/sqrt(2);                        % sigma of amplitude at waist
sigma_WaistI = sigma_Waist/sqrt(2);                % sigma of Intensity at waist

f_Rayleigh = pi*waist_Beam.^2./wave_Lambda;               % Rayleigh length
%z_Distance = sqrt((ampl_width./waist_Beam).^2-1).*f_Rayleigh; % Distance to the beam waist

out_Width = waist_Beam.*sqrt(1+((L_source+L_distance)./f_Rayleigh).^2);   % width(w) of amplitude
out_Sigma = out_Width/sqrt(2);
out_SigmaI = out_Sigma/sqrt(2);
end



