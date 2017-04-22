function [ inputDataSet, targetsSet ] = setDataSet23()

global parameter;

textureDescriptorsFolderRoot = 'textureDescriptors/';
folders = dir('textureDescriptors\');
folders = folders(3:size(folders, 1));

inputDataSet = [];
targetsSet = [];
target = zeros(size(folders, 1), 1) - 1;

%% Choosing correct amount of real fingers to match with the other classes
textureDescriptorsFiles = dir(strcat(textureDescriptorsFolderRoot, '1/*.mat'));
target(1) = 1;
    
textureDescriptorsFiles = datasample(textureDescriptorsFiles, parameter.numberOfSamplesEachClass, 'Replace', false);
    
for j = 1:size(textureDescriptorsFiles, 1)
    load(strcat(textureDescriptorsFolderRoot, '1/', textureDescriptorsFiles(j).name));
    textureDescriptor = textureDescriptor';
    
    inputDataSet = [inputDataSet textureDescriptor];
    targetsSet = [targetsSet target];
end

%% Loading fake fingers
for i = 2:size(folders, 1)
    textureDescriptorsFiles = dir(strcat(textureDescriptorsFolderRoot, num2str(i), '/*.mat'));
    
    target(i - 1) = -1;
    target(i) = 1;
    
    for j = 1:size(textureDescriptorsFiles, 1)
        load(strcat(textureDescriptorsFolderRoot, num2str(i), '/', textureDescriptorsFiles(j).name));
        textureDescriptor = textureDescriptor';
        
        inputDataSet = [inputDataSet textureDescriptor];
        targetsSet = [targetsSet target];
    end
end

%% Normalizing data
for i=1:516
    media = mean(inputDataSet(i,:));
    desvio = std(inputDataSet(i,:));
    inputDataSet(i,:) = (inputDataSet(i,:) - media)/desvio;
end

[i, j] = find(isnan(inputDataSet) == 1);
inputDataSet(i, j) = 0;

%% PCA
[coefs,scores,variances,t2] = princomp(inputDataSet');
inputDataSet = scores(:,1:parameter.numberPCAToUse);
inputDataSet = inputDataSet';

end