function [X1,Y1,PHI,PSI] = Furion_angle_To_angle( X,Y,Phi,Psi)
% 1-project the Psi angle to yoz plane respect to z axle ;    psi-->y';
% 2-project the phi angle to xoz plane respect to z axle;     phi-->x';
%************************************************************************
% ID:210719-1 hukai hukai@mail.iasf.ac.cn
% ***********************************************************************
% Input:
% Phi(radian):
% Psi(radian):
% ***********************************************************************
% Ouput: 
% PHI(radian):
% PSI(radian):
% ***********************************************************************
% Modification history
%   2021-7-19 create hukai;
%************************************************************************
PHI = Phi;
PSI = atan(tan(Psi)./cos(Phi));
X1 = X;
Y1 = Y;
end

