function [ inputDataSet, targetsSet ] = setDataSet1()

global parameter;

textureDescriptorsFolderRoot = 'textureDescriptors/';
folders = dir('textureDescriptors\');
folders = folders(3:size(folders, 1));

inputDataSet = [];
targetsSet = [];
target = 0;

for i = 1:size(folders, 1)
    textureDescriptorsFiles = dir(strcat(textureDescriptorsFolderRoot, num2str(i), '/*.mat'));
    
    if any(i == 1) == 1
        target = 1;
    else
        target = -1;
    end
    
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