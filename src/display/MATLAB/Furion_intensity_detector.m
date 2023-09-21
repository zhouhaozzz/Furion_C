function intensity_field = Furion_intensity_detector(X,Y,in_Field,flag)
%% ******************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen

% This function is used to detect the intensity of the input field.
% Input:
%  X,Y:      the horizontal and vertical axises.
%  in_Field: input field
%  flag: flag = 1,returns the intensity of the input field.
%        flag =!1,returns the normalized intensity of the input field.
%% ******************************************************************** %%
format long
[Nx,Ny] = size(in_Field);
inten_Centx = abs(in_Field(round((Nx-1)/2),:)).^2;
inten_Centy = abs(in_Field(:,round((Ny-1)/2))).^2;
fit_inten_x = fit(X(1,:)',abs(inten_Centx)','gauss1');
fit_inten_y = fit(Y(:,1),abs(inten_Centy),'gauss1');
sigma_Beamx = fit_inten_x.c1/sqrt(2)*1e6   %   [mm]  拟合方差
sigma_Beamy = fit_inten_y.c1/sqrt(2)*1e6   %   [mm]  拟合方差

%********************↓↓统计方法计算标准偏差 ↓ ↓ *****************************
%           intensity_sum =sum(sum(abs(in_Field).^2));
%           a = abs(in_Field).^2.*X./intensity_sum;      %X坐标加权平均
%           b = abs(in_Field).^2.*Y./intensity_sum;      %Y坐标加权平均
% statistics_Sigma_beamx = std(a(:))      %
% statistics_Sigma_beamy = std(b(:))      %
%******************** ↑ ↑统计方法计算标准偏差 ↑ ↑*****************************

if flag == 1
    intensity_field = abs(in_Field).^2;
else
    intensity_field = abs(in_Field).^2;
    intensity_field = intensity_field/max(max(intensity_field));
end
%计算统计方差


figure;
axes('position',[.15  .15  .5  .5]); box on;
surf(X*1e6,Y*1e6,intensity_field)
shading interp
box on;
xlim([-5*sigma_Beamx 5*sigma_Beamx])
ylim([-5*sigma_Beamy 5*sigma_Beamy])
colormap('copper');
xlabel('x [$\mu$m]','interpreter','latex','FontSize',16);
ylabel('y [$\mu$m]','interpreter','latex','FontSize',16);
set(gca,'TickLabelInterpreter','latex','fontsize',16,'linewidth',1.5);
set(gcf,'Units','centimeters','Position',[10 10 20 16]);
view(2)
axes('position',[.75  .15  .2  .5]); box on;
plot(intensity_field(:,round(Ny/2)),Y(:,round(Ny/2))*1e6,'k')
set(gca,'TickLabelInterpreter','latex','fontsize',16,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',1.5);
xlabel('I ','interpreter','latex','FontSize',16);
%ylabel('y [mm]','interpreter','latex','FontSize',16);
ylim([-5*sigma_Beamy 5*sigma_Beamy])

axes('position',[.15  .75  .5  .2]); box on;
plot(X(round(Nx/2),:)*1e6,intensity_field(round(Nx/2),:),'k')
set(gca,'TickLabelInterpreter','latex','fontsize',16,'linewidth',1.5);
set(get(gca,'Children'),'linewidth',1.5);
%xlabel('x [mm]','interpreter','latex','FontSize',16);
ylabel('I ','interpreter','latex','FontSize',16);
xlim([-5*sigma_Beamx 5*sigma_Beamx])

%------------------------
   ks =0.618*0.8;
    xs =0.19; ys =0.145;    
     text_start =ys+ks+ks*0.515+0.01;
    text_step =0.051;
    
text_X_FWHM = strcat('FWHM-X:',num2str(sigma_Beamx*2.355),'\mum');
%2021年10月11日，数据过长导致自动换行，从而显示错位，删除2个空格；
%text_X_FWHM = strcat('FWHM-X:',32,32,num2str(sigma_Beamx*2.355),'\mum');
text_Y_FWHM = strcat('FWHM-Y:',32,32,num2str(sigma_Beamy*2.355),'\mum');
text_X_std = strcat('Std-X:',32,32,32,32,32,32,32,32,num2str(sigma_Beamx),'\mum');
text_Y_std = strcat('Std-Y:',32,32,32,32,32,32,32,32,num2str(sigma_Beamy),'\mum');
%text_X_mean = strcat('Mean-X:',32,32,32,32,num2str(x_Mean),'\mum');
% text_Y_mean = strcat('Mean-Y:',32,32,32,32,num2str(y_Mean),'\mum');
   
    
annotation('textbox',[xs+ks+0.01 text_start               ks*0.5 .05],'String',text_X_FWHM,'FontSize',12);
annotation('textbox',[xs+ks+0.01 text_start-text_step     ks*0.5 .05],'String',text_Y_FWHM,'FontSize',12);
annotation('textbox',[xs+ks+0.01 text_start-2*text_step   ks*0.5 .05],'String',text_X_std,'FontSize',12);
annotation('textbox',[xs+ks+0.01 text_start-3*text_step   ks*0.5 .05],'String',text_Y_std,'FontSize',12);
%annotation('textbox',[xs+ks+0.01 text_start-4*text_step   ks*0.618 .05],'String',text_X_mean,'FontSize',14);
%annotation('textbox',[xs+ks+0.01 text_start-5*text_step   ks*0.618 .05],'String',text_Y_mean,'FontSize',14);
    
end

