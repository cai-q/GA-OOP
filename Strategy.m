classdef Strategy
    % Strategy 算法策略
    %   该类包含了多个算法策略，可根据每个算法策略来生成结果
    
    methods(Static)
        function res = SPT(needAllResult)
            if needAllResult
                res = ones(Const.F.MAX_GENERATION, 1);
            else
                res = 0;
            end
            
            pst = Const.V.PROCESS_TIME;
            sum_pst = pst(:, 1) + pst(:, 2);
            [~, index] = sort(sum_pst);
            
            sequence = zeros(2, Const.V.JOB_NUMBER);
            sequence(1, :) = index';
            for i = 1:Const.V.JOB_NUMBER
                sequence(2, i) = unidrnd(Const.V.FACTORY_NUMBER);
            end
            
            ind = Individuality(sequence);
            
            if(needAllResult)  
                res = res .* ind.Fitness;
            else
                res = ind.Fitness;
            end
        end
        
        function res = GA(needAllResult)
            population = Population(true);
            bestIndividuality = population.bestIndividuality;
            if needAllResult
                res = zeros(Const.F.MAX_GENERATION, 2);
            else
                res = 0;
            end
            
            for i = 1:Const.F.MAX_GENERATION
                population = population.selection;% 选择
                population = population.crossover;% 交叉
                population = population.mutation;% 变异

                currentBestIndividuality = population.bestIndividuality;
                if currentBestIndividuality.Fitness > bestIndividuality.Fitness
                    bestIndividuality = currentBestIndividuality;
                end% 刷新总体的最优个体

                [~, index] = min(population.Fitness);
                population.Individualities{index} = bestIndividuality;
                population.Fitness(index) = bestIndividuality.Fitness;% 种群中最差的个体被淘汰，被总体最优个体替换

                if needAllResult
                    res(i, :) = [bestIndividuality.Fitness, sum(population.Fitness) / Const.F.POPULATION_SIZE];
                else
                    res = bestIndividuality.Fitness;
                end
            end
        end
        
        function res = LBGA(needAllResult)
            population = Population(true);
            bestIndividuality = population.bestIndividuality;
            if needAllResult
                res = zeros(Const.F.MAX_GENERATION, 2);
            else
                res = 0;
            end

            p1 = (Const.LF.P1_MAX + Const.LF.P1_MIN) / 2;
            p2 = (Const.LF.P2_MAX + Const.LF.P2_MIN) / 2;

            for i = 1:Const.F.MAX_GENERATION
                population = population.selection;% 选择
                population = population.crossover;% 交叉
                population = population.mutation;% 变异

                currentBestIndividuality = population.bestIndividuality;
                if currentBestIndividuality.Fitness > bestIndividuality.Fitness
                    bestIndividuality = currentBestIndividuality;
                end% 刷新总体的最优个体

                [~, index] = min(population.Fitness);
                population.Individualities{index} = bestIndividuality;
                population.Fitness(index) = bestIndividuality.Fitness;% 种群中最差的个体被淘汰，被总体最优个体替换

                population = population.learning(p1, p2);% 学习

                if needAllResult
                    res(i, :) = [bestIndividuality.Fitness, sum(population.Fitness) / Const.F.POPULATION_SIZE];
                else
                    res = bestIndividuality.Fitness;
                end
            end
        end
        
        function res = ALBGA(needAllResult)
            population = Population(true);
            bestIndividuality = population.bestIndividuality;
            if needAllResult
                res = zeros(Const.F.MAX_GENERATION, 2);
            else
                res = 0;
            end

            p1 = Const.LF.P1_MIN;
            p2 = Const.LF.P2_MAX;
            p1_step = (Const.LF.P1_MAX - Const.LF.P1_MIN) / Const.F.MAX_GENERATION;
            p2_step = (Const.LF.P2_MAX - Const.LF.P2_MIN) / Const.F.MAX_GENERATION;

            for i = 1:Const.F.MAX_GENERATION
                population = population.selection;% 选择
                population = population.crossover;% 交叉
                population = population.mutation;% 变异

                currentBestIndividuality = population.bestIndividuality;
                if currentBestIndividuality.Fitness > bestIndividuality.Fitness
                    bestIndividuality = currentBestIndividuality;
                end% 刷新总体的最优个体

                [~, index] = min(population.Fitness);
                population.Individualities{index} = bestIndividuality;
                population.Fitness(index) = bestIndividuality.Fitness;% 种群中最差的个体被淘汰，被总体最优个体替换


                p1 = p1 + p1_step;
                p2 = p2 - p2_step;
                population = population.learning(p1, p2);% 学习

                if needAllResult
                    res(i, :) = [bestIndividuality.Fitness, sum(population.Fitness) / Const.F.POPULATION_SIZE];
                else
                    res = bestIndividuality.Fitness;
                end
            end
        end
    end
end