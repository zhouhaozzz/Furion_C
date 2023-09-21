%二维面型显示和保存
%a=import_2d('22d_20211007.csv',90/125.3);  %shadow 几何追迹
a=import_2d('22d_20211007.csv',1/0.6);  %shadow 几何追迹
a=import_2d('22d_20211007.csv',4/0.6);  %shadow 几何追迹
a=import_2d('22d_20211007.csv',3/0.6);  %shadow 几何追迹
a=import_2d('22d_20211007.csv',1.5/0.6);  %shadow 几何追迹
%导入的时候就可以限定范围
%
% a.surface_plot();%绘制三维表面图
 a.middle_meri_roughness_plot();%绘制子午方向roughness
% a.middle_meri_slope_plot();%绘制子午方向roughness           %作图显示数据