% 构建测试矩阵
TM = getTestMatrix();
% 测试开始
for i = 1:length(TM(:, 1))
    % 更新变量
    V = Const.V;
    V.update(TM(i, :));

    tic;
    SPT = doOneSPT();% 做一次SPT
    tSPT = toc;
    
    tic;
    GA = doTenGA(TM(i, :));% 做10次GA
    tGA = toc;
    
    tic;
    LBGA = doTenLBGA();% 做10次LBGA
    tLBGA = toc;
    
    tic;
    ALBGA = doTenALBGA();% 做10次ALBGA
    tALBGA = toc;
    
    TM(i, 5) = SPT;
    TM(i, 6:15) = GA;
    TM(i, 16:25) = LBGA;
    TM(i, 26:35) = ALBGA;
end

TM = [(1:27)' TM];

table = array2table(TM, 'VariableNames', {...
    'No', 'F', 'M1', 'M2', 'N', 'SPT',...
    'GA01', 'GA02', 'GA03', 'GA04', 'GA05', 'GA06', 'GA07', 'GA08', 'GA09', 'GA10', ...
    'LBGA01', 'LBGA02', 'LBGA03', 'LBGA04', 'LBGA05', 'LBGA06', 'LBGA07', 'LBGA08', 'LBGA09', 'LBGA10', ...
    'ALBGA01', 'ALBGA02', 'ALBGA03', 'ALBGA04', 'ALBGA05', 'ALBGA06', 'ALBGA07', 'ALBGA08', 'ALBGA09', 'ALBGA10' ...
});
writetable(table, 'MultipleTest.xlsx', 'WriteRowNames', true);

function ret = calculateRE(a, b)
    % 返回a相对于b的相对偏差。如果a是数组，返回值也是数组
    
    ret = zeros(1, length(a));
    for i = 1:length(a)
        ret(1, i) = (a(1, i) - b) / b * 100;
    end
end

function ret = getTestMatrix()
    F = [2, 3, 4];
    M1 = [4, 6, 8];
    M2 = [3, 4, 6];
    N = [50, 75, 100];

    LF = length(F);
    LM = length(M1);
    LN = length(N);
    ret = zeros(LF * LM * LN, 35);% test matrix

    for i = 1:LF
        for j = 1:LM
            for k = 1:LN
                row = (i - 1) * LM * LN + (j - 1) * LN + k;
                ret(row, 1:4) = [F(i), M1(j), M2(j), N(k)];
            end
        end
    end
end

function ret = doOneSPT()
    ret = zeros(1, 1);
    ret(1, 1) = 10000 / Strategy.SPT(false);
end

function ret = doTenGA(L)
    ret = zeros(1, 10);
    parfor i = 1:10
        Const.V.update(L);
        ret(1, i) = 10000 / Strategy.GA(false);
    end
end

function ret = doTenLBGA()
    ret = zeros(1, 10);
    for i = 1:10
        ret(1, i) = 10000 / Strategy.LBGA(false);
    end
end

function ret = doTenALBGA()
    ret = zeros(1, 10);
    for i = 1:10
        ret(1, i) = 10000 / Strategy.ALBGA(false);
    end
end