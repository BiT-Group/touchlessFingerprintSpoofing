function [ newInputs, newTargets ] = reshapeSetsForClass(inputDataSet, targetsSet, targetClass)

global parameter;

newInputs = inputDataSet(:, 1:parameter.numberOfSamplesEachClass); %real finger's inputs
newTargets(1, 1:parameter.numberOfSamplesEachClass) = 1; %real finger's targets

switch targetClass
    case 2
        targetVec = [-1 1 -1 -1]';
    case 3
        targetVec = [-1 -1 1 -1]';
    case 4
        targetVec = [-1 -1 -1 1]';
    otherwise
        error('Invalid class')
end

for i = 1:size(targetsSet, 2)
    if isequal(targetsSet(:, i), targetVec)
        newInputs = [newInputs inputDataSet(:, i)];
        newTargets = [newTargets -1];
    end
end

end

