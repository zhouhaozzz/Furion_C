c=csv_to_dat_1d('2d_10nm.csv');%从CSV中导入面型误差数据
c.save_to_shadow_2d();%保存为shadow可以读取的格式；