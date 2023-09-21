classdef surfefile1 < no_surfe
    %   一维   
    properties
        meri_X;         %子午方向坐标
        sag_Y;          %弧矢方向坐标
        V;              %面型高度值
    end
    
    methods 
        function obj = surfefile1(address)
            data = importdata(address);        %导入数据文件 .dat格式 数据 一维数据，导入进来后是 2列数组矩阵            
            obj.meri_X=data(:,1);              %数组第一列为子午坐标
            obj.V     = data(:,2);             %数组第二列是面型高度误差值
        end
    end
    
    methods
              function Vq=value(obj,meri_X,~)     %从面型对象中插值获取相应坐标的值，对于一维面型误差，只需要提供子午方向的坐标位置值      
                   Vq = interp1(obj.meri_X,obj.V,meri_X,'PCHIP',0); %茶轴函数，获取相应位置的值    
              end
     end   
end

