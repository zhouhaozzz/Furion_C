%测试 Furion_fresnel_spectralh 函数的功能
L=0.004;
N =8000;
sigma_x= 60e-6;
sigma_y= 60e-6;
x=linspace(-L/2,L/2,N);
y=x';
[X,Y]=meshgrid(x,y);
E = exp(-X.^2/2/sigma_x^2-Y.^2/2/sigma_y^2);
I0 = abs(E).^2;
%out_Field = Furion_fresnel_spectralh (N,N/L,E ,1e-9,10);
out_Field = Furion_fresnel_spatialh (X,Y,E,1e-9,10);
%out_Field = Furion_fresnel_spatialh (X,Y,E,1e-9,10);
I1 = abs(out_Field).^2;
 trapz(y,trapz(x,I0,2))
 trapz(y,trapz(x,I1,2))
 meshz(X,Y,abs(out_Field))
% sum(sum(I0))
% sum(sum(I1))