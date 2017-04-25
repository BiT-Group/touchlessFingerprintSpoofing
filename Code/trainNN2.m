function [ ] = trainNN2()
clc;
loadParameters;
global parameter;
parameter.numberPCAToUse = 8;

[inputDataSet, targetsSet] = setDataSet23();

if exist('net/', 'dir') ~= 7
    mkdir('net/');
end

for targetClass = 2:size(targetsSet, 1)
    [netInputs, netTargets] = reshapeSetsForClass(inputDataSet, targetsSet, targetClass);
    
    best_perform = Inf;
    minERROR = Inf;
    best_i = 0;
    best_j = 0;
    netOutputFileName = strcat('net/nnet2_1_vs_', num2str(targetClass), '.mat');

    for i = 10:20
        net = feedforwardnet(i);
        net = configure(net, netInputs, netTargets);
        net.layers{1}.transferFcn = 'tansig';
        net.layers{2}.transferFcn = 'tansig';
    %     net.divideFcn = 'dividerand';
        net.divideFcn = 'divideint';
        net.divideParam.trainRatio = 0.33;
        net.divideParam.valRatio = 0.33;
        net.divideParam.testRatio = 0.34;
    %     net.divideParam.trainRatio = 0.7;
    %     net.divideParam.valRatio = 0.15;
    %     net.divideParam.testRatio = 0.15;
        net.trainParam.epochs = 1000;

        for j = 1:20
            net = init(net);
            net.trainParam.showWindow = false;
            [net, tr] = train(net, netInputs, netTargets);
            netTestOutputs = net(netInputs(:, tr.testInd));
    %         ERROR = sum(abs(netTestOutputs-targetsSet(:, tr.testInd)))/length(tr.testInd);
    %         ERROR = sum(eucledianDistance(WTA(netTestOutputs), targetsSet(:, tr.testInd)))/length(tr.testInd);
            ERROR = sum(eucledianDistance(netTestOutputs, netTargets(:, tr.testInd)))/length(tr.testInd);
%             netTargets(:, tr.testInd)

            if tr.best_tperf < best_perform
                best_perform = tr.best_tperf;
                best_i = i;
                best_j = j;
                minERROR = ERROR;
                save(netOutputFileName, 'net', 'tr', 'netInputs', 'netTargets', 'netTestOutputs');
            end

            clc
            fprintf('Training NN 2: 1 vs %d\n===== Current =====\nNeurons: %d\nTraining attempt: %d\nERROR: %f\nPerformance: %f\n=====  Best   =====\nNeurons: %d\nTraining attempt: %d\nERROR: %f\nPerformance: %f', targetClass, i, j, ERROR, tr.best_tperf, best_i, best_j, minERROR, best_perform);
    %         targetsSet(:, tr.testInd)
        end
    end

    %% Visualizing data
%     load(netOutputFileName);
% 
%     figure, plot(netTargets(tr.testInd), net(netInputs(:, tr.testInd)), 'ro')
%     xlabel('Expected')
%     ylabel('Predicted')
%     grid on

%     [netTestOutputs ; netTargets(:, tr.testInd)]'
end

generateMetrics2;

fprintf('\n\n');

end