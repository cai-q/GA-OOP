classdef Chromosome
    % Chromosome 个体的染色体
    %   每个染色体包含一个基因序列，模型上是一个矩阵，每一位对应其基因编码
    %
    %   See also Const
    
    properties(Access = public)
        Sequence;% 染色体序列内容
    end
    
    methods
        function obj = Chromosome(param)
            % Chromosome 初始化染色体
            %   初始化过程如下：
            %   1. 随机生成染色体基因序列
            %   2. 为指定了特定工厂的工件修复其染色体基因位
            
            if isa(param, 'numeric')
                obj.Sequence = param;
            else
                obj.Sequence = zeros(2, Const.V.JOB_NUMBER);
                
                obj.Sequence(1, :) = randperm(Const.V.JOB_NUMBER);
                for i = 1:Const.V.JOB_NUMBER
                    obj.Sequence(2, i) = randi(Const.V.FACTORY_NUMBER);
                end% 初始化染色体，为每个基因排序，并为每个工件随机分配一个工厂
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
            end% 为指定了特定工厂的工件修复染色体基因位
        end
    end
end