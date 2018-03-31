classdef LearningFactor < handle
    % LearningFactor 
    %   ����洢��ALBGA�е�ѧϰ����
    %   �����еĳ�Ա�ڼ����������ʱ��Ӧ���ǳ���������ʱ���ı䣩
    %   �����ڴ˾��������Ҫ��Ϊ�������ӵ��������ԣ���������ʱ��ı���Щ������ֵ
    
    properties
        P1_MIN = 0.2;% ѧϰ�����ٽ�ֵp1(min)
        P1_MAX = 0.5;% ѧϰ�����ٽ�ֵp1(max)
        P2_MIN = 0.6;% ѧϰ�����ٽ�ֵp2(min)
        P2_MAX = 0.8;% ѧϰ�����ٽ�ֵp2(max)
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