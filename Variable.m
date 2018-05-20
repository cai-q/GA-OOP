classdef Variable < handle
    % Variable 
    %   该类存储了整个算法运行过程中的环境变量
    %   与Const类中存储的不同，该类中定义的参数是有可能在程序运行过程中改变的
    %   将该类定义为句柄类，作为Const的常量成员
    
    properties
        JOB_NUMBER;% 染色体的长度，患者（工件）个数
        FACTORY_NUMBER;% 医院（工厂）个数
        SPECIAL_JOB_RATE;% 需要特定医院才能治疗的病人数比例
        
        SPECIAL_JOB_NUMBER;% 需要特定医院的病人数量
        SPECIAL_JOBS;% 特殊病人列表
        JOB_SPECIFIC_FACTORIES;% 特殊病人所能选择的医院
        FACTORY_MACHINE_NUMBER;% 每个医院的病床数量
        PROCESS_TIME;% 每个工件在每个阶段的处理时间
    end
    
    methods
        function obj = Variable()
            obj.JOB_NUMBER = 20;
            obj.FACTORY_NUMBER = 3;
            obj.SPECIAL_JOB_RATE = 0.1;
            
            obj.SPECIAL_JOB_NUMBER = round(obj.SPECIAL_JOB_RATE * obj.JOB_NUMBER);
            obj.SPECIAL_JOBS = sort(randsample(obj.JOB_NUMBER, obj.SPECIAL_JOB_NUMBER));
            obj.JOB_SPECIFIC_FACTORIES = obj.generateJobSpecificFactory;
            obj.FACTORY_MACHINE_NUMBER = obj.generateFactoryMachineNumber([2,2]);
            obj.PROCESS_TIME = obj.generateProcessTime;
        end
    end
    
    methods
        function update(obj, v)
            obj.JOB_NUMBER = v(1, 4);
            obj.FACTORY_NUMBER = v(1, 1);
            obj.SPECIAL_JOB_RATE = 0.1;
            
            obj.SPECIAL_JOB_NUMBER = round(obj.SPECIAL_JOB_RATE * obj.JOB_NUMBER);
            obj.SPECIAL_JOBS = sort(randsample(obj.JOB_NUMBER, obj.SPECIAL_JOB_NUMBER));
            obj.JOB_SPECIFIC_FACTORIES = obj.generateJobSpecificFactory;
            obj.FACTORY_MACHINE_NUMBER = obj.generateFactoryMachineNumber(v(1, 2:3));
            obj.PROCESS_TIME = obj.generateProcessTime;
        end
    end
    
    methods(Access = protected)
        function ret = generateJobSpecificFactory(obj)
            ret = cell(1, obj.JOB_NUMBER);
            permFactories = randperm(obj.FACTORY_NUMBER);% 对工厂进行随机排列
            
            for i = 1:length(obj.SPECIAL_JOBS)
                ret{obj.SPECIAL_JOBS(i)} = sort(randsample(permFactories, randi([1, obj.FACTORY_NUMBER - 1]))); 
            end
        end
        
        function ret = generateFactoryMachineNumber(obj, v)
            ret = [ones(obj.FACTORY_NUMBER, 1) .* v(1), ones(obj.FACTORY_NUMBER, 1) .* v(2)];
        end
        
        function ret = generateProcessTime(obj)
            ret = zeros(obj.JOB_NUMBER, 2);% 默认两列
            for i = 1:length(ret)
                ret(i, 1) = randi([30, 300]);
                ret(i, 2) = randi([10, 30]);
            end
        end
    end
    
end