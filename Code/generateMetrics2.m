function [ ] = generateMetrics2()
% close all;
clear all;
% clc;

for targetClass = 2:4
    netOutputFileName = strcat('net/nnet2_1_vs_', num2str(targetClass), '.mat');
    load(netOutputFileName);

    testInputSet = netInputs(:,tr.testInd);
    testTargetSet = netTargets(:,tr.testInd);

    FAR = 0;
    FRR = 0;
    hitRate = 0;

    %% Classification
    netEvaluation = net(testInputSet);
    
    for i = 1:size(netEvaluation, 2)
        
        if netEvaluation(i) <= 0
            netEvaluation(i) = -1;
        else
            netEvaluation(i) = 1;
        end
    
        %% Updating metrics
        if netEvaluation(i) == testTargetSet(i)
            hitRate = hitRate + 1;
        elseif netEvaluation(i) == -1 && testTargetSet(i) == 1
            FRR = FRR + 1;
        elseif netEvaluation(i) == 1 && testTargetSet(i) == -1
            FAR = FAR + 1;
        end
    end

    FAR = FAR/i;
    FRR = FRR/i;
    hitRate = hitRate/i;

    fprintf('\n\n%s:\nHit Rate: %.2f%%\nFalse Accept Rate: %.2f%%\nFalse Negativ Rate: %.2f%%\n', netOutputFileName, hitRate*100, FAR*100, FRR*100);

    %% Ploting regression
%     netOutputs = net(netInputs);
%     trainOutputs = netOutputs(:, tr.trainInd);
%     validationOutputs = netOutputs(:, tr.valInd);
%     testOutputs = netOutputs(:, tr.testInd);
%     trainTargets = netTargets(tr.trainInd);
%     validationTargets = netTargets(tr.valInd);
%     testTargets = netTargets(tr.testInd);
%     figure, plotregression(trainTargets,trainOutputs,'Training', validationTargets,validationOutputs,'Validation', testTargets,testOutputs,'Test', netTargets, netOutputs,'All');
% 
%     figure, plotperform(tr);
end
end