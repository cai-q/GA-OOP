population = Population(true);
bestIndividuality = population.bestIndividuality;

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
    
    population = population.learning;% ѧϰ
    
    disp([bestIndividuality.Fitness, sum(population.Fitness) / Const.POPULATION_SIZE]);
end