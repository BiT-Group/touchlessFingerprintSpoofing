function [ ] = generateMetrics3()
% close all;
clear all;
% clc;

load net/nnet3.mat

testInputSet = inputDataSet(:,tr.testInd);
testTargetSet = targetsSet(:,tr.testInd);

hitRate = 0;

confusionMatrix = zeros(size(testTargetSet, 1));

for i = 1:size(testInputSet, 2)
    %% Classification
    netEvaluation = WTA(net(testInputSet(:, i)));
    
    %% Updating metrics
    [~, predictedClass] = max(netEvaluation);
    [~, originalClass] = max(testTargetSet(:, i));
    confusionMatrix(originalClass, predictedClass) = confusionMatrix(originalClass, predictedClass) + 1;
    % Outro possível classificador
%     x = [1 -1 -1 -1]
%     y = x>0
%     bi2de(y)
    
    if isequal(netEvaluation, testTargetSet(:, i))
        hitRate = hitRate + 1;
    end
end

hitRate = hitRate/i;

fprintf('\n\nnnet:\nHit Rate: %.2f%%\n', hitRate*100);

%% Print confusion matrix
for i = 1:size(confusionMatrix, 1)
   confusionMatrix(i,:) = (confusionMatrix(i,:)/sum(confusionMatrix(i,:)))*100;
end

fprintf('\nConfusion Matrix\n');
display(confusionMatrix);

end