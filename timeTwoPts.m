function [timeElapsed]=timeTwoPts(split,sz,col,n)
% [timeElapsed]=timeTwoPts(split,sz,col,n)
% 
% Input:
% split        From parseMermData, the array of strings from data file
% sz           From parseMermData, how many rows in data file 
% col          From parseMermData, number of columns in data file 
% n            From parseMermData, size of split array 
% 
% Output:
% timeElapsed  An array of time (in seconds) passed between each point and
%              the point directly before it 
% 
% Description:
% This function calculates the time elapsed (in seconds) between each
% mermaid location and the location previous to it (n and n - 1). 
% 
% Last modified by dorisli on June 25,2019 ver. R2018a

timeElapsed = zeros(1,n);

x = 2;
for i = (2 + col):col:sz
    d = strcat(split(i),{' '},split(i + 1));
    t = datevec(d);
    dPrev = strcat(split(i - col),{' '},split(i + 1 - col));
    tPrev = datevec(dPrev);
    timeElapsed(x) = etime(t,tPrev);
    x = x + 1;
end 