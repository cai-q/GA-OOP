classdef Factor < handle
    % Factor 
    %   该类存储了整个算法运行过程中的关键因子
    %   该类中的成员在计算最后结果的时候应该是常量（运行时不改变）
    %   定义在此句柄类中主要是为了做因子的正交测试，正交测试时会改变这些变量的值
    
    properties
        MAX_GENERATION = 200;% 迭代次数
        POPULATION_SIZE = 200;% 种群个数
        CROSSOVER_PROBABILITY = 0.8;% 交叉概率
        MUTATION_PROBABILITY = 0.1;% 变异概率
    end
    
    methods
        function update(obj, f)
            obj.MAX_GENERATION = f(1);
            obj.POPULATION_SIZE = f(2);
            obj.CROSSOVER_PROBABILITY = f(3);
            obj.MUTATION_PROBABILITY = f(4);
        end
    end
end