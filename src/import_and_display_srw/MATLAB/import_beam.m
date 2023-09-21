classdef import_beam<handle
    %IMPORT_BEAM 此处显示有关此类的摘要
    %   此处显示详细说明    
    properties
        X;% X网格点
        Y;% Y网格点
        Z_intensity;   %网格点处的强度
        Z_phase;       %网格点处的相位
        Nx;            %网格点X方向的数量
        Ny;            %网格点Y方向的数量
        scale_x;       %缩放系数
        scale_y;       %缩放系数
        field;         %网格点处的光的复数场强
    end 
    
    methods
        function obj =import_beam(intensity_address)
            intensity_data = dlmread(intensity_address);% 从文件中导入 .data数据
            data =intensity_data;                       % 
            row=data(:,1);%行号
            colum=data(:,2);%列号
            z=data(:,3);%数据
            N_colum= sum(row(:)==0);%行数
            N_row = sum(colum(:)==0);%列数
            obj.X = reshape(colum,[N_colum,N_row])';
            obj.Y = reshape(row,[N_colum,N_row])';
            obj.Z_intensity = reshape(z,[N_colum,N_row])';
            obj.Ny = N_colum;
            obj.Nx = N_row ;
            
        end        
    end
    
    methods
        function import_phase(obj,phase_address)   %从文件中导入相位数据
            phase_data = dlmread(phase_address);  
            data =phase_data;
            row=data(:,1);%行号
            colum=data(:,2);%列号
            z=data(:,3);%数据
            N_colum= sum(row(:)==0);%行数
            N_row = sum(colum(:)==0);%列数
            %obj.X = reshape(colum,[N_colum,N_row])';
            %obj.Y = reshape(row,[N_colum,N_row])';
            obj.Z_phase = reshape(z,[N_colum,N_row])';
            obj.field = sqrt(obj.Z_intensity).*exp(1i.*obj.Z_phase) ;
        end        
    end    
  
    
    methods
        function coordinate_transform(obj,x_max,x_min,y_max,y_min)%坐标转换，SRW给出的数据是矩阵，需要和相应的X和Y坐标对应上
                 length_X = max(max(obj.X));
                 length_Y = max(max(obj.Y));
                 obj.scale_x =(x_max - x_min)./length_X;
                 obj.scale_y =(y_max - y_min)./length_Y;
                 obj.X    = (obj.X.*obj.scale_x - x_max);
                 obj.Y    = (obj.Y.*obj.scale_y - y_max);
        end        
    end
    
    methods
        function coordinate_diffraction(obj,shift_X,shift_Y)%对衍射光线偏移位移
             obj.Z_intensity = circshift(obj.Z_intensity,round(shift_X/obj.scale_x),2) ;
             obj.Z_intensity = circshift(obj.Z_intensity,round(shift_Y/obj.scale_y),1) ;   
             obj.Z_phase     = circshift(obj.Z_phase,round(shift_X/obj.scale_x),2) ;
             obj.Z_phase     = circshift(obj.Z_phase,round(shift_Y/obj.scale_y),1) ; 
             obj.field = circshift(obj.field,round(shift_X/obj.scale_x),2) ;
             obj.field = circshift(obj.field,round(shift_Y/obj.scale_y),1) ;
        end        
    end    
    
     methods
        function phase_plot(obj)      %做出相位图
             Furion_phase_detector(obj.X*1e-6,obj.Y*1e-6,obj.field,1);
        end        
     end  
    
    methods
        function intensity_plot(obj)  %做出强度图
            Furion_intensity_detector(obj.X*1e-6,obj.Y*1e-6,obj.field,1);          
        end        
    end
    
    methods         %计算
        function p = power(obj,dx,dy)
            p = sum(sum(obj.Z_intensity))*dx*dy;%计算总的功率
        end
    end
end

