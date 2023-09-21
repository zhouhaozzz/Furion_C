shift_Y =31.714;                                        %分开光束的距离
addpath(genpath('..\display'));
b1=import_beam('1nm_M1_M5_rough_intensity.dat');        %导入第一个波长的强度值
b1.import_phase('1nm_M1_M5_rough_phase.dat');           %导入第一个波长的相位值
b1.coordinate_transform(650,-650,60,-60);               %处理数据，得出对应位置的光场
b1.coordinate_diffraction(0,0);                         % 对光束进行衍射后处理         

b2 = import_beam('1nm-_M1_M5_rough_intensity.dat');     %导入第二个波长的光束
b2.import_phase('1nm-_M1_M5_rough_phase.dat');
b2.coordinate_transform(650,-650,60,-60);
b2.coordinate_diffraction(0,-shift_Y);

b3=import_beam('1nm+_M1_M5_rough_intensity.dat');       %导入第三个波长的光束
b3.import_phase('1nm+_M1_M5_rough_phase.dat');
b3.coordinate_transform(650,-650,60,-60);
b3.coordinate_diffraction(0,shift_Y);

b4=import_beam('1nm+_M1_M5_rough_intensity.dat');       %三个光束显示在同一副图上，从而可以查看分辨率
b4.X = b1.X;
b4.Y = b1.Y;
b4.field = b1.field + b2.field +b3.field;
b4.intensity_plot();