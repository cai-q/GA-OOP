classdef Const
    % Const ������
    %   �����д洢�˳�������ĳ���
    properties(Constant)
        MAX_GENERATION = 200;% ��������
        POPULATION_SIZE = 200;% ��Ⱥ����
        CROSSOVER_PROBABILITY = 0.6;% �������
        MUTATION_PROBABILITY = 0.1;% �������
        
        LEARNING_THRESHOLD_P1_MIN = 0.3;% ѧϰ�����ٽ�ֵp1
        LEARNING_THRESHOLD_P1_MAX = 0.5;% ѧϰ�����ٽ�ֵp1
        LEARNING_THRESHOLD_P2_MIN = 0.6;% ѧϰ�����ٽ�ֵp2
        LEARNING_THRESHOLD_P2_MAX = 0.8;% ѧϰ�����ٽ�ֵp2
        
        JOB_NUMBER = 20;% Ⱦɫ��ĳ��ȣ����ߣ�����������
        FACTORY_NUMBER = 3;% ҽԺ������������
        PROCESS_STAGE_NUMBER = 2;% ����׶θ����������Ӧ��Ӳ���룬���ܸ�
        SPECIAL_JOB_RATE = 0.1;% ��Ҫ�ض�ҽԺ�������ƵĲ���������
        
        MAKESPAN_FACTOR_ALPHA = 1.5;% makespanϵ��
        MAKESPAN_FACTOR_BETA = 1 / 10.9;% makespanϵ��
        MAKESPAN_FACTOR_WORKTIME = 480;% makespanϵ����ÿ������̨���湤��ʱ�䶨��Ϊ8Сʱ
        
        SPECIAL_JOB_NUMBER = round(Const.SPECIAL_JOB_RATE * Const.JOB_NUMBER);% ��Ҫ�ض�ҽԺ�Ĳ�������
        SPECIAL_JOBS = sort(randsample(Const.JOB_NUMBER, Const.SPECIAL_JOB_NUMBER));% ���ⲡ���б�
        JOB_SPECIFIC_FACTORIES = Const.generateJobSpecificFactory;% ���ⲡ������ѡ���ҽԺ
        FACTORY_MACHINE_NUMBER = Const.generateFactoryMachineNumber;% ÿ��ҽԺ�Ĳ�������
        PROCESS_TIME = Const.generateProcessTime;% ÿ��������ÿ���׶εĴ���ʱ��
    end
    
    methods(Static, Access = protected)
        function ret = generateJobSpecificFactory()
            ret = cell(1, Const.JOB_NUMBER);
            permFactories = randperm(Const.FACTORY_NUMBER);% �Թ��������������
            
            for i = 1:length(Const.SPECIAL_JOBS)
                ret{Const.SPECIAL_JOBS(i)} = sort(randsample(permFactories, randi([2, Const.FACTORY_NUMBER - 1]))); 
            end
        end
        
        function ret = generateFactoryMachineNumber()
            ret = ones(Const.FACTORY_NUMBER, Const.PROCESS_STAGE_NUMBER) .* 2;
        end
        
        function ret = generateProcessTime()
            ret = zeros(Const.JOB_NUMBER, 2);% Ĭ������
            for i = 1:length(ret)
                ret(i, 1) = randi([30, 300]);
                ret(i, 2) = randi([10, 30]);
            end
        end
    end
end