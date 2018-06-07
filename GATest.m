% 构建测试矩阵
F = [2, 3, 4];
M1 = [4, 6, 8];
M2 = [3, 4, 6];
N = [50, 75, 100];

LF = length(F);
LM = length(M1);
LN = length(N);
TM = zeros(LF * LM * LN, 10);% test matrix

for i = 1:LF
    for j = 1:LM
        for k = 1:LN
            row = (i - 1) * LM * LN + (j - 1) * LN + k;
            TM(row, 1:4) = [F(i), M1(j), M2(j), N(k)];
        end
    end
end

% 测试开始
for i = 1:length(TM(:, 1))
    % 更新变量
    V = Const.V;
    V.update(TM(i, :));

    tic;% 做一次SPT
    SPT =  GAStrategy.SPT(false);
    
    GA = GAStrategy.GA(false);
    
    TM(i, 5) = 10000 / SPT.Fitness;
    TM(i, 6) = 10000 / GA.Fitness;
end

TM = [(1:length(TM(:, 1)))' TM];

table = array2table(TM, 'VariableNames', {...
    'No', 'F', 'M1', 'M2', 'N', 'SPTFIT', 'GAFIT'});
writetable(table, 'GATest.xlsx', 'WriteRowNames', true);
