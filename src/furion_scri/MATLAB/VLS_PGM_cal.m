function [alpha,beta,r_G_mono,b2,b3,blaz,r_Source,r_FerrorM,r_FerrorG,r_Ex_slit,r_D_limit] ...
             = VLS_PGM_cal(wave_Lambda,n_Density,m_Order,C_ff,r_Entrance,r_Exit,...
               s_Source,ferror_M,ferror_G,s_Ex_slit,n_Total)
%% *************************************************************** %% 
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen

% This function aims to calculate the relevant parameters of VLS-PGM


% Input:
%    wave_Lambda:  wavelength (m)
%    n_Density: groove density(m-1) 
%    m_Order: diffraction order
%    C_ff: optical magnification of grating(cm)
%    r_Entrance: distance between the entrance slit or source and grating
%    r_Exit: distance between the grating and exit slit
% Output:
%    r_G_mono,b2,b3,blaz,r_Source,r_FerrorM,r_FerrorG,r_Ex_slit,r_D_limit

% Modification history
%     04-19-2021 written by C. Yang.

%% *************************************************************** %%

format long
alpha = 180/pi*asin(n_Density.*wave_Lambda*m_Order./(C_ff.^2-1).*(sqrt(C_ff.^2+((C_ff.^2-1)...
        ./(n_Density.*wave_Lambda*m_Order)).^2)-1));
beta  = 180/pi*acos(C_ff.*cosd(alpha));
blaz  = (alpha-beta)/2;     

b2 = ((cosd(alpha)).^2/r_Entrance + (cosd(beta)).^2/r_Exit)./(n_Density.*wave_Lambda*m_Order);
b3 = (sind(alpha).*cosd(alpha).^2/r_Entrance + sind(beta).*cosd(beta).^2/r_Exit)*...
      3/2./(n_Density.*wave_Lambda.*m_Order) +b2.^2;
%% *************************************************************** %%
%                       resolution estimation                            %
t_Cff = sqrt((n_Density.*wave_Lambda.*m_Order).*(C_ff.^2-1)/2);
r_Source = s_Source./r_Entrance./t_Cff;     % source 
r_FerrorM = 2*ferror_M./t_Cff;              % pre-mirror slop error
r_FerrorG = ferror_G.*(1+C_ff)./t_Cff;      % grating slop error
r_Ex_slit = s_Ex_slit./r_Exit.*C_ff./t_Cff; % slit size
r_D_limit = 1./(m_Order.*n_Total);            % diffraction limited resolution
r_G_mono = sqrt(r_Source.^2 + r_FerrorM.^2 + r_FerrorG.^2 + r_Ex_slit.^2 + r_D_limit.^2); % resolution


