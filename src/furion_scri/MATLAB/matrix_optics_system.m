function matrix_optics_system()

%% *************************************************************** %%
%                         XAS and XES  horizontal

f1 = R_m*sin(theta1)/2;
f2 = R_s/2/sin(theta2);
M1 = [1,125;0,1];
M2 = [1,0;-1/f1,1];
M3 = [1,95;0,1];
M4 = [1,0,-1/f2,1];

M = M4*M3*M2*M1;


