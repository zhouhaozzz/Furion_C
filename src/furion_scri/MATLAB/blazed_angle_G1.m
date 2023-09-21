function    blazed_angle_G1()
%% ******************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen

% This function is used to inversely propagate a Gaussian beam to beam
% waist£¬and return the distance between the input and the waist. Then
% move the waist to source point and calculate the beam size from the 
% waist to target plane.
% 
% Input:
%      sigma: the rms of the intensity of the input Gaussian beam [m]
%      theta: angle of beam divergence [rad]
%      L_distance£º distance from the input to the target plane [m]
%      L_source:   from the undulator exit to source point
%      wave_Lambda£ºwavelength  [m]
% Output:
%      beam_sigma: sigma of the beam at the target plane
%      z_Distance: Distance from the input to the beam waist

%% ******************************************************************** %%


wave_Lambda = 1e-9;
blaze_Angle =linspace(0.1,0.5,400);
num_Density = linspace(10,200,400)';

[A,N] = meshgrid(blaze_Angle,num_Density);
theta = asin(N*wave_Lambda./(2*sind(A)))*180/pi;

figure;
surf(A,N,theta);
shading interp;   
xlabel('Blazed angle [deg]','interpreter','latex','FontSize',22);
ylabel('Line density [$l/mm$]','interpreter','latex','FontSize',22);
zlabel('$theta$ [deg]','interpreter','latex','FontSize',22);
set(gcf,'Units','centimeters','Position',[10 10 20 15]);
set(gca,'TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',2);
set(gca,'box','on')
ax = gca;
ax.BoxStyle = 'full';








