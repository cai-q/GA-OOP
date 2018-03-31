classdef Const
    % Const ������
    %   �����д洢�˳�������ĳ���
    properties(Constant)
        LEARNING_THRESHOLD_P1_MIN = 0.3;% ѧϰ�����ٽ�ֵp1
        LEARNING_THRESHOLD_P1_MAX = 0.5;% ѧϰ�����ٽ�ֵp1
        LEARNING_THRESHOLD_P2_MIN = 0.6;% ѧϰ�����ٽ�ֵp2
        LEARNING_THRESHOLD_P2_MAX = 0.8;% ѧϰ�����ٽ�ֵp2
        
        MAKESPAN_CALCULATION_TYPE = 1;% ����Ŀ�꺯�������ͣ�1Ϊ������㷽ʽ��ֻ�����ʱ�䣩��2Ϊ��������²�������
        MAKESPAN_FACTOR_ALPHA = 1.5;% makespanϵ��
        MAKESPAN_FACTOR_BETA = 1 / 10.9;% makespanϵ��
        MAKESPAN_FACTOR_WORKTIME = 480;% makespanϵ����ÿ������̨���湤��ʱ�䶨��Ϊ8Сʱ

        PROCESS_STAGE_NUMBER = 2;% ����׶θ����������Ӧ��Ӳ���룬���ܸ�
        
        V = Variable;% ȫ�ֱ����������
        F = Factor;% �������ӣ������
        LF = LearningFactor;
    end
end