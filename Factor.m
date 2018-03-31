classdef Factor < handle
    % Factor 
    %   ����洢�������㷨���й����еĹؼ�����
    %   �����еĳ�Ա�ڼ����������ʱ��Ӧ���ǳ���������ʱ���ı䣩
    %   �����ڴ˾��������Ҫ��Ϊ�������ӵ��������ԣ���������ʱ��ı���Щ������ֵ
    
    properties
        MAX_GENERATION = 50;% ��������
        POPULATION_SIZE = 100;% ��Ⱥ����
        CROSSOVER_PROBABILITY = 0.6;% �������
        MUTATION_PROBABILITY = 0.05;% �������
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