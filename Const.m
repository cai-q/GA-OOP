classdef Const
    % Const 常量类
    %   该类中存储了程序所需的常量
    properties(Constant)
        MAX_GENERATION = 200;% 迭代次数
        POPULATION_SIZE = 200;% 种群个数
        CROSSOVER_PROBABILITY = 0.6;% 交叉概率
        MUTATION_PROBABILITY = 0.1;% 变异概率
        
        LEARNING_THRESHOLD_P1_MIN = 0.3;% 学习概率临界值p1
        LEARNING_THRESHOLD_P1_MAX = 0.5;% 学习概率临界值p1
        LEARNING_THRESHOLD_P2_MIN = 0.6;% 学习概率临界值p2
        LEARNING_THRESHOLD_P2_MAX = 0.8;% 学习概率临界值p2
        
        MAKESPAN_FACTOR_ALPHA = 1.5;% makespan系数
        MAKESPAN_FACTOR_BETA = 1 / 10.9;% makespan系数
        MAKESPAN_FACTOR_WORKTIME = 480;% makespan系数，每天手术台常规工作时间定义为8小时

        PROCESS_STAGE_NUMBER = 2;% 工序阶段个数，这个量应该硬编码，不能改
        
        V = Variable;% 全局变量，句柄类
    end
    

end