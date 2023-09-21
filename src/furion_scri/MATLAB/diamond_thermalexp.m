function [crystal_Str_modify,deltad_d] = diamond_thermalexp(T,crystal_Str)
%% ************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen
%
% Input:
%    T: temperature from 0 K to 2200 K
%    crystal_Str: prameters of unit cell (produced by 'Furion_crystal_read.m')
%
%
%
%% ************************************************************** %%
%                The parameters of unit cell of diamond at 293.15 K
format long
T0 = 293.15;
a = crystal_Str.a;
b = crystal_Str.b;
c = crystal_Str.c;
alpha = crystal_Str.alpha;
beta  = crystal_Str.beta;
gamma = crystal_Str.gamma;

%% ************************************************************** %%
%      fitting coefficients of linear thermal expansion coefficient
% General model Fourier8:

       a0 = 2.284963682221840e+02;
       a1 =           0;
       b1 = -7.627965340254361e+02;
       a2 = -7.078790180156608e+02;
       b2 =  6.553091935387647e+02;
       a3 =  7.917680541786205e+02;
       b3 = -65.540349918275723;
       a4 = -3.940282692202515e+02;
       b4 = -2.328267825563773e+02;
       a5 =  79.363521867068101;
       b5 =  1.680460205485809e+02;
       a6 =  7.350174715824708;
       b6 = -50.681522684077265;
       a7 = -5.726343608883197;
       b7 =  6.490632983361176;
       a8 =  0.655511852547109;
       b8 = -0.183633274144249;
       w =   4.808560184066010e-04;

    alphaT = ...
               a0 + a1*cos(T*w) + b1*sin(T*w) + ...
               a2*cos(2*T*w) + b2*sin(2*T*w) + a3*cos(3*T*w) + b3*sin(3*T*w) + ...
               a4*cos(4*T*w) + b4*sin(4*T*w) + a5*cos(5*T*w) + b5*sin(5*T*w) + ...
               a6*cos(6*T*w) + b6*sin(6*T*w) + a7*cos(7*T*w) + b7*sin(7*T*w) + ...
               a8*cos(8*T*w) + b8*sin(8*T*w);
AlphaT = @(T) a0 + a1*cos(T*w) + b1*sin(T*w) + ...
               a2*cos(2*T*w) + b2*sin(2*T*w) + a3*cos(3*T*w) + b3*sin(3*T*w) + ...
               a4*cos(4*T*w) + b4*sin(4*T*w) + a5*cos(5*T*w) + b5*sin(5*T*w) + ...
               a6*cos(6*T*w) + b6*sin(6*T*w) + a7*cos(7*T*w) + b7*sin(7*T*w) + ...
               a8*cos(8*T*w) + b8*sin(8*T*w);

deltad_d = integral(AlphaT, T0, T);
a_modify = a*(deltad_d+1);
b_modify = b*(deltad_d+1);
c_modify = c*(deltad_d+1);

crystal_Str_modify.a = a_modify;
crystal_Str_modify.b = b_modify;
crystal_Str_modify.c = c_modify;
crystal_Str_modify.alpha = alpha;
crystal_Str_modify.beta = beta;
crystal_Str_modify.gamma = gamma;

           