classdef surfefile_from_srw < no_surfe
    %  import surface from SRW    
    properties
%         meri_X;%子午防线坐标
%         sag_Y;%弧矢方向坐标
%         V;%高度面型误差值
    end
    
    methods 
        function obj = surfefile_from_srw(address)           %初始化数据
            obj.adress=address;
             raw_data = textread(address);%从SRW中导入面型
            first_row = raw_data(1,:);%取出第一行
            sag = first_row(2:end);%第一样去掉第一个数为弧矢坐标
            first_column = raw_data(:,1);%取出第一列
            meri = first_column(2:end);%取出第一列作为子午坐标
            obj.V =raw_data(2:end,2:end)';%截取除第一行和第一列以外的面型矩阵              
            [Xd,Yd]=meshgrid(meri, sag); %设置插值网格大小
            obj.meri_X=Xd;
            obj.sag_Y=Yd;
%             obj.V     = data;%高度误差，可以通过调节系数，改变高度误差值
        end
    end
    
      methods
              function Vq=value(obj,X,Y)           
                   Vq = interp2(obj.meri_X,obj.sag_Y,obj.V,X,Y,'cubic',0); 
                   %通过插值取出固定位置的函数值        
              end
     end   
end

