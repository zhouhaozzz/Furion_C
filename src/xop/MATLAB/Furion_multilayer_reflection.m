function [de_Xaxis,R0_amplitud,RH_amplitud,I0_intensity,IH_intensity] = Furion_multilayer_reflection(multilayer_chi_str,delta_theta,deltad_d,thickness,ang_asymmetry,scan_range,flag)
%% ************************************************************************ %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen

% This function is used to calculate the rocking curve of thin crystal in
% Bragg diffraction geometry.
% Input:
%      multilayer_chi_str: (produced by 'Furion_multilayer_chi')
%      delta_theta: input angle deviation from the Bragg angle [rad]
%      deltad_d: crystal lattice change ¦¤d/d
%      thickness: thickness of multilayer [m]
%      ang_asymmetry: asymmetry angle [deg]
%      scan_range: scanning range 
%      flag: 1: scan angle;  2: scan photon energy
% Output:
%      de_Xaxis: If flag=1, the unit of de_Xaxis is rad. If flag =2, the
%                unit of de_Xaxis is eV
%      R0_amplitude: The amplitude of transmissive wave
%      RH_amplitude: The amplitude of reflective wave
%      I0_intensity: The intensity of transmissive wave
%      IH_intensity: The intensity of reflective wave
%% ************************************************************************ %%
format long;
global e_Charge h_Plank c_Speed 

pho_energy = multilayer_chi_str.phot_Energy;
cry_bragg = multilayer_chi_str.theta_Bragg;
wa_Lambda = multilayer_chi_str.wave_Lambda;
ele_suscept0  = multilayer_chi_str.chi_0;         % electric susceptibility
ele_susceptH  = multilayer_chi_str.chi_h;       % ele
ele_susceptHb = multilayer_chi_str.chi_hb;   % chihbar

wave_numb = 2*pi/wa_Lambda;
ang_frequ = 2*pi*c_Speed/wa_Lambda;                 % central angular frequency [Hz]
gamma0 = cosd(cry_bragg+ang_asymmetry-90);          % direction cosine
gammaH = cosd(cry_bragg-ang_asymmetry+90);          % direction cosine
asy_factor = gamma0/gammaH;                         % asymmetric factor                        % wave number
extin_leng = sqrt(gamma0*abs(gammaH))/(wave_numb*sqrt...
            (ele_susceptH*ele_susceptHb));          % extinction length
        
if flag ==1
    os_Theta = -ele_suscept0*(1-1/asy_factor)./(2*sind(2*cry_bragg));             % deviation from the middle of reflection domain
    h_Darwin = sqrt(ele_susceptH*ele_susceptHb)/(sind(2*cry_bragg))...
               ./sqrt(abs(asy_factor));                                           % half width of Darwin (rad)
    de_Xaxis = linspace(-scan_range/2,scan_range/2,40000)*real(2*h_Darwin);        % scanning range (rad)
    %de_Xaxis = linspace(-scan_range/2,scan_range/2,40000);                         %
    d_parameter = (de_Xaxis-os_Theta+delta_theta)./h_Darwin;                                  % deviation parameter
    R_inter_pa1 = sqrt(abs(asy_factor))*sqrt(ele_susceptH*ele_susceptHb)/...
                  ele_susceptHb*(-d_parameter-sqrt(d_parameter.^2-1));
    R_inter_pa2 = sqrt(abs(asy_factor))*sqrt(ele_susceptH*ele_susceptHb)/...
                  ele_susceptHb*(-d_parameter+sqrt(d_parameter.^2-1));
    N_inter_pa1 = wave_numb*ele_suscept0/2/gamma0+1/2/extin_leng*(-d_parameter...
                  -sqrt(d_parameter.^2-1));
    N_inter_pa2 = wave_numb*ele_suscept0/2/gamma0+1/2/extin_leng*(-d_parameter...
                  +sqrt(d_parameter.^2-1));
    R0_amplitud = exp(-1i*N_inter_pa1*thickness).*(R_inter_pa2-R_inter_pa1)...
                  ./(R_inter_pa2-R_inter_pa1.*exp(-1i*(N_inter_pa1-N_inter_pa2)*thickness)); % amplitude of reflection wave          
    RH_amplitud = R_inter_pa1.*R_inter_pa2.*(1-exp(-1i*(N_inter_pa1-N_inter_pa2)*thickness))...
                  ./(R_inter_pa2-R_inter_pa1.*exp(-1i*(N_inter_pa1-N_inter_pa2)*thickness));
    I0_intensity= abs(R0_amplitud).^2;
    IH_intensity= abs(RH_amplitud).^2/abs(asy_factor);

elseif flag ==2
    h_Darwin = sqrt(ele_susceptH*ele_susceptHb)/(sind(2*cry_bragg))...
               ./sqrt(abs(asy_factor))*cotd(cry_bragg)*pho_energy;                % half width of Darwin (eV)
    de_Xaxis = linspace(-scan_range/2,scan_range/2,4000)*real(2*h_Darwin);        % scanning range (eV)
    %de_Xaxis = linspace(-scan_range/2,scan_range/2,40000);                         %
    frequenc = de_Xaxis*e_Charge/(h_Plank);
    Omega = 2*pi*frequenc;                                                        % frequency deviation
    d_parameter = wave_numb*extin_leng/(2*gamma0)*(asy_factor*(-4*(Omega/ang_frequ+deltad_d)*(sind(cry_bragg))^2) ...
                  .*(1-2*(Omega/ang_frequ+deltad_d))+ele_suscept0*(1-asy_factor));
    R_inter_pa1 = sqrt(abs(asy_factor))*sqrt(ele_susceptH*ele_susceptHb)/...
                  ele_susceptHb*(-d_parameter-sqrt(d_parameter.^2-1));
    R_inter_pa2 = sqrt(abs(asy_factor))*sqrt(ele_susceptH*ele_susceptHb)/...
                  ele_susceptHb*(-d_parameter+sqrt(d_parameter.^2-1));
    N_inter_pa1 = wave_numb*ele_suscept0/2/gamma0+1/2/extin_leng*(-d_parameter...
                  -sqrt(d_parameter.^2-1));
    N_inter_pa2 = wave_numb*ele_suscept0/2/gamma0+1/2/extin_leng*(-d_parameter...
                  +sqrt(d_parameter.^2-1));
    R0_amplitud = exp(-1i*N_inter_pa1*thickness).*(R_inter_pa2-R_inter_pa1)...
                  ./(R_inter_pa2-R_inter_pa1.*exp(-1i*(N_inter_pa1-N_inter_pa2)*thickness)); % amplitude of reflection wave          
    RH_amplitud = R_inter_pa1.*R_inter_pa2.*(1-exp(-1i*(N_inter_pa1-N_inter_pa2)*thickness))...
                  ./(R_inter_pa2-R_inter_pa1.*exp(-1i*(N_inter_pa1-N_inter_pa2)*thickness));
    I0_intensity= abs(R0_amplitud).^2;
    IH_intensity= abs(RH_amplitud).^2/abs(asy_factor);
end



