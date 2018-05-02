Const.V.update([2, 4, 3, 5]);
P = Const.V;

a = zeros(1, 10);
b = zeros(1, 10);
v = Const.V;


parfor i = 1:10
    Const.V.update([2, 4, 3, 1]);
    x = Individuality(false);
    disp(Const.V.JOB_NUMBER);
    disp(x.Chromosome.Sequence);

    disp(10000 / x.Fitness);
    %     a(1, i) = Strategy.SPT(false);
end

% for i = 1:1
%     Const.V.update([2, 4, 3, 1]);
%     x = Individuality(false);
%     disp(Const.V.JOB_NUMBER);
% 
%     disp(x.Chromosome.Sequence);
% 
%     disp(10000 / x.Fitness);
% %     disp(Const.V.PROCESS_TIME)
% %     b(1, i) = Strategy.SPT(false);
% end

