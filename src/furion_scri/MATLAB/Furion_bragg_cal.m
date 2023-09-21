function bragg_Str = Furion_bragg_cal(phot_Energy,crystal_Str,miller_Str)
%% ************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen
%
% This function is used to calculate the interlattice distance,bragg angle
% and the volume of unit cell. 
%
% Input:
%     theta_Bragg: Bragg angle  [deg]
%     pho_Energy: photon energy [eV]
%     crystal_Str: the data of unit cell: a,b,c [m]; alpha,beta,gamma [deg] 
%     miller_Str: the data of Miller index
%     atomic_sym: Symbol of element 
%
% Output:
%     bragg_Str: the data structure includes theta_Bragg [deg],
%     spacing_hkl [m], and cell_Volume [m^3]
%    
%
%% ************************************************************** %%
format long
global e_Charge h_Plank c_Speed

%% ************************************************************** %%
%    Calculate the volume of the unit cell and interlattice distance d

cell_Volume = crystal_Str.a*crystal_Str.b*crystal_Str.c*sqrt(1+2*cosd(crystal_Str.alpha)* ...
                cosd(crystal_Str.beta)*cosd(crystal_Str.gamma)-cosd(crystal_Str.alpha)^2 - ...
                cosd(crystal_Str.beta)^2 -cosd(crystal_Str.gamma)^2);        %  ∫À µµ•Œª
quantity_int= 1/(1+2*cosd(crystal_Str.alpha)*cosd(crystal_Str.beta)*cosd(crystal_Str.gamma) ...
                -cosd(crystal_Str.alpha)^2-cosd(crystal_Str.beta)^2 -cosd(crystal_Str.gamma)^2);
quantity_int= quantity_int*( ...
                (miller_Str.h*sind(crystal_Str.alpha)/crystal_Str.a)^2 + ...
                (miller_Str.k*sind(crystal_Str.beta)/crystal_Str.b)^2 + ...
                (miller_Str.l*sind(crystal_Str.alpha)/crystal_Str.c)^2 + ...
                2*miller_Str.h*miller_Str.k/crystal_Str.a/crystal_Str.b* ...
                (cosd(crystal_Str.alpha)*cosd(crystal_Str.beta)-cosd(crystal_Str.gamma)) + ...
                2*miller_Str.k*miller_Str.l/crystal_Str.b/crystal_Str.c* ...
                (cosd(crystal_Str.beta)*cosd(crystal_Str.gamma)-cosd(crystal_Str.alpha)) + ...
                2*miller_Str.l*miller_Str.h/crystal_Str.c/crystal_Str.a* ...
                (cosd(crystal_Str.gamma)*cosd(crystal_Str.alpha)-cosd(crystal_Str.beta)) );

spacing_hkl = 1/sqrt(quantity_int);

%% ************************************************************** %%
%                              Bragg angle
wave_Lambda = c_Speed*h_Plank/(phot_Energy*e_Charge);  %  [m]
theta_Bragg = asind(wave_Lambda/2/spacing_hkl);
bragg_Str.theta_Bragg = theta_Bragg;
bragg_Str.spacing_hkl = spacing_hkl;
bragg_Str.cell_Volume = cell_Volume;
bragg_Str.wave_Lambda = wave_Lambda;
bragg_Str.phot_Energy  = phot_Energy;






