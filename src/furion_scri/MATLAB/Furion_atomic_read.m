function atomic_Str = Furion_atomic_read(atomic_sym,path_Str)
%% ************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen
%
%  This function read the information about atomic constants from 'AtomicConstants.dat':
%  The constants include: 
%             Atomic Radius, Covalent Radius, Atomic Mass, Boiling Point,
%             Melting Point, Density, Atomic Volume, Coherent Scattering Length,
%             Incoherent X-section, Absorption@1.8A,Debye Temperature and 
%             Thermal conductivity at 300 K.
%
% Input: crystal_Sym [string], including 103 kinds of elements
%
%
% output:
%     atomic_Str: the data of atomic constants 
%   
%
%% ************************************************************** %%

format long
%cd(path_Str.path_datax);

atomic_Stru = struct('H',1,'He',2,'Li',3,'Be',4,'B',5,'C',6,'N',7,'O',8,'F',9,'Ne',10, ...
              'Na',11,'Mg',12,'Al',13,'Si',14,'P',15,'S',16,'Cl',17,'Ar',18,'K',19, ...
              'Ca',20,'Sc',21,'Ti',22,'V',23,'Cr',24,'Mn',25,'Fe',26,'Co',27,'Ni',28, ...
              'Cu',29,'Zn',30,'Ga',31,'Ge',32,'As',33,'Se',34,'Br',35,'Kr',36,'Rb',37, ...
              'Sr',38,'Y',39,'Zr',40,'Nb',41,'Mo',42,'Tc',43,'Ru',44,'Rh',45,'Pd',46, ...
              'Ag',47,'Cd',48,'In',49,'Sn',50,'Sb',51,'Te',52,'I',53,'Xe',54,'Cs',55, ...
              'Ba',56,'La',57,'Ce',58,'Pr',59,'Nd',60,'Pm',61,'Sm',62,'Eu',63,'Gd',64, ...
              'Tb',65,'Dy',66,'Ho',67,'Er',68,'Tm',69,'Yb',70,'Lu',71,'Hf',72,'Ta',73, ...
              'W',74,'Re',75,'Os',76,'Ir',77,'Pt',78,'Au',79,'Hg',80,'Tl',81,'Pb',82, ...
              'Bi',83,'Po',84,'At',85,'Rn',86,'Fr',87,'Ra',88,'Ac',89,'Th',90,'Pa',91, ...
              'U',92,'Np',93,'Pu',94,'Am',95,'Cm',96,'Bk',97,'Cf',98,'Es',99,'Fm',100, ...
              'Md',101,'No',102,'Lr',103);
          
for i = 1:length(atomic_sym)
    if mod(i,2) == 1
       atomic_sym(i) = upper(atomic_sym(i));
    else
       atomic_sym(i) = lower(atomic_sym(i));
    end
end

filename = 'AtomicConstants.dat';
data_Base_c = textread([path_Str.path_datax,filename],'%s','delimiter', '\n','headerlines', 550);
data_Base_n = [];
for l = 1:length(data_Base_c)
    data_atomic = str2double(strsplit(char(data_Base_c(l)),' '));
    data_Base_n = [data_Base_n;data_atomic]; 
end
atomic_numb = atomic_Stru.(atomic_sym);

atomic_Str.atomic_number = data_Base_n(atomic_numb,1);            % 
atomic_Str.atomic_Radius = data_Base_n(atomic_numb,2)*1e-10;      % [m]
atomic_Str.covale_Radius = data_Base_n(atomic_numb,3)*1e-10;      % [m]
atomic_Str.molar_Mass_re = data_Base_n(atomic_numb,4);            % [g/mol]
atomic_Str.boiling_Point = data_Base_n(atomic_numb,5);            % [K]
atomic_Str.melting_Point = data_Base_n(atomic_numb,6);            % [K]
atomic_Str.masss_Density = data_Base_n(atomic_numb,7);            % [g/cm^3]
atomic_Str.atomic_Volume = data_Base_n(atomic_numb,8);            % [cm^3/mol]
atomic_Str.cohe_Scat_len = data_Base_n(atomic_numb,9);            % [1e-12 cm]
atomic_Str.incohe_X_sect = data_Base_n(atomic_numb,10);           % [barn]
atomic_Str.absorpti_1p8A = data_Base_n(atomic_numb,11);           % [1e-12 cm]
atomic_Str.debye_Tempera = data_Base_n(atomic_numb,12);           % [K]
atomic_Str.thermal_Condu = data_Base_n(atomic_numb,13);           % [W/cmK]

%cd(path_Str.path_script);






