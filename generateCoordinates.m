function [A] = generateCoordinates(r,c)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
for i = 1 : r
    for j = 1 : c
        X(c*(i-1)+j) = 300;
        Y(c*(i-1)+j) = c/2-j;
        Z(c*(i-1)+j) = r/2-i;
    end
end
A = [X' Y' Z'];
end

