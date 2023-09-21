%模拟产生面型误差，并保存给 Shadow、Srw、Furion使用
h_Error_rms = 0.8e-9;%高度标准差
s_Error_rms = 80e-9;%斜率标准差
n_Upper = 16 ;%设置最高频率
b = random_to_dat(h_Error_rms,s_Error_rms,n_Upper,'G');%创建面型误差对象
b.save_to_furion_and_srw_1d();    %保存成dat格式，可以给Furion 和srw 使用
b.save_to_srw_2d();               %保存为dat格式，可以被srw软件读取
b.save_to_shadow_2d();            %保存为dat格式，可以被shadow软件读取