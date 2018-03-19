classdef Strategy
    % Strategy 算法策略
    %   该类包含了多个算法策略，可根据每个算法策略来生成结果
    
    methods(Static)
        function SPT()
            
        end
        
        function GA()
            population = Population(true);
            bestIndividuality = population.bestIndividuality;
            res = zeros(Const.MAX_GENERATION, 3);
            
            for i = 1:Const.MAX_GENERATION
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

                res(i, :) = [i, bestIndividuality.Fitness, sum(population.Fitness) / Const.POPULATION_SIZE];
            end
            
            table = array2table(res, 'VariableNames', {'Generation', 'BestFitness', 'AverageFitness'});
            writetable(table, 'GA.txt', 'Delimiter', '\t', 'WriteRowNames', true);
            
            figure;
            plot(res(:, 1), res(:, 2), res(:, 1), res(:, 3));
            title('GA (Genetic Algorithm)');
            xlabel('Generation');
            ylabel('Fitness');
            legend('best', 'average');
            saveas(gcf, 'GA.png');
        end
        
        function LBGA()
            population = Population(true);
            bestIndividuality = population.bestIndividuality;
            res = zeros(Const.MAX_GENERATION, 3);

            p1 = (Const.LEARNING_THRESHOLD_P1_MAX + Const.LEARNING_THRESHOLD_P1_MIN) / 2;
            p2 = (Const.LEARNING_THRESHOLD_P2_MAX + Const.LEARNING_THRESHOLD_P2_MIN) / 2;

            for i = 1:Const.MAX_GENERATION
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

                res(i, :) = [i, bestIndividuality.Fitness, sum(population.Fitness) / Const.POPULATION_SIZE];
            end
            
            table = array2table(res, 'VariableNames', {'Generation', 'BestFitness', 'AverageFitness'});
            writetable(table, 'LBGA.txt', 'Delimiter', '\t', 'WriteRowNames', true);
            
            figure;
            plot(res(:, 1), res(:, 2), res(:, 1), res(:, 3));
            title('LBGA (Learning-Based Genetic Algorithm)');
            xlabel('Generation');
            ylabel('Fitness');
            legend('best', 'average');
            saveas(gcf, 'LBGA.png');
        end
        
        function ALBGA()
            population = Population(true);
            bestIndividuality = population.bestIndividuality;
            res = zeros(Const.MAX_GENERATION, 3);

            p1 = Const.LEARNING_THRESHOLD_P1_MIN;
            p2 = Const.LEARNING_THRESHOLD_P2_MAX;
            p1_step = (Const.LEARNING_THRESHOLD_P1_MAX - Const.LEARNING_THRESHOLD_P1_MIN) / Const.MAX_GENERATION;
            p2_step = (Const.LEARNING_THRESHOLD_P2_MAX - Const.LEARNING_THRESHOLD_P2_MIN) / Const.MAX_GENERATION;

            for i = 1:Const.MAX_GENERATION
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

                res(i, :) = [i, bestIndividuality.Fitness, sum(population.Fitness) / Const.POPULATION_SIZE];
            end
            
            table = array2table(res, 'VariableNames', {'Generation', 'BestFitness', 'AverageFitness'});
            writetable(table, 'ALBGA.txt', 'Delimiter', '\t', 'WriteRowNames', true);
            
            figure;
            plot(res(:, 1), res(:, 2), res(:, 1), res(:, 3));
            title('ALBGA (Adapted Learning-Based Genetic Algorithm)');
            xlabel('Generation');
            ylabel('Fitness');
            legend('best', 'average');
            saveas(gcf, 'ALBGA.png');
        end
    end
end