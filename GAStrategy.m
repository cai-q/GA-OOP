classdef GAStrategy
    % Strategy �?�?�???
    %   该类????�?�?�?�?�?�??��????��??�?�?�?�?�??��?��????�???
    
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
                population = population.crossover;% 交�??
                population = population.mutation;% ??�?

                currentBestIndividuality = population.bestIndividuality;
                if currentBestIndividuality.Fitness > bestIndividuality.Fitness
                    bestIndividuality = currentBestIndividuality;
                end% ?��?��?��?????�?�?�?

                [~, index] = min(population.Fitness);
                population.Individualities{index} = bestIndividuality;
                population.Fitness(index) = bestIndividuality.Fitness;% �?群中??�???�?�?�?�?汰�?�??��???�?�?�??��??

                if needAllResult
                    res(i, :) = [10000 / bestIndividuality.Fitness, 10000 / sum(population.Fitness) * Const.F.POPULATION_SIZE];
                else
                    res = bestIndividuality;
                end
            end
        end
    end
end