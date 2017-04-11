function [ output ] = WTA(input)
%% Winner-take-all algorithm
[value index] = max(input(:));
[x y] = ind2sub(size(input),index);

[value, dimension] = max(size(input));
output(1:size(input,1), 1:size(input,2)) = -1;

output(x, y) = 1;

end