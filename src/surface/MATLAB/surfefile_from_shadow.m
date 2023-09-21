classdef surfefile_from_shadow < no_surfe
    % 导入shadow的面型误差
    properties
%         meri_X;
%         %子午防线坐标
%         sag_Y;
%         %弧矢方向坐标
%         V;
%         %高度面型误差值
    end    
    methods 
        function obj = surfefile_from_shadow(address)  
            %导入数据
            obj.adress=address;
            data=textread(address);                       
            %从地址导入数据，格式为 .dat格式  
            data1=data(2:end,:); 
            %去掉第一行数据得到新的数据
            x0=data1(1,:);          %得到子午坐标
            x=x0(1:end-1);%去掉最后一个数
            data2=data1(2:end,:);  %再去掉一行数据
            y=data2(:,1)';         %得到弧失坐标  
            data3=data2(:,2:end)';%去掉第一列
            [Xd,Yd]=meshgrid(x,y); %设置插值网格大小
            obj.meri_X=Xd;         %子午方向
            obj.sag_Y=Yd;          %弧失方向
            obj.V= data3';
            %数据reshape
        end
    end
    
      methods
         function Vq=value(obj,X,Y)           
             Vq = interp2(obj.meri_X,obj.sag_Y,obj.V,X,Y,'linear',0);  
             %通过插值取出固定位置的函数值        
        end
     end   
end

