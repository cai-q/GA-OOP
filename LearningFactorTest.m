% 对参数因子进行正交实验

learningFactor = [
    0.2, 0.4, 0.6, 0.8, 0;
    0.2, 0.4, 0.5, 0.7, 0;
    0.2, 0.5, 0.6, 0.8, 0;
    0.3, 0.5, 0.6, 0.8, 0
];% 选取16组参数组合进行正交实验

Const.V.update([3,6,4,75]);% 选取中等规模的固定环境变量

for i = 1:4
    Const.LF.update(learningFactor(i, :))
    res = zeros(1, 20);
    for j = 1:20
        res(1, j) = 10000 / Strategy.ALBGA(false);
    end
    learningFactor(i, 5) = mean(res);    
end

learningFactor = [(1:4)' learningFactor];% 加上编号

table = array2table(learningFactor, 'VariableNames', {...
    'No', 'P1_MIN', 'P1_MAX', 'P2_MIN', 'P2_MAX', 'AVG'...
});
writetable(table, 'LearningFactorTest.xlsx', 'WriteRowNames', true);
