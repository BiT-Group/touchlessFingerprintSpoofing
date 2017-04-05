function [ inputDataSet, targetsSet ] = setDataSet()

textureDescriptorsFolderRoot = 'textureDescriptors/';
folders = dir('textureDescriptors\');
folders = folders(3:size(folders, 1));
foldersWithRealFingers = [1 5 6];
% foldersWithRealFingers = [1];
% foldersWithObfuscatedFingers = [2 19];

inputDataSet = [];
targetsSet = [];
target = 0;

for i = 1:size(folders, 1)
    textureDescriptorsFiles = dir(strcat(textureDescriptorsFolderRoot, num2str(i), '/*.mat'));
    
    if any(i == foldersWithRealFingers) == 1
        target = 1;
%     elseif any(i == foldersWithObfuscatedFingers) == 1
%         target = 0;
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
inputDataSet = scores(:,2);
inputDataSet = inputDataSet';

end