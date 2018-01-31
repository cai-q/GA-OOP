classdef Population
    % POPULATION  种群模型
    %   种群模型，包含个体的数组与其相应的适应度数组
    %
    %   See also Individuality, Const
    
    properties
        Size;% 种群大小
        Individualities;% 种群中个体的数组
        Fitness;% 种群的适应度数组
    end
    
    methods
        function obj = Population(initiate)
            % Population 初始化过程
            % 1. 创建每个个体
            % 2. 将其适应度存入适应度数组
            
            obj.Size = Const.POPULATION_SIZE;
            obj.Individualities = cell(1, obj.Size);
            obj.Fitness = zeros(1, obj.Size);
            
            if initiate
                for i = 1:obj.Size
                    individuality = Individuality(false);
                    obj.Individualities{i} = individuality;
                    obj.Fitness(1, i) = individuality.Fitness;
                end
            end
        end
        
        function ret = bestIndividuality(obj)
            [~, b] = max(obj.Fitness);
            ret = obj.Individualities{b};
        end
        
        function obj = selection(obj)
            % selection  选择过程
            % 1. 计算Fitness数组累积和，归一化至（0，1）
            % 2. 轮盘赌法进行选择
            
            oldIndividualities = obj.Individualities;
            oldFitness = obj.Fitness;
            
            q = mapminmax(cumsum(oldFitness), 0, 1);% 归一化
            
            for i = 1:Const.POPULATION_SIZE
                selected = find(q >= rand);
                obj.Individualities{1, i} = oldIndividualities{selected(1)};
                obj.Fitness(1, i) = oldFitness(selected(1));
            end % 轮盘赌法选择个体
        end
        
        function obj = crossover(obj)
            % crossover 交叉过程
                       
            for i=1:2:(Const.POPULATION_SIZE - 1)
                parent_1 = obj.Individualities{i};
                parent_2 = obj.Individualities{1 + 1};
                [child_1, child_2] = parent_1.crossoverWith(parent_2);
                
                obj.Individualities{i} = child_1;
                obj.Individualities{i + 1} = child_2;
                obj.Fitness(i) = child_1.Fitness;
                obj.Fitness(i + 1) = child_2.Fitness;
            end
        end
        
        function obj = mutation(obj)
            % mutation 变异过程
            
            for i=1:Const.POPULATION_SIZE
                if rand < Const.MUTATION_PROBABILITY
                    obj.Individualities{i} = obj.Individualities{i}.mutation;
                    obj.Fitness(i) = obj.Individualities{i}.Fitness;
                end
            end
        end
        
        function obj = learning(obj)
            % learning 学习过程
            
            SD = obj.getSocialDataset();
            RD = obj.getRandomDataset();
            matSD = SD.getPopulationalGeneMatrix();
            matRD = RD.getPopulationalGeneMatrix();
            
            for i = 1:Const.POPULATION_SIZE
                obj.Individualities{i} = obj.Individualities{i}.learning(matSD, matRD);
                obj.Fitness(i) = obj.Individualities{i}.Fitness;
            end
        end
    end
    
    methods(Access = protected)
        function ret = getSocialDataset(obj)
            % getSocialDataset 获取社会学习对象SD
            %   该函数返回一个新的种群，是依照当前种群构建的社会学习对象
            %   返回的社会学习对象是已排好序的数组，并且取适应度前50%复制一次
            
            ret = obj;
            [~, index] = sort(ret.Fitness, 'descend');
            ret.Individualities = ret.Individualities(index);
            ret.Fitness = ret.Fitness(index);
            
            halfChromosome = ret.Individualities(:, 1:Const.POPULATION_SIZE / 2);
            halfFitness = ret.Fitness(:, 1:Const.POPULATION_SIZE / 2);
            ret.Individualities = [halfChromosome, halfChromosome];
            ret.Fitness = [halfFitness, halfFitness];
        end
        
        function ret = getRandomDataset(~)
            % getRandomDataset 获取随机学习对象RD
            %   该函数返回一个新的，随机生成的种群，并且按照适应度大小排序
            ret = Population(true);
            [~, index] = sort(ret.Fitness, 'descend');
            ret.Individualities = ret.Individualities(index);
            ret.Fitness = ret.Fitness(index);
        end
        
        function ret = getPopulationalGeneMatrix(obj)
            % getPopulationalGeneMatrix 获取种群的基因矩阵
            %   该函数返回一个种群的基因矩阵，包含种群所有个体的基因
            
            ret = zeros(2, Const.POPULATION_SIZE * Const.JOB_NUMBER);
            for i = 1:Const.POPULATION_SIZE
                start = (i - 1) * Const.JOB_NUMBER + 1;
                finish = i * Const.JOB_NUMBER;
                ret(:, start:finish) = obj.Individualities{i}.Chromosome.Sequence;
            end
        end
    end
end