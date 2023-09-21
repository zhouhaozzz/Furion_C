classdef source  <handle 
    %句柄类，波动光学的光源    
    properties
        L;
        %抽样的网格大小 单位 [m]
        N;
        %抽样的网格数 单位 个
        X;
        %光场的x坐标 单位[m] 二维矩阵
        Y;
        %光场的y坐标 单位 [m] 二维矩阵
        sigma;
        %高斯光的振幅的标准偏差
        field ;
        %光的每个点的标量场，是一个复数，二维矩阵
        wavelength;
        %光的波长，单位[m]
    end
    
    methods
        function obj =source(L,N,sigma,wavelength)
            obj.wavelength =wavelength;
            obj.L=L;
            obj.N =N;
            x = linspace(-obj.L/2,obj.L/2,obj.N);%通过抽样大小和抽样数目形成 x 方向的向量，生成的是 行向量 ；
            y = x';% 生成 y 坐标向量  y坐标向量是列向量 ；
            [X,Y] = meshgrid(x,y); % 从向量生成网格坐标 X Y，X Y 为二维矩阵
            obj.X=X;
            obj.Y =Y;           
            obj.sigma = sigma;
            obj.field = exp(-(X.^2+Y.^2)/2/(sigma)^2);%通过定义生成高斯光；       
        end        
    end
    
    methods
        function beam_=beam_out(obj)        
           beam_ = beam(obj.X,obj.Y,obj.field,obj.wavelength);%通过光源产生波动光束对象
        end
    end
    
end
