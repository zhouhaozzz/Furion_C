classdef surfefile3 < no_surfe
    %  导出二维面型误差    
    properties
%         meri_X;%子午防线坐标
%         sag_Y;%弧矢方向坐标
%         V;%高度面型误差值
    end
    
    methods 
        function obj = surfefile3(address)           %初始化数据
             obj.adress=address;
            data = importdata(address).*0.1;              %从地址导入数据，格式为 .dat格式
            x  =-20e-3:0.2e-3:20e-3;                 
            y  =-400e-3:0.25e-3:400e-3;
            [Xd,Yd]=meshgrid(x,y); %设置插值网格大小
            obj.meri_X=Xd;
            obj.sag_Y=Yd;
            obj.V     = reshape(data,size(Xd,1),size(Xd,2));
        end
    end
    
      methods
              function Vq=value(obj,X,Y)           
                   Vq = interp2(obj.meri_X,obj.sag_Y,obj.V,Y,X,'cubic',0);  %通过插值取出固定位置的函数值        
              end
     end   
end

