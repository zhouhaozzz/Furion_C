classdef surfefile4 < no_surfe
    %  导出二维面型误差    
    properties
        meri_X;%子午防线坐标
        sag_Y;%弧矢方向坐标
        V;%高度面型误差值
    end
    
    methods 
        function obj = surfefile4(address)           %初始化数据
             raw_data = importdata(address);%从SRW中导入面型
            first_row = raw_data(1,:);%取出第一行
            sag = first_row(2:end);%第一样去掉第一个数为弧矢坐标
            first_column = raw_data(:,1);%取出第一列
            meri = first_column(2:end);%取出第一列作为子午坐标
            obj.V =raw_data(2:end,2:end);%截取除第一行和第一列以外的面型矩阵  
            
%             data1 = importdata(address);  
%             data=data1(2:end,2:end);%从地址导入数据，格式为 .dat格式
%             x  =-0.015:0.0002:0.015;                
%             y  =-0.15:0.0002:(0.15-0.0002);
            [Xd,Yd]=meshgrid(meri',sag); %设置插值网格大小
            obj.meri_X=Xd;
            obj.sag_Y=Yd;
%             obj.V     = data;%高度误差，可以通过调节系数，改变高度误差值
        end
    end
    
      methods
              function Vq=value(obj,X,Y)           
                   Vq = interp2(obj.meri_X,obj.sag_Y,obj.V,Y,X,'cubic',0);  %通过插值取出固定位置的函数值        
              end
     end   
end

