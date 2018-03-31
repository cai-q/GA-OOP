classdef LearningFactor < handle
    % LearningFactor 
    %   该类存储了ALBGA中的学习因数
    %   该类中的成员在计算最后结果的时候应该是常量（运行时不改变）
    %   定义在此句柄类中主要是为了做因子的正交测试，正交测试时会改变这些变量的值
    
    properties
        P1_MIN = 0.2;% 学习概率临界值p1(min)
        P1_MAX = 0.5;% 学习概率临界值p1(max)
        P2_MIN = 0.6;% 学习概率临界值p2(min)
        P2_MAX = 0.8;% 学习概率临界值p2(max)
    end
    
    methods
        function update(obj, f)
            obj.P1_MIN = f(1);
            obj.P1_MAX = f(2);
            obj.P2_MIN = f(3);
            obj.P2_MAX = f(4);
        end
    end
end