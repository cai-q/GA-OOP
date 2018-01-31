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
                obj.Sequence = zeros(2, Const.JOB_NUMBER);
                
                obj.Sequence(1, :) = randperm(Const.JOB_NUMBER);
                for i = 1:Const.JOB_NUMBER
                    obj.Sequence(2, i) = unidrnd(Const.FACTORY_NUMBER);
                end% ��ʼ��Ⱦɫ�壬Ϊÿ���������򣬲�Ϊÿ�������������һ������
                
                for i = 1:Const.JOB_NUMBER
                    jobID = obj.Sequence(1, i);
                    jobSpecificFactories = Const.JOB_SPECIFIC_FACTORIES{jobID};
                    if ~isempty(jobSpecificFactories)
                        obj.Sequence(2, i) = randsample(jobSpecificFactories, 1);
                    end
                end% Ϊָ�����ض������Ĺ����޸�Ⱦɫ�����λ
            end
        end
    end
end