function [ x1,y1,z1,error_Final,t_Final] = Furion_bisection ...
    ( t_Min,t_Max,x0,y0,z0,l0,m0,n0,epsilon,R,rho )
%Furion_bisection 
%   modifacation history
%   2021-8-1 create hukai 

p_Min = [x0;y0;z0]+t_Min.*[l0;m0;n0];
p_Max = [x0;y0;z0]+t_Max.*[l0;m0;n0];

rho_Error_min = sqrt((p_Min(1,:)).^2+(sqrt((p_Min(3,:)).^2+(R-p_Min(2,:)).^2)-R+rho).^2)-rho;
rho_Error_max = sqrt((p_Max(1,:)).^2+(sqrt((p_Max(3,:)).^2+(R-p_Max(2,:)).^2)-R+rho).^2)-rho;

t_Final = 0;
error_Final = 0;
t_Mid = (t_Max+t_Min)/2;
p_Mid = [x0;y0;z0]+t_Mid.*[l0;m0;n0];
rho_Error_mid = sqrt((p_Mid(1,:)).^2+(sqrt((p_Mid(3,:)).^2+(R-p_Mid(2,:)).^2)-R+rho).^2)-rho;

while 1
    if rho_Error_min == 0
        t_Final = t_Min;
        error_Final = 0;
        break
    elseif rho_Error_max == 0
        t_Final = t_Max;
        error_Final = 0;
        break
    elseif rho_Error_mid == 0
        t_Final = t_Mid;
        error_Final = 0;
        break
    elseif abs(rho_Error_max)<epsilon
        t_Final = t_Max;
        error_Final = rho_Error_max;
        break
    else
       
        p_Mid = [x0;y0;z0]+t_Mid.*[l0;m0;n0];
        
        rho_Error_mid = sqrt((p_Mid(1,:)).^2+(sqrt((p_Mid(3,:)).^2+(R-p_Mid(2,:)).^2)-R+rho).^2)-rho;
        
        if rho_Error_mid <=0
            t_Min= t_Mid;            
            rho_Error_min = rho_Error_mid;
       
        else 
            t_Max = t_Mid;
            rho_Error_max = rho_Error_mid;          
        end
    end
    t_Mid = (t_Min+t_Max)/2;
end
p_Final = [x0;y0;z0]+ t_Final.*[l0;m0;n0];
    x1 = p_Final(1,:);
    y1 = p_Final(2,:);
    z1 = p_Final(3,:);   
