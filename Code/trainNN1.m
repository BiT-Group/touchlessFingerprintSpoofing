function [ ] = trainNN1()
clc;
loadParameters;
global parameter;
parameter.numberPCAToUse = 2;

[inputDataSet, targetsSet] = setDataSet1();

if exist('net/', 'dir') ~= 7
    mkdir('net/');
end

localInput = zeros(size(inputDataSet, 1), []);
localTargets = [];

for i = 1:size(targetsSet, 2)
    if targetsSet(i) == -1 || targetsSet(i) == 1
        localInput(:, end + 1) = inputDataSet(:, i);
        localTargets(end + 1) = targetsSet(i);
    end
end

best_perform = Inf;
minERROR = Inf;
best_i = 0;
best_j = 0;

for i = 10:20
    %for k = 10:20
    
    net = feedforwardnet(i);
    %net = feedforwardnet([i k]);
    net = configure(net, localInput, localTargets);
    net.layers{1}.transferFcn = 'tansig';
    net.layers{2}.transferFcn = 'tansig';
    %net.layers{3}.transferFcn = 'tansig';
    %     net.divideFcn = 'dividerand';
    net.divideFcn = 'divideint';
    net.divideParam.trainRatio = 0.33;
    net.divideParam.valRatio = 0.33;
    net.divideParam.testRatio = 0.34;
    net.trainParam.epochs = 1000;
    
    for j = 1:20
        net = init(net);
        net.trainParam.showWindow = false;
        [net, tr] = train(net, localInput, localTargets);
        netTestOutputs = net(localInput(:, tr.testInd));
        ERROR = sum(abs(netTestOutputs-localTargets(:, tr.testInd)))/length(tr.testInd);
        
        if tr.best_tperf < best_perform
            best_perform = tr.best_tperf;
            best_i = i;
            best_j = j;
            minERROR = ERROR;
            save(['net/nnet1.mat'], 'net', 'tr', 'localInput', 'localTargets', 'netTestOutputs');
            %save(['net/nnet1_' num2str(net.layers{1}.dimensions) '.mat'], 'net', 'tr', 'localInput', 'localTargets', 'netTestOutputs');
            % save(['net/nnet1_' num2str(net.layers{1}.dimensions) '_' num2str(net.layers{2}.dimensions) '.mat'], 'net', 'tr', 'localInput', 'localTargets', 'netTestOutputs');
        end
        
        clc
        fprintf('Training NN 1\n===== Current =====\nNeurons: %d\nTraining attempt: %d\nERROR: %f\nPerformance: %f\n=====  Best   =====\nNeurons: %d\nTraining attempt: %d\nERROR: %f\nPerformance: %f', i, j, ERROR, tr.best_tperf, best_i, best_j, minERROR, best_perform);
        
    end
    %end
end

generateMetrics1;

fprintf('\n\n');

%% Visualizing data
% load net/nnet1.mat;

% figure, plot(localTargets(tr.testInd), net(localInput(:, tr.testInd)), 'ro')
% xlabel('Expected')
% ylabel('Predicted')
% grid on

% [netTestOutputs ; localTargets(tr.testInd)]'

end

