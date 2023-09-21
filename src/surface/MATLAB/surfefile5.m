classdef surfefile5 < no_surfe
    %  导出二维面型误差    
    properties
        meri_X;%子午防线坐标
        sag_Y;%弧矢方向坐标
        V;%高度面型误差值
    end
    
    methods 
        function obj = surfefile5(address)           %初始化数据
            data = importdata(address);              %从地址导入数据，格式为 .dat格式
            x1  =data(1,:);   x=x1(2:end)  ;            
            y1  =-data(:, 1)';y=y1(2:end);
            [Xd,Yd]=meshgrid(x,y); %设置插值网格大小
            obj.meri_X=Xd;
            obj.sag_Y=Yd;
            obj.V     = data(2:end, 2:end)/0.495*0.427;%高度误差，可以通过调节系数，改变高度误差值
        end
    end
    
      methods
              function Vq=value(obj,X,Y)           
                   Vq = interp2(obj.meri_X,obj.sag_Y,obj.V,Y,X,'cubic',0);  %通过插值取出固定位置的函数值        
              end
     end   
end

