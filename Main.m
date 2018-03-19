population = Population(true);
bestIndividuality = population.bestIndividuality;

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
    
    disp([bestIndividuality.Fitness, sum(population.Fitness) / Const.POPULATION_SIZE]);
end