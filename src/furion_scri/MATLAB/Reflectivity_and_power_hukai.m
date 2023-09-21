addpath('./furion_scri');
Furion_physical_constants;% physics constant 
path_Str = Furion_filepath();%database path

theta = (5:0.1:20)*1e-3; 
lambda = [1,1.55,2,2.5,3]*1e-9;
[Xtheta,Ylambda]=meshgrid(theta,lambda);
phot_Energy = c_Speed*h_Plank./(Ylambda*e_Charge);% [nm]->[eV] wave_length
Grazing_str = Furion_grazing_compound(Xtheta,phot_Energy,'Ni',path_Str,1);
%% 



%%
plot(Xtheta'*1000,Grazing_str.R_intensity','LineWidth',2);
% set style
            set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
                'latex','fontsize',20,'linewidth',1.5);
            ylabel('Reflectivity','interpreter','latex','FontSize',20);
            xlabel('$\theta$ [mrad]','interpreter',' latex','FontSize',20);
            xlim([5,20]);
            ylim([0.8,1]);
            legend({'1.0 nm','1.5 nm','2.0 nm','2.5 nm','3.0 nm'},'Interpreter',...
                'latex','fontsize',18,'linewidth',1,'Location','Northwest','Position', ...
                [0.197563891091764 0.210699595394448 0.219643180285171 0.357142849195571]);
            grid on
            
%% RIXS horizontal
M12 =Furion_grazing_compound(Xtheta*0+7e-3,phot_Energy,'B4C',path_Str,1);
M34=Furion_grazing_compound(Xtheta*0+7.5e-3,phot_Energy,'B4C',path_Str,1);
absorbp=100*(M12.R_intensity).^2.*(M34.R_intensity).^2.*(1-Grazing_str.R_intensity);

plot(Xtheta'*1000,absorbp','LineWidth',2);
%set style
            set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
            'latex','fontsize',20,'linewidth',1.5);
            ylabel('power [w]','interpreter','latex','FontSize',20);
            xlabel('$\theta$ [mrad]','interpreter',' latex','FontSize',20);
            %ylim([0.8,1]);
            legend({'1.0 nm','1.5 nm','2.0 nm','2.5 nm','3.0 nm'},'Interpreter',...
                'latex','fontsize',18,'linewidth',1,'Location','Northwest','Position', ...
                [0.174349605377477 0.52022340491826 0.219643180285171 0.357142849195571]);
            grid on
            
%% RIXS vertical
M12 =Furion_grazing_compound(Xtheta*0+7e-3,phot_Energy,'B4C',path_Str,1);
M34=Furion_grazing_compound(Xtheta*0+7.5e-3,phot_Energy,'B4C',path_Str,1);
Mkbh=Furion_grazing_compound(Xtheta*0+9e-3,phot_Energy,'B4C',path_Str,1);
absorbp=100*(M12.R_intensity).^2.*(M34.R_intensity).^2.*(Mkbh.R_intensity).*(1-Grazing_str.R_intensity);
plot(Xtheta'*1000,absorbp','LineWidth',2);
%set style
            set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
            'latex','fontsize',20,'linewidth',1.5);
            ylabel('power [w]','interpreter','latex','FontSize',20);
            xlabel('$\theta$ [mrad]','interpreter',' latex','FontSize',20);
            %ylim([0.8,1]);
            legend({'1.0 nm','1.5 nm','2.0 nm','2.5 nm','3.0 nm'},'Interpreter',...
                'latex','fontsize',18,'linewidth',1,'Location','Northwest','Position', ...
                [0.174349605377477 0.52022340491826 0.219643180285171 0.357142849195571]);
            grid on
  path='.\v2\';
  print(gcf,'-djpeg','-r300',[path,'\RIXS_SASE_v_absorb_power.jpg']);
 %************************************************************************************************
 
 %***********************************************************************************************
 
%% XPS horizontal
M12 =Furion_grazing_compound(Xtheta*0+7e-3,phot_Energy,'B4C',path_Str,1);
M34=Furion_grazing_compound(Xtheta*0+7.5e-3,phot_Energy,'B4C',path_Str,1);
M6 = Furion_grazing_compound(Xtheta*0+13e-3,phot_Energy,'B4C',path_Str,1);
absorbp=100*(M12.R_intensity).^2.*(M34.R_intensity).^2.*(1-Grazing_str.R_intensity).*(M6.R_intensity);

plot(Xtheta'*1000,absorbp','LineWidth',2);
%set style
            set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
            'latex','fontsize',20,'linewidth',1.5);
            ylabel('power [w]','interpreter','latex','FontSize',20);
            xlabel('$\theta$ [mrad]','interpreter',' latex','FontSize',20);
            %ylim([0.8,1]);
            legend({'1.0 nm','1.5 nm','2.0 nm','2.5 nm','3.0 nm'},'Interpreter',...
                'latex','fontsize',18,'linewidth',1,'Location','Northwest','Position', ...
                [0.174349605377477 0.52022340491826 0.219643180285171 0.357142849195571]);
            grid on
            
%% XPS vertical

M12 =Furion_grazing_compound(Xtheta*0+7e-3,phot_Energy,'B4C',path_Str,1);
M34=Furion_grazing_compound(Xtheta*0+7.5e-3,phot_Energy,'B4C',path_Str,1);
Mkbh=Furion_grazing_compound(Xtheta*0+8e-3,phot_Energy,'B4C',path_Str,1);
M6 = Furion_grazing_compound(Xtheta*0+13e-3,phot_Energy,'B4C',path_Str,1);
absorbp=100*(M12.R_intensity).^2.*(M34.R_intensity).^2.*(Mkbh.R_intensity).*(1-Grazing_str.R_intensity).*(M6.R_intensity);
plot(Xtheta'*1000,absorbp','LineWidth',2);
%set style
            set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
            'latex','fontsize',20,'linewidth',1.5);
            ylabel('power [w]','interpreter','latex','FontSize',20);
            xlabel('$\theta$ [mrad]','interpreter',' latex','FontSize',20);
            ylim([0,15]);
            legend({'1.0 nm','1.5 nm','2.0 nm','2.5 nm','3.0 nm'},'Interpreter',...
                'latex','fontsize',18,'linewidth',1,'Location','Northwest','Position', ...
                [0.174349605377477 0.52022340491826 0.219643180285171 0.357142849195571]);
            grid on
path='.\v2\';
print(gcf,'-djpeg','-r300',[path,'\XPS_SASE_v_absorb_power.jpg']);

%% MDS SASE vertical 
M12 =Furion_grazing_compound(Xtheta*0+7e-3,phot_Energy,'B4C',path_Str,1);
M34=Furion_grazing_compound(Xtheta*0+7.5e-3,phot_Energy,'B4C',path_Str,1);
Mkbh=Furion_grazing_compound(Xtheta*0+8e-3,phot_Energy,'B4C',path_Str,1);
absorbp=100*(M12.R_intensity).^2.*(M34.R_intensity).^2.*(Mkbh.R_intensity).*(1-Grazing_str.R_intensity);
plot(Xtheta'*1000,absorbp','LineWidth',2);
%set style
            set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
            'latex','fontsize',20,'linewidth',1.5);
            ylabel('power [w]','interpreter','latex','FontSize',20);
            xlabel('$\theta$ [mrad]','interpreter',' latex','FontSize',20);
            %ylim([0.8,1]);
            legend({'1.0 nm','1.5 nm','2.0 nm','2.5 nm','3.0 nm'},'Interpreter',...
                'latex','fontsize',18,'linewidth',1,'Location','Northwest','Position', ...
                [0.174349605377477 0.52022340491826 0.219643180285171 0.357142849195571]);
            grid on
  path='.\v2\';
  print(gcf,'-djpeg','-r300',[path,'\MDS_SASE_v_absorb_power.jpg']);
  
%% CDI absorbing power horitan
M12 =Furion_grazing_compound(Xtheta*0+7e-3,phot_Energy,'B4C',path_Str,1);
M34=Furion_grazing_compound(Xtheta*0+7.5e-3,phot_Energy,'B4C',path_Str,1);
absorbp=100*(M12.R_intensity).^2.*(M34.R_intensity).^2.*(1-Grazing_str.R_intensity);

plot(Xtheta'*1000,absorbp','LineWidth',2);
%set style
            set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
            'latex','fontsize',20,'linewidth',1.5);
            ylabel('absorbing power [w]','interpreter','latex','FontSize',20);
            xlabel('$\theta$ [mrad]','interpreter',' latex','FontSize',20);
            %ylim([0.8,1]);
            legend({'1.0 nm','1.5 nm','2.0 nm','2.5 nm','3.0 nm'},'Interpreter',...
                'latex','fontsize',18,'linewidth',1,'Location','Northwest','Position', ...
                [0.174349605377477 0.52022340491826 0.219643180285171 0.357142849195571]);
            grid on
path='.\v2\CDI_h_absorbing_power.jpg';
print(gcf,'-djpeg','-r300',path); 

%% CDI arraving power
M12 =Furion_grazing_compound(Xtheta*0+7e-3,phot_Energy,'B4C',path_Str,1);
M34=Furion_grazing_compound(Xtheta*0+7.5e-3,phot_Energy,'B4C',path_Str,1);
absorbp=100*(M12.R_intensity).^2.*(M34.R_intensity).^2.*(Grazing_str.R_intensity);

plot(Xtheta'*1000,absorbp','LineWidth',2);
%set style
            set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
            'latex','fontsize',20,'linewidth',1.5);
            ylabel('arraving power [w]','interpreter','latex','FontSize',20);
            xlabel('$\theta$ [mrad]','interpreter',' latex','FontSize',20);
            %ylim([0.8,1]);
            legend({'1.0 nm','1.5 nm','2.0 nm','2.5 nm','3.0 nm'},'Interpreter',...
                'latex','fontsize',18,'linewidth',1,'Location','Northwest','Position', ...
                [0.652921033948903 0.548794833489693 0.219643180285171 0.357142849195571]);
            grid on
path='.\v2\CDI_h_arraving_power.jpg';
print(gcf,'-djpeg','-r300',path); 

%% CDI absoring power vetical
M12 =Furion_grazing_compound(Xtheta*0+7e-3,phot_Energy,'B4C',path_Str,1);
M34=Furion_grazing_compound(Xtheta*0+7.5e-3,phot_Energy,'B4C',path_Str,1);
Mkbh=Furion_grazing_compound(Xtheta*0+9e-3,phot_Energy,'B4C',path_Str,1);
absorbp=100*(M12.R_intensity).^2.*(M34.R_intensity).^2.*(Mkbh.R_intensity).*(1-Grazing_str.R_intensity);
plot(Xtheta'*1000,absorbp','LineWidth',2);
%set style
            set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
            'latex','fontsize',20,'linewidth',1.5);
            ylabel('absorbing power [w]','interpreter','latex','FontSize',20);
            xlabel('$\theta$ [mrad]','interpreter',' latex','FontSize',20);
            %ylim([0.8,1]);
            legend({'1.0 nm','1.5 nm','2.0 nm','2.5 nm','3.0 nm'},'Interpreter',...
                'latex','fontsize',18,'linewidth',1,'Location','Northwest','Position', ...
                [0.174349605377477 0.52022340491826 0.219643180285171 0.357142849195571]);
            grid on
  path='.\v2\';
  print(gcf,'-djpeg','-r300',[path,'\CDI__v_absorb_power.jpg']);
  
  %% CDI arrivae power vetical
M12 =Furion_grazing_compound(Xtheta*0+7e-3,phot_Energy,'B4C',path_Str,1);
M34=Furion_grazing_compound(Xtheta*0+7.5e-3,phot_Energy,'B4C',path_Str,1);
Mkbh=Furion_grazing_compound(Xtheta*0+9e-3,phot_Energy,'B4C',path_Str,1);
absorbp=100*(M12.R_intensity).^2.*(M34.R_intensity).^2.*(Mkbh.R_intensity).*(Grazing_str.R_intensity);
plot(Xtheta'*1000,absorbp','LineWidth',2);
%set style
            set(gca,'XMinorTick','on','YMinorTick','on','TickLabelInterpreter',...
            'latex','fontsize',20,'linewidth',1.5);
            ylabel('arraving power [w]','interpreter','latex','FontSize',20);
            xlabel('$\theta$ [mrad]','interpreter',' latex','FontSize',20);
            %ylim([0.8,1]);
            legend({'1.0 nm','1.5 nm','2.0 nm','2.5 nm','3.0 nm'},'Interpreter',...
                'latex','fontsize',18,'linewidth',1,'Location','Northwest','Position', ...
                [0.652921033948903 0.548794833489693 0.219643180285171 0.357142849195571]);
            grid on
  path='.\v2\';
  print(gcf,'-djpeg','-r300',[path,'\CDI__v_arraving_power.jpg']);




  
  