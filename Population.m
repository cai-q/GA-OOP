classdef Population
    % POPULATION  ��Ⱥģ��
    %   ��Ⱥģ�ͣ��������������������Ӧ����Ӧ������
    %
    %   See also Individuality, Const
    
    properties
        Size;% ��Ⱥ��С
        Individualities;% ��Ⱥ�и��������
        Fitness;% ��Ⱥ����Ӧ������
    end
    
    methods
        function obj = Population(initiate)
            % Population ��ʼ������
            % 1. ����ÿ������
            % 2. ������Ӧ�ȴ�����Ӧ������
            
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
            % selection  ѡ�����
            % 1. ����Fitness�����ۻ��ͣ���һ������0��1��
            % 2. ���̶ķ�����ѡ��
            
            oldIndividualities = obj.Individualities;
            oldFitness = obj.Fitness;
            
            q = mapminmax(cumsum(oldFitness), 0, 1);% ��һ��
            
            for i = 1:Const.POPULATION_SIZE
                selected = find(q >= rand);
                obj.Individualities{1, i} = oldIndividualities{selected(1)};
                obj.Fitness(1, i) = oldFitness(selected(1));
            end % ���̶ķ�ѡ�����
        end
        
        function obj = crossover(obj)
            % crossover �������
                       
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
            % mutation �������
            
            for i=1:Const.POPULATION_SIZE
                if rand < Const.MUTATION_PROBABILITY
                    obj.Individualities{i} = obj.Individualities{i}.mutation;
                    obj.Fitness(i) = obj.Individualities{i}.Fitness;
                end
            end
        end
        
        function obj = learning(obj)
            % learning ѧϰ����
            
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
            % getSocialDataset ��ȡ���ѧϰ����SD
            %   �ú�������һ���µ���Ⱥ�������յ�ǰ��Ⱥ���������ѧϰ����
            %   ���ص����ѧϰ���������ź�������飬����ȡ��Ӧ��ǰ50%����һ��
            
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
            % getRandomDataset ��ȡ���ѧϰ����RD
            %   �ú�������һ���µģ�������ɵ���Ⱥ�����Ұ�����Ӧ�ȴ�С����
            ret = Population(true);
            [~, index] = sort(ret.Fitness, 'descend');
            ret.Individualities = ret.Individualities(index);
            ret.Fitness = ret.Fitness(index);
        end
        
        function ret = getPopulationalGeneMatrix(obj)
            % getPopulationalGeneMatrix ��ȡ��Ⱥ�Ļ������
            %   �ú�������һ����Ⱥ�Ļ�����󣬰�����Ⱥ���и���Ļ���
            
            ret = zeros(2, Const.POPULATION_SIZE * Const.JOB_NUMBER);
            for i = 1:Const.POPULATION_SIZE
                start = (i - 1) * Const.JOB_NUMBER + 1;
                finish = i * Const.JOB_NUMBER;
                ret(:, start:finish) = obj.Individualities{i}.Chromosome.Sequence;
            end
        end
    end
end