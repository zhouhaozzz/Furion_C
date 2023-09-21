function [de_Xaxis,I0_modify,IH_modify,R0_modify,RH_modify,deltad_D] = Furion_thermal_Rocking(Temper_xy,rad_intens)
%% ************************************************************** %%
% By Dr. Chuan Yang,  Email: yangc@mail.iasf.ac.cn
% Institute of Advanced Science Facilities, Shenzhen (IASF)
% March, 2021, Shenzhen

% This function is used to calculate the rocking curve of thermal expansion
% crystal in Bragg diffraction geometry.
%
%
%% ************************************************************** %%
format long

Furion_physical_constants;
path_Str = Furion_filepath();
addpath(genpath(pwd));

atomic_sym   = 'C';
crystal_Sym  = 'Diamond';
phot_Energy  = 5000;               % [eV]
miller_Str.h = 2;
miller_Str.k = 2;
miller_Str.l = 0;
cry_thickness= 90e-6;
cry_asymmetry= 0;
scan_range   = 7;
flag = 2;
delta_theta = 0;

atomic_Str = Furion_atomic_read(atomic_sym,path_Str);
[crystal_Str,atomic_Posi] = Furion_crystal_read(crystal_Sym,path_Str);

rad_total = sum(sum(rad_intens));

I0_modify = 0;
IH_modify = 0;
R0_modify = 0;
RH_modify = 0;
deltad_D  = [];


for k = 1:length(Temper_xy(:,1))
    k
    for m = 1:length(Temper_xy(1,:))
        [crystal_Str_modify,deltad_d] = diamond_thermalexp(Temper_xy(k,m),crystal_Str);
        bragg_Str = Furion_bragg_cal(phot_Energy,crystal_Str_modify,miller_Str);
        formfactor_Str = Furion_formfactor_read(bragg_Str,atomic_sym,path_Str);
        debye_Waller = Furion_Debyefactor_cal(bragg_Str,Temper_xy(k,m),atomic_Str);
        struc_Str = Furion_strucfactor_cal(formfactor_Str,debye_Waller,bragg_Str,atomic_Posi,miller_Str);
        [de_Xaxis,R0_amplitud,RH_amplitud,I0_intensity,IH_intensity] = Furion_thin_Rocking(bragg_Str,delta_theta,deltad_d,struc_Str,cry_thickness,cry_asymmetry,scan_range,flag);
        deltad_D(k,m)  = deltad_d;
        I0_modify = I0_modify+rad_intens(k,m)/rad_total*I0_intensity;
        IH_modify = IH_modify+rad_intens(k,m)/rad_total*IH_intensity;
        R0_modify = R0_modify+rad_intens(k,m)/rad_total*R0_amplitud;
        RH_modify = RH_modify+rad_intens(k,m)/rad_total*RH_amplitud;
    end
end

% figure;plot(de_Xaxis,IH_modify)
% figure;plot(de_Xaxis,I0_modify)
% xlabel('Photon energy $E-E_B$ [eV]','interpreter','latex','FontSize',22);
% %ylabel('Reflectivity','interpreter','latex','FontSize',22);
% ylabel('Transmissivity','interpreter','latex','FontSize',22);
% set(gcf,'Units','centimeters','Position',[10 10 20 15]);
% set(gca,'TickLabelInterpreter','latex','fontsize',20,'linewidth',1.5);
% set(get(gca,'Children'),'linewidth',2);
% title('$T_0 = 300 K$','interpreter','latex','FontSize',22)
% legend({'Non-thermal','Thermal 3W'},'Interpreter','latex','fontsize',18,'linewidth',1);
% legend({'Thermal 3W','3$\sigma$ beam','Crystal edge'},'Interpreter','latex','fontsize',18,'linewidth',1);
% legend({'$t = 0 \mu$s','$t = 1 \mu$s','$t = 2 \mu$s','$t = 3 \mu$s','$t = 4 \mu$s','$t = 5 \mu$s'},'Interpreter','latex','fontsize',18,'linewidth',1);
% xlim([-.75 .5])

% figure;surf(x_grid*1e6,y_grid*1e6,Temper_xy.t1us)
% xlabel('$x$ [$\mu m$]','interpreter','latex','FontSize',18);
% %ylabel('Reflectivity','interpreter','latex','FontSize',22);
% ylabel('$y$ [$\mu m$]','interpreter','latex','FontSize',18);
% zlabel('Temperature [K]','interpreter','latex','FontSize',18);
% set(gcf,'Units','centimeters','Position',[10 10 20 15]);
% set(gca,'TickLabelInterpreter','latex','fontsize',18,'linewidth',1.5);
% title('$t = 1 \mu$m','interpreter','latex','FontSize',22)
% colormap('hot')
% shading interp
% xlim([-200 200])
% ylim([-200 200])

