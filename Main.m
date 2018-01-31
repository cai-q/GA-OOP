population = Population(true);
bestIndividuality = population.bestIndividuality;

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
    
    population = population.learning;% 学习
    
    disp([bestIndividuality.Fitness, sum(population.Fitness) / Const.POPULATION_SIZE]);
end