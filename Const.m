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
        
        JOB_NUMBER = 20;% 染色体的长度，患者（工件）个数
        FACTORY_NUMBER = 3;% 医院（工厂）个数
        PROCESS_STAGE_NUMBER = 2;% 工序阶段个数，这个量应该硬编码，不能改
        SPECIAL_JOB_RATE = 0.1;% 需要特定医院才能治疗的病人数比例
        
        MAKESPAN_FACTOR_ALPHA = 1.5;% makespan系数
        MAKESPAN_FACTOR_BETA = 1 / 10.9;% makespan系数
        MAKESPAN_FACTOR_WORKTIME = 480;% makespan系数，每天手术台常规工作时间定义为8小时
        
        SPECIAL_JOB_NUMBER = round(Const.SPECIAL_JOB_RATE * Const.JOB_NUMBER);% 需要特定医院的病人数量
        SPECIAL_JOBS = sort(randsample(Const.JOB_NUMBER, Const.SPECIAL_JOB_NUMBER));% 特殊病人列表
        JOB_SPECIFIC_FACTORIES = Const.generateJobSpecificFactory;% 特殊病人所能选择的医院
        FACTORY_MACHINE_NUMBER = Const.generateFactoryMachineNumber;% 每个医院的病床数量
        PROCESS_TIME = Const.generateProcessTime;% 每个工件在每个阶段的处理时间
    end
    
    methods(Static, Access = protected)
        function ret = generateJobSpecificFactory()
            ret = cell(1, Const.JOB_NUMBER);
            permFactories = randperm(Const.FACTORY_NUMBER);% 对工厂进行随机排列
            
            for i = 1:length(Const.SPECIAL_JOBS)
                ret{Const.SPECIAL_JOBS(i)} = sort(randsample(permFactories, randi([2, Const.FACTORY_NUMBER - 1]))); 
            end
        end
        
        function ret = generateFactoryMachineNumber()
            ret = ones(Const.FACTORY_NUMBER, Const.PROCESS_STAGE_NUMBER) .* 2;
        end
        
        function ret = generateProcessTime()
            ret = zeros(Const.JOB_NUMBER, 2);% 默认两列
            for i = 1:length(ret)
                ret(i, 1) = randi([30, 300]);
                ret(i, 2) = randi([10, 30]);
            end
        end
    end
end