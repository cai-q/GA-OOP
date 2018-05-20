classdef Variable < handle
    % Variable 
    %   ����洢�������㷨���й����еĻ�������
    %   ��Const���д洢�Ĳ�ͬ�������ж���Ĳ������п����ڳ������й����иı��
    %   �����ඨ��Ϊ����࣬��ΪConst�ĳ�����Ա
    
    properties
        JOB_NUMBER;% Ⱦɫ��ĳ��ȣ����ߣ�����������
        FACTORY_NUMBER;% ҽԺ������������
        SPECIAL_JOB_RATE;% ��Ҫ�ض�ҽԺ�������ƵĲ���������
        
        SPECIAL_JOB_NUMBER;% ��Ҫ�ض�ҽԺ�Ĳ�������
        SPECIAL_JOBS;% ���ⲡ���б�
        JOB_SPECIFIC_FACTORIES;% ���ⲡ������ѡ���ҽԺ
        FACTORY_MACHINE_NUMBER;% ÿ��ҽԺ�Ĳ�������
        PROCESS_TIME;% ÿ��������ÿ���׶εĴ���ʱ��
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
            permFactories = randperm(obj.FACTORY_NUMBER);% �Թ��������������
            
            for i = 1:length(obj.SPECIAL_JOBS)
                ret{obj.SPECIAL_JOBS(i)} = sort(randsample(permFactories, randi([1, obj.FACTORY_NUMBER - 1]))); 
            end
        end
        
        function ret = generateFactoryMachineNumber(obj, v)
            ret = [ones(obj.FACTORY_NUMBER, 1) .* v(1), ones(obj.FACTORY_NUMBER, 1) .* v(2)];
        end
        
        function ret = generateProcessTime(obj)
            ret = zeros(obj.JOB_NUMBER, 2);% Ĭ������
            for i = 1:length(ret)
                ret(i, 1) = randi([30, 300]);
                ret(i, 2) = randi([10, 30]);
            end
        end
    end
    
end