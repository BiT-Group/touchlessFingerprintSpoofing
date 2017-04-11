function [ distance ] = eucledianDistance( vector1, vector2 )

v1 = vector1(:);
v2 = vector2(:);
distance = 0;

for i = 1:size(v1, 1)
    distance = distance + (v1(i) - v2(i))^2;
end

distance = sqrt(distance);

end