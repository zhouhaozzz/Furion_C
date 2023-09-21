 addpath(genpath('..\display'));
L=0.004;
N =8000;
sigma_x= 60e-6;
sigma_y= 60e-6;
x=linspace(-L/2,L/2,N);
y=x';
[X,Y]=meshgrid(x,y);
E = exp(-X.^2/2/sigma_x^2-Y.^2/2/sigma_y^2);
I0 = abs(E).^2;
out_field = Furion_fresnel_spectralh (N,1/L,E ,1e-9,180);
%out_field = Furion_fresnel_spatialh (X,Y,E,1e-9,180);
%out_Field = Furion_fresnel_spatialh (X,Y,E,1e-9,10);
I1 = abs(out_field).^2;
trapz(y,trapz(x,I0,2))
trapz(y,trapz(x,I1,2))
%meshz(X,Y,abs(out_field))
 Furion_intensity_detector(X,Y,out_field,1);
% sum(sum(I0))
% sum(sum(I1))