%% **************************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen
%
% This script summarizes the fundamental physical constants which are used by other functions.
%
%% **************************************************************************** %%
%
format long
global e_Charge h_Plank c_Speed k_Boltz avogadro epsilon0 r_Electr m_Electr M_Electr m_Neutron ...
       M_Neutron m_Pronton M_Pronton m_To_cm m_To_a b_To_cm2 eV_To_meV meV_to_eV a_To_eV

%% **************************************************************************** %%
%                             Fundamental physical constants

e_Charge = 1.602176565e-19;        % charge unit[C]
h_Plank  = 6.62607004e-34;         % Plank constant [J-sec]
c_Speed  = 299792458;              % speed of light[m/sec]
k_Boltz  = 1.380648813e-23;        % Boltzmann constant [J/K]
avogadro = 6.02214076e23;          % avogadro constant
epsilon0 = 8.854187817e-12;        % ermittivity of vacuum [F/m]

%% **************************************************************************** %%
%                   Physical constants of electrons, neutrons and protons

r_Electr = 2.81794092e-15;          % [m]
m_Electr = 9.10938291e-31;          % Electron rest mass [kg]
M_Electr = 0.510998928;             % Electron rest mass [MeV]
m_Neutron = 1.674927351e-27;        % Neutron rest mass [kg]
M_Neutron = 939.565379;             % Neutron rest mass [MeV]
m_Pronton = 1.67262163783e-27;      % Proton rest mass [kg]
M_Pronton = 938.272046;             % Proton rest mass [MeV]

%% **************************************************************************** %%
%                                conversion factors

m_To_cm   = 1.0e2;                              % convert m to cm
m_To_a    = 1.0e10;                             % convert m to Angstrom
b_To_cm2  = 1.0e-24;                            % convert barn to cm^2
eV_To_meV = 1.0e-6;                             % convert eV to MeV
meV_to_eV = 1.0e6;                              % convert MeV to eV
a_To_eV   = h_Plank*c_Speed/e_Charge*m_To_a;    % Angstrom <-> eV for particles L[A] = a_To_eV/E[eV]












