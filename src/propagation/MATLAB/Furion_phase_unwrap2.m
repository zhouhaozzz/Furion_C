function phase_unwrap = Furion_phase_unwrap2(in_Field)
%% ************************************************************************** %%
% This function is used to unwrap the phase of 2-D complex field. 
% 功能：实现二维数组的相位校正，可参考matlab的unwrap函数的说明
% 参数：P：matrix of the radian phase angles ;
%       tol: jump tolerance instead of the default value(pi)
% 返回值：校正后的相位矩阵
% 主要思路：先使用一维校正函数unwrap校正中间的一行（默认认为中间的一行是比较标准的），
%           然后使用unwrap按列校正得到一个校正矩阵，然后使用上面的行校正此矩阵得到最后结果
% 调用方法：同unwrap函数调用方法（但不提供dim参数）
% 日期：2011/7/21
% author: GJ
% http://blog.sina.com.cn/s/blog_6163bdeb0102drb2.html
%% ************************************************************************** %%
phase_field = angle(in_Field);

[M, N] = size(phase_field);
mid = round(M/2);
unwrapmid = unwrap(phase_field(mid, :));  % 校正中间一行
unwrapP = unwrap(phase_field);            % 按列校正全矩阵
unwrapPmid = unwrapP(mid, :);
miderr = unwrapPmid - unwrapmid;
miderrM = repmat(miderr, M, 1);
phase_unwrap = unwrapP - miderrM;
end