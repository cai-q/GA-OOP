classdef Strategy
    % Strategy �㷨����
    %   ��������˶���㷨���ԣ��ɸ���ÿ���㷨���������ɽ��
    
    methods(Static)
        function res = SPT()
            res = ones(Const.MAX_GENERATION, 1);
            
            pst = Const.PROCESS_TIME;
            sum_pst = pst(:, 1) + pst(:, 2);
            [~, index] = sort(sum_pst);
            
            sequence = zeros(2, Const.JOB_NUMBER);
            sequence(1, :) = index';
            for i = 1:Const.JOB_NUMBER
                sequence(2, i) = unidrnd(Const.FACTORY_NUMBER);
            end
            
            ind = Individuality(sequence);
            res = res .* ind.Fitness;
        end
        
        function res = GA()
            population = Population(true);
            bestIndividuality = population.bestIndividuality;
            res = zeros(Const.MAX_GENERATION, 2);
            
            for i = 1:Const.MAX_GENERATION
                population = population.selection;% ѡ��
                population = population.crossover;% ����
                population = population.mutation;% ����

                currentBestIndividuality = population.bestIndividuality;
                if currentBestIndividuality.Fitness > bestIndividuality.Fitness
                    bestIndividuality = currentBestIndividuality;
                end% ˢ����������Ÿ���

                [~, index] = min(population.Fitness);
                population.Individualities{index} = bestIndividuality;
                population.Fitness(index) = bestIndividuality.Fitness;% ��Ⱥ�����ĸ��屻��̭�����������Ÿ����滻

                res(i, :) = [bestIndividuality.Fitness, sum(population.Fitness) / Const.POPULATION_SIZE];
            end
        end
        
        function res = LBGA()
            population = Population(true);
            bestIndividuality = population.bestIndividuality;
            res = zeros(Const.MAX_GENERATION, 2);

            p1 = (Const.LEARNING_THRESHOLD_P1_MAX + Const.LEARNING_THRESHOLD_P1_MIN) / 2;
            p2 = (Const.LEARNING_THRESHOLD_P2_MAX + Const.LEARNING_THRESHOLD_P2_MIN) / 2;

            for i = 1:Const.MAX_GENERATION
                population = population.selection;% ѡ��
                population = population.crossover;% ����
                population = population.mutation;% ����

                currentBestIndividuality = population.bestIndividuality;
                if currentBestIndividuality.Fitness > bestIndividuality.Fitness
                    bestIndividuality = currentBestIndividuality;
                end% ˢ����������Ÿ���

                [~, index] = min(population.Fitness);
                population.Individualities{index} = bestIndividuality;
                population.Fitness(index) = bestIndividuality.Fitness;% ��Ⱥ�����ĸ��屻��̭�����������Ÿ����滻

                population = population.learning(p1, p2);% ѧϰ

                res(i, :) = [bestIndividuality.Fitness, sum(population.Fitness) / Const.POPULATION_SIZE];
            end
        end
        
        function res = ALBGA()
            population = Population(true);
            bestIndividuality = population.bestIndividuality;
            res = zeros(Const.MAX_GENERATION, 2);

            p1 = Const.LEARNING_THRESHOLD_P1_MIN;
            p2 = Const.LEARNING_THRESHOLD_P2_MAX;
            p1_step = (Const.LEARNING_THRESHOLD_P1_MAX - Const.LEARNING_THRESHOLD_P1_MIN) / Const.MAX_GENERATION;
            p2_step = (Const.LEARNING_THRESHOLD_P2_MAX - Const.LEARNING_THRESHOLD_P2_MIN) / Const.MAX_GENERATION;

            for i = 1:Const.MAX_GENERATION
                population = population.selection;% ѡ��
                population = population.crossover;% ����
                population = population.mutation;% ����

                currentBestIndividuality = population.bestIndividuality;
                if currentBestIndividuality.Fitness > bestIndividuality.Fitness
                    bestIndividuality = currentBestIndividuality;
                end% ˢ����������Ÿ���

                [~, index] = min(population.Fitness);
                population.Individualities{index} = bestIndividuality;
                population.Fitness(index) = bestIndividuality.Fitness;% ��Ⱥ�����ĸ��屻��̭�����������Ÿ����滻


                p1 = p1 + p1_step;
                p2 = p2 - p2_step;
                population = population.learning(p1, p2);% ѧϰ

                res(i, :) = [bestIndividuality.Fitness, sum(population.Fitness) / Const.POPULATION_SIZE];
            end
        end
    end
end