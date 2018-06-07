classdef GAStrategy
    % Strategy ç®?æ³?ç­???
    %   è¯¥ç±»????äº?å¤?ä¸?ç®?æ³?ç­??¥ï????¹æ??æ¯?ä¸?ç®?æ³?ç­??¥æ?¥ç????ç»???
    
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
                res = res .* (10000 / ind.Fitness);
            else
                res = ind;
            end
        end
        
        function res = GA(needAllResult)
            population = Population(true);
            bestIndividuality = population.bestIndividuality;
            if needAllResult
                res = zeros(Const.F.MAX_GENERATION, 2 * Const.F.POPULATION_SIZE);
            else
                res = 0;
            end
            
            for i = 1:Const.F.MAX_GENERATION
                population = population.selection;% ????
                population = population.crossover;% äº¤å??
                population = population.mutation;% ??å¼?

                currentBestIndividuality = population.bestIndividuality;
                if currentBestIndividuality.Fitness > bestIndividuality.Fitness
                    bestIndividuality = currentBestIndividuality;
                end% ?·æ?°æ?»ä?????ä¼?ä¸?ä½?

                [~, index] = min(population.Fitness);
                population.Individualities{index} = bestIndividuality;
                population.Fitness(index) = bestIndividuality.Fitness;% ç§?ç¾¤ä¸­??å·???ä¸?ä½?è¢?æ·?æ±°ï?è¢??»ä???ä¼?ä¸?ä½??¿æ??

                if needAllResult
                    res(i, :) = [10000 / bestIndividuality.Fitness, 10000 / sum(population.Fitness) * Const.F.POPULATION_SIZE];
                else
                    res = bestIndividuality;
                end
            end
        end
    end
end