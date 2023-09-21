
function [de_Xaxis,R_intensity,R_amplitude]=Furion_thick_Rocking(bragg_Str,struc_Str,cry_asymmetry,scan_range,flag)
%% ************************************************************************ %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen

% This function is used to calculate the rocking curve of thick crystal
% Input:
%      bragg_Str: (produced by 'Furion_bragg_cal')
%      struc_Str: (produced by 'Furion_strucfactor_cal')
%      cry_asymmetry: asymmetry angle [deg]
%      scan_range: scanning range in units of Darwin width
%      flag: 1: scan angle;  2: scan photon energy
% Output:
%      de_Xaxis: If flag=1, the unit of de_Xaxis is rad. If flag =2, the
%                unit of de_Xaxis is eV
%      R_intensity: The intensity of reflection
%      R_amplitude: The amplitude of reflection
%% ************************************************************************ %%

format long;
global e_Charge h_Plank c_Speed

pho_energy = bragg_Str.phot_Energy;
cry_bragg = bragg_Str.theta_Bragg;
wa_Lambda = bragg_Str.wave_Lambda;
ele_suscept0  = struc_Str.chi_0;            % electric susceptibility
ele_susceptH  = struc_Str.chi_hkl;          % ele
ele_susceptHb = struc_Str.chi_hkl_bar;      % chihbar

wave_numb = 2*pi/wa_Lambda;
ang_frequ = 2*pi*c_Speed/wa_Lambda;                 % central angular frequency [Hz]
gamma0 = cosd(cry_bragg+cry_asymmetry-90);          % direction cosine
gammaH = cosd(cry_bragg-cry_asymmetry+90);          % direction cosine
asy_factor = gamma0/gammaH;                         % asymmetric factor                        % wave number
extin_leng = sqrt(gamma0*abs(gammaH))/(wave_numb*sqrt...
            (ele_susceptH*ele_susceptHb));          % extinction length

if flag ==1
    os_Theta = -ele_suscept0*(1-1/asy_factor)./(2*sind(2*cry_bragg));             % deviation from the middle of reflection domain
    h_Darwin = sqrt(ele_susceptH*ele_susceptHb)/(sind(2*cry_bragg))...
               ./sqrt(abs(asy_factor));                                           % half width of Darwin (rad)
    de_Xaxis = linspace(-scan_range/2,scan_range/2,4000)*real(2*h_Darwin);        % scanning range (rad)
    d_parameter = (de_Xaxis-os_Theta)./h_Darwin;                                  % deviation parameter
    R_intensity = abs(ele_susceptH/ele_susceptHb)*abs(d_parameter-...
                  sign(real(d_parameter)).*sqrt(d_parameter.^2-1)).^2;            % intensity of reflection wave
    R_amplitude = sign(gammaH)*sqrt(ele_susceptH*ele_susceptHb)/ele_susceptHb*...
                  (d_parameter-sign(real(d_parameter)).*sqrt(d_parameter.^2-1));  % amplitude of reflection wave
elseif flag ==2
    h_Darwin = sqrt(ele_susceptH*ele_susceptHb)/(sind(2*cry_bragg))...
               ./sqrt(abs(asy_factor))*cotd(cry_bragg)*pho_energy;                % half width of Darwin (eV)
    de_Xaxis = linspace(-scan_range/2,scan_range/2,4000)*real(2*h_Darwin);        % scanning range (eV)
    frequenc = de_Xaxis*e_Charge/(h_Plank);
    Omega = 2*pi*frequenc;                                                        % frequency deviation
    d_parameter = wave_numb*extin_leng/(2*gamma0)*(asy_factor*(-4*Omega*(sind(cry_bragg))^2/ang_frequ).*(1-2*Omega/ang_frequ)...
    +ele_suscept0*(1-asy_factor));
    R_intensity = abs(ele_susceptH/ele_susceptHb)*abs(d_parameter-...
                  sign(real(d_parameter)).*sqrt(d_parameter.^2-1)).^2;     % intensity of reflection wave
    R_amplitude = sign(gammaH)*sqrt(ele_susceptH*ele_susceptHb)/ele_susceptHb*...
                  (d_parameter-sign(real(d_parameter)).*sqrt(d_parameter.^2-1));
end
    

