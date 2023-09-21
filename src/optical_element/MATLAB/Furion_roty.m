function R = Furion_roty( t )
% rotation angle t about the y-axis ;left-hand column vector;
% right-hand row vector;
%************************************************************************
% ID:     21062904
% ***********************************************************************
% Input:  angle , unit radian
% ***********************************************************************
% Ouput:  transform matrix
% ***********************************************************************
%
% Modification history
%   2021-6-29 add annotation;
%************************************************************************
ct=cos(t);
st=sin(t);
R=[ 
    ct,0,-st;
    0,1,0;
    st,0,ct;
    ];
end
