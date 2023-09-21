function phase_field = Furion_phase_detector(X,Y,in_Field,flag)
%% ******************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen

% This function is used to detect the phase of the input field.
% Input:
%  X,Y:      the horizontal and vertical axises.
%  in_Field: input field
%  flag: flag = 1,returns the wrapped phase; flag =! 1,returns the unwrapped phase.
%% ******************************************************************** %%
format long
[Nx,Ny] = size(in_Field);
field_Centx = in_Field(round((Nx-1)/2),:);
field_Centy = in_Field(:,round((Ny-1)/2));
fit_Field_x = fit(X(1,:)',abs(field_Centx)','gauss1');
fit_Field_y = fit(Y(:,1),abs(field_Centy),'gauss1');
sigma_Beamx = fit_Field_x.c1/sqrt(2)*1e3;   %   [mm]
sigma_Beamy = fit_Field_y.c1/sqrt(2)*1e3;   %   [mm]

if flag == 1
    phase_field = angle(in_Field);
else
    phase_field = Furion_phase_unwrap2(in_Field);
end

figure;
axes('position',[.15  .15  .5  .5]); box on;
surf(X*1e3,Y*1e3,phase_field)
shading interp
xlim([-5*sigma_Beamx 5*sigma_Beamx])
ylim([-5*sigma_Beamy 5*sigma_Beamy])
xlabel('x [mm]','interpreter','latex','FontSize',16);
ylabel('y [mm]','interpreter','latex','FontSize',16);
set(gca,'TickLabelInterpreter','latex','fontsize',16,'linewidth',1.5);
set(gcf,'Units','centimeters','Position',[10 10 20 16]);
view(2)
axes('position',[.75  .15  .2  .5]); box on;
plot(phase_field(:,round(Ny/2)),Y(:,round(Ny/2))*1e3,'k')
set(gca,'TickLabelInterpreter','latex','fontsize',16,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',1.5);
xlabel('phase','interpreter','latex','FontSize',16);
%ylabel('y [mm]','interpreter','latex','FontSize',16);
ylim([-5*sigma_Beamy 5*sigma_Beamy])

axes('position',[.15  .75  .5  .2]); box on;
plot(X(round(Nx/2),:)*1e3,phase_field(round(Nx/2),:),'k')
set(gca,'TickLabelInterpreter','latex','fontsize',16,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',1.5);
%xlabel('x [mm]','interpreter','latex','FontSize',16);
ylabel('Phase','interpreter','latex','FontSize',16);
xlim([-5*sigma_Beamx 5*sigma_Beamx])


