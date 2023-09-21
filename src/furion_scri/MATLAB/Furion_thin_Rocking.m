function [de_Xaxis,R0_amplitud,RH_amplitud,I0_intensity,IH_intensity] = Furion_thin_Rocking(bragg_Str,delta_theta,deltad_d,struc_Str,cry_thickness,cry_asymmetry,scan_range,flag)
%% ************************************************************************ %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen

% This function is used to calculate the rocking curve of thin crystal in
% Bragg diffraction geometry.
% Input:
%      bragg_Str: (produced by 'Furion_bragg_cal')
%      struc_Str: (produced by 'Furion_strucfactor_cal')
%      cry_thickness: crystal thickness [m]
%      cry_asymmetry: asymmetry angle [deg]
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

pho_energy = bragg_Str.phot_Energy;
cry_bragg = bragg_Str.theta_Bragg;
wa_Lambda = bragg_Str.wave_Lambda;
ele_suscept0  = struc_Str.chi_0;         % electric susceptibility
ele_susceptH  = struc_Str.chi_hkl;       % ele
ele_susceptHb = struc_Str.chi_hkl_bar;   % chihbar

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
    R0_amplitud = exp(-1i*N_inter_pa1*cry_thickness).*(R_inter_pa2-R_inter_pa1)...
                  ./(R_inter_pa2-R_inter_pa1.*exp(-1i*(N_inter_pa1-N_inter_pa2)*cry_thickness)); % amplitude of reflection wave          
    RH_amplitud = R_inter_pa1.*R_inter_pa2.*(1-exp(-1i*(N_inter_pa1-N_inter_pa2)*cry_thickness))...
                  ./(R_inter_pa2-R_inter_pa1.*exp(-1i*(N_inter_pa1-N_inter_pa2)*cry_thickness));
    I0_intensity= abs(R0_amplitud).^2;
    IH_intensity= abs(RH_amplitud).^2/abs(asy_factor);

elseif flag ==2
    h_Darwin = sqrt(ele_susceptH*ele_susceptHb)/(sind(2*cry_bragg))...
               ./sqrt(abs(asy_factor))*cotd(cry_bragg)*pho_energy                % half width of Darwin (eV)
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
    R0_amplitud = exp(-1i*N_inter_pa1*cry_thickness).*(R_inter_pa2-R_inter_pa1)...
                  ./(R_inter_pa2-R_inter_pa1.*exp(-1i*(N_inter_pa1-N_inter_pa2)*cry_thickness)); % amplitude of reflection wave          
    RH_amplitud = R_inter_pa1.*R_inter_pa2.*(1-exp(-1i*(N_inter_pa1-N_inter_pa2)*cry_thickness))...
                  ./(R_inter_pa2-R_inter_pa1.*exp(-1i*(N_inter_pa1-N_inter_pa2)*cry_thickness));
    I0_intensity= abs(R0_amplitud).^2;
    IH_intensity= abs(RH_amplitud).^2/abs(asy_factor);
end

% figure;plot(de_Xaxis*1e6,IH_intensity,'r')
% figure;plot(de_Xaxis*1e6,I0_intensity,'r')
% ylabel('Transmissivity','interpreter','latex','FontSize',22);
% ylabel('Reflectivity','interpreter','latex','FontSize',22);
% xlabel('$\theta-\theta_B$ [$\mu$rad]','interpreter','latex','FontSize',22);
% set(gcf,'Units','centimeters','Position',[10 10 20 15]);
% set(gca,'TickLabelInterpreter','latex','fontsize',20,'linewidth',2);
% set(get(gca,'Children'),'linewidth',2);
% title('Diamond(004) $\eta=-20^\circ$  Thickness 100 $\mu$m','interpreter','latex','FontSize',22)
% xlim([-40 60])
