function [ ] = generateMetrics2()
% close all;
clear all;
% clc;

for targetClass = 2:4
    netOutputFileName = strcat('net/nnet2_1_vs_', num2str(targetClass), '.mat');
    load(netOutputFileName);

    testInputSet = inputDataSet(:,tr.testInd);
    testTargetSet = targetsSet(:,tr.testInd);

    FAR = 0;
    FRR = 0;
    hitRate = 0;

    for i = 1:size(testInputSet, 2)
        %% Classification
        netEvaluation = net(testInputSet(:, i));
        
        if netEvaluation <= 0
            evaluation = -1;
        else
            evaluation = 1;
        end
    
        %% Updating metrics
        if evaluation == testTargetSet(i)
            hitRate = hitRate + 1;
        elseif evaluation == -1 && testTargetSet(i) == 1
            FRR = FRR + 1;
        elseif evaluation == 1 && testTargetSet(i) == -1
            FAR = FAR + 1;
        end
    end

    FAR = FAR/i;
    FRR = FRR/i;
    hitRate = hitRate/i;

    fprintf('\n\n%s:\nHit Rate: %.2f%%\nFalse Accept Rate: %.2f%%\nFalse Negativ Rate: %.2f%%\n', netOutputFileName, hitRate*100, FAR*100, FRR*100);

    %% Ploting regression
    netOutputs = net(inputDataSet);
    trainOutputs = netOutputs(:, tr.trainInd);
    validationOutputs = netOutputs(:, tr.valInd);
    testOutputs = netOutputs(:, tr.testInd);
    trainTargets = targetsSet(tr.trainInd);
    validationTargets = targetsSet(tr.valInd);
    testTargets = targetsSet(tr.testInd);
    figure, plotregression(trainTargets,trainOutputs,'Training', validationTargets,validationOutputs,'Validation', testTargets,testOutputs,'Test', targetsSet,netOutputs,'All');

    figure, plotperform(tr);
end
end