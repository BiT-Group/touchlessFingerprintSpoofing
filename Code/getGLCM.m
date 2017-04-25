function [ glcm ] = getGLCM( input, mask )

% offset = [0, 1; 0, -1; 1, 0; -1, 0; 1, 1; 1, -1; -1, -1; -1, 1];

fprintf('\nCalculating GLCM...\n');
% glcm = graycomatrix(input, 'NumLevels', 256, 'Offset', offset);

input = input + 1;

glcm = zeros(256, 256, 8);

for i = 2:size(mask, 1) - 1
    for j = 2:size(mask, 2) - 1
        % Checking Moore neighborhood
        if mask(i, j + 1) == 1 && mask(i, j - 1) == 1 && mask(i + 1, j) == 1 && mask(i - 1, j) == 1 && mask(i + 1, j + 1) == 1 && mask(i + 1, j - 1) == 1 && mask(i - 1, j - 1) == 1 && mask(i - 1, j + 1) == 1
            % Right
            glcm(input(i, j), input(i, j + 1), 1) = glcm(input(i, j), input(i, j + 1), 1) + 1;
            % Left
            glcm(input(i, j), input(i, j - 1), 2) = glcm(input(i, j), input(i, j - 1), 2) + 1;
            % Down
            glcm(input(i, j), input(i + 1, j), 3) = glcm(input(i, j), input(i + 1, j), 3) + 1;
            % Up
            glcm(input(i, j), input(i - 1, j), 4) = glcm(input(i, j), input(i - 1, j), 4) + 1;
            % Down-right
            glcm(input(i, j), input(i + 1, j + 1), 5) = glcm(input(i, j), input(i + 1, j + 1), 5) + 1;
            % Down-left
            glcm(input(i, j), input(i + 1, j - 1), 6) = glcm(input(i, j), input(i + 1, j - 1), 6) + 1;
            % Up-left
            glcm(input(i, j), input(i - 1, j - 1), 7) = glcm(input(i, j), input(i - 1, j - 1), 7) + 1;
            % Up-right
            glcm(input(i, j), input(i - 1, j + 1), 8) = glcm(input(i, j), input(i - 1, j + 1), 8) + 1;
        end
    end
end

end

