function [crystal_Str,atomic_Posi] = Furion_crystal_read(crystal_Sym,path_Str)
%% ************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen
%
% This function is used to read the interlattice distance,bragg angle
% and the volume of unit cell. 
%
% Input: crystal_Sym [string]: including the following crystals
%    'Si', 'Si_NIST', 'Si2', 'Ge', 'Diamond', 'GaAs', 'GaSb', 'GaP', 'InAs'
%    'InP', 'InSb', 'SiC', 'NaCl', 'CsF', 'LiF', 'KCl', 'CsCl', 'Be', 'Graphite'
%    'PET', 'Beryl', 'KAP', 'RbAP', 'TlAP', 'Muscovite', 'AlphaQuartz', 'Copper'
%    'LiNbO3', 'Platinum', 'Gold', 'Sapphire', 'LaB6', 'LaB6_NIST', 'KTP'
%    'AlphaAlumina', 'Aluminum', 'Iron', 'Titanium'
%    path_Str: the structure of file paths.

% output:
%     crystal_Str: the data of unit cell: a,b,c [m]; alpha,beta,gamma [deg] 
%     atomic_Posi: including 5 columns
%                  Atomic_Number  Fraction(occupation)  X  Y  Z     
%
%% ************************************************************** %%

filename = 'Crystals.dat';
data_Base_c = textread([path_Str.path_datax,filename],'%s','delimiter', '\n','headerlines', 45);

for m = 1:length(data_Base_c)
    C = strsplit(char(data_Base_c(m)),' ');
    if ismember('#S',C)&&ismember(crystal_Sym,C)
        data_Unitcell = strsplit(char(data_Base_c(m+1)),' ');
        crystal_Str.a = str2double(char(data_Unitcell(2)))*1e-10;
        crystal_Str.b = str2double(char(data_Unitcell(3)))*1e-10;
        crystal_Str.c = str2double(char(data_Unitcell(4)))*1e-10;
        crystal_Str.alpha = str2double(char(data_Unitcell(5)));
        crystal_Str.beta = str2double(char(data_Unitcell(6)));
        crystal_Str.gamma = str2double(char(data_Unitcell(7)));
        n = m;
        while true
            n = n+1;
            if ismember('#L  AtomicNumber  Fraction  X  Y  Z',data_Base_c(n))
                break
            end
        end
        k = m;
        while true
            k = k+1;
            if contains(data_Base_c(k),'#S')
                break
            end
        end
        data_Atomic = data_Base_c(n+1:k-1);
        atomic_Posi = [];
        for l = 1:length(data_Atomic)
            data_atomic = str2double(strsplit(char(data_Atomic(l)),' '));
            atomic_Posi = [atomic_Posi;data_atomic]; 
        end
    else
    end
end



