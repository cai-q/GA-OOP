classdef Chromosome
    % Chromosome �����Ⱦɫ��
    %   ÿ��Ⱦɫ�����һ���������У�ģ������һ������ÿһλ��Ӧ��������
    %
    %   See also Const
    
    properties(Access = public)
        Sequence;% Ⱦɫ����������
    end
    
    methods
        function obj = Chromosome(param)
            % Chromosome ��ʼ��Ⱦɫ��
            %   ��ʼ���������£�
            %   1. �������Ⱦɫ���������
            %   2. Ϊָ�����ض������Ĺ����޸���Ⱦɫ�����λ
            
            if isa(param, 'numeric')
                obj.Sequence = param;
            else
                obj.Sequence = zeros(2, Const.V.JOB_NUMBER);
                
                obj.Sequence(1, :) = randperm(Const.V.JOB_NUMBER);
                for i = 1:Const.V.JOB_NUMBER
                    obj.Sequence(2, i) = randi(Const.V.FACTORY_NUMBER);
                end% ��ʼ��Ⱦɫ�壬Ϊÿ���������򣬲�Ϊÿ�������������һ������
            end
            
            for i = 1:Const.V.JOB_NUMBER
                jobID = obj.Sequence(1, i);
                jobSpecificFactories = Const.V.JOB_SPECIFIC_FACTORIES{jobID};
                if ~isempty(jobSpecificFactories)
                    flag = false;
                    for j = 1:length(jobSpecificFactories)
                        if obj.Sequence(2, i) == jobSpecificFactories(j)
                            flag = true;
                            break;
                        end
                    end
                    
                    if ~flag
                        obj.Sequence(2, i) = jobSpecificFactories(randi(length(jobSpecificFactories)));
                    end
                end
            end% Ϊָ�����ض������Ĺ����޸�Ⱦɫ�����λ
        end
    end
end