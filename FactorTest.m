% 对参数因子进行正交实验

factor = [
    50, 50, 0.5, 0.01, 0;
    50, 100, 0.6, 0.05, 0;
    50, 150, 0.7, 0.10, 0;
    50, 200, 0.8, 0.15, 0;
    100, 50, 0.6, 0.10, 0;
    100, 100, 0.5, 0.15, 0;
    100, 150, 0.8, 0.01, 0;
    100, 200, 0.7, 0.05, 0;
    150, 50, 0.7, 0.15, 0;
    150, 100, 0.8, 0.10, 0;
    150, 150, 0.5, 0.05, 0;
    150, 200, 0.6, 0.01, 0;
    200, 50, 0.8, 0.05, 0;
    200, 100, 0.7, 0.01, 0;
    200, 150, 0.6, 0.15, 0;
    200, 200, 0.5, 0.10, 0
];% 选取16组参数组合进行正交实验

Const.V.update([3,6,4,75]);% 选取中等规模的固定环境变量

for i = 1:16
    Const.F.update(factor(i, :));
    res = zeros(1, 5);
    for j = 1:5
        res(1, j) = 10000 / Strategy.ALBGA(false);
    end
    factor(i, 5) = mean(res);    
end

factor = [(1:16)' factor];% 加上编号

table = array2table(factor, 'VariableNames', {...
    'No', 'POP', 'GEN', 'CR', 'MR', 'AVG'...
});
writetable(table, 'FactorTest.xlsx', 'WriteRowNames', true);
