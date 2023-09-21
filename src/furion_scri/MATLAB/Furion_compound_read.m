function compound_Str = Furion_compound_read(compound_Sym,path_Str)
%% *************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen
%
%  This function reads the information about compound from 'Compounds.dat'
%
% Input: compound_Sym: [string], 
%        path_Str:   Environment path [string]
%
% output:
%     compound_Str: The output structure£º mas_Density, molar_Mass, elemnt_Fra
%   
%
%% *************************************************************** %%
%                         Read 'Compounds.dat' file

format long
filename1 = 'Compounds.dat';
data_Base_c = textread([path_Str.path_datax,filename1],'%s','delimiter', '\n','headerlines', 30);

data_Base_n = [];
for l = 1:length(data_Base_c)
    data_compound = strsplit(char(data_Base_c(l)),' ');
    data_Base_n = [data_Base_n,data_compound]; 
end

%% *************************************************************** %%
%     Find the index of the interested information in the dat matrix     %

index_flag1 = find(strcmp(data_Base_n, '#S'));
index_flag2 = find(strcmp(data_Base_n, 'WeightFraction'));
index_flag3 = find(strcmp(data_Base_n, compound_Sym));
index_flag4 = index_flag3(2);
index_flag5 = index_flag2(find(index_flag2 == min(index_flag2(find(index_flag2 > index_flag4)))));
index_flag6 = index_flag1(find(index_flag1 == min(index_flag1(find(index_flag1 > index_flag4)))));

%% *************************************************************** %%
%              Extract 'Z  WeightFraction' of the compound               %

data_Base_m =  data_Base_n((index_flag5+1):(index_flag6-1));        % Z  WeightFraction
mas_Density = str2num(cell2mat(data_Base_n(index_flag4+2)));        % mass density g/cm^3
element_Frac = [];
for h = 1:length(data_Base_m)    
    d_Eleme_frac = str2double(char(data_Base_m(h)));
    element_Frac = [element_Frac,d_Eleme_frac]; 
end

%% *************************************************************** %%
%              Extract molar mass of each element in the compound         %

filename2 = 'AtomicConstants.dat';
data_Base_d = textread([path_Str.path_datax,filename2],'%s','delimiter', '\n','headerlines', 550);
data_Base_a = [];
for s = 1:length(data_Base_d)
    data_atomic = str2double(strsplit(char(data_Base_d(s)),' '));
    data_Base_a = [data_Base_a;data_atomic]; 
end
molar_Mass = 0;
elemnt_Fra = 0;
for p = 1:(length(element_Frac)/2)
    molar_Mass(p) = data_Base_a(element_Frac(2*p-1),4);            % [g/mol]
    atomic_num(p) = element_Frac(2*p-1);
    elemnt_Fra(p) = element_Frac(2*p);
end

%% *************************************************************** %%
%                             Output data                                 %

compound_Str.mas_Density = mas_Density;   % mass density of the compound [g/cm^3]
compound_Str.molar_Mass = molar_Mass;     % molar mass of each element in the compound
compound_Str.atomic_num = atomic_num;     % atomic number of each element in the compound
compound_Str.elemnt_Fra = elemnt_Fra;     % Weight Fraction of each element

