function path_Str = Furion_filepath()
%% ************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen
%
% This function returns the structure of file paths.
%
% Output:
%      path_Str
%   
%% ************************************************************** %%

inter_name  = dir;                           %文件夹信息结构体
path_script = inter_name.folder;             %文件夹名称呼
inter_name  = strsplit(path_script,'\');     %
path_inter  = [];
for k = 1:(length(inter_name)-1)
    path_inter  = [path_inter,cell2mat(inter_name(k)),'\'];
end

%% ************************************************************** %%
%                  add paths in the following section

path_formfactor  =  [path_inter,'database\f0_f1f2\'];            %形状因子
path_datax = [path_inter,'database\'];                           %数据库

%% ************************************************************** %%

path_Str.path_script = path_script;                           % xop 文件夹                   
path_Str.path_formfactor = path_formfactor;                   % 结构因子文件夹
path_Str.path_datax = path_datax;                             % 数据库文件夹