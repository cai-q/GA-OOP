classdef Const
    % Const 常量类
    %   该类中存储了程序所需的常量
    properties(Constant)
        MAKESPAN_CALCULATION_TYPE = 2;% 计算目标函数的类型，1为常规计算方式（只算最大时间），2为添加了以下参数计算
        MAKESPAN_FACTOR_ALPHA = 1.5;% makespan系数
        MAKESPAN_FACTOR_BETA = 1 / 10.9;% makespan系数
        MAKESPAN_FACTOR_WORKTIME = 480;% makespan系数，每天手术台常规工作时间定义为8小时

        PROCESS_STAGE_NUMBER = 2;% 工序阶段个数，这个量应该硬编码，不能改
        
        V = Variable;% 全局变量，句柄类
        F = Factor;% 参数因子，句柄类
        LF = LearningFactor;
    end
    
end