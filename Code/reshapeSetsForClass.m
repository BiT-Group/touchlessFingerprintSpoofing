function [ newInputs, newTargets ] = reshapeSetsForClass(inputDataSet, targetsSet, targetClass)

global parameter;

newInputs = inputDataSet(:, 1:parameter.numberOfSamplesEachClass); %real finger's inputs
for i = 1:parameter.numberOfSamplesEachClass
    newTargets(:, i) = [1 -1]'; %real finger's targets
end

targetVec = zeros(size(targetsSet, 1), 1) - 1;
targetVec(targetClass) = 1;

for i = 1:size(targetsSet, 2)
    if isequal(targetsSet(:, i), targetVec)
        newInputs = [newInputs inputDataSet(:, i)];
        newTargets = [newTargets [-1 1]'];
    end
end

end

