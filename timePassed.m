function [timeElapsed,origin]=timePassed(split,sz,col,n)
% [timeElapsed,origin]=timePassed(split,sz,col,n)
% 
% Input:
% split           From parseMermData, the array of strings containing the
%                 mermaid data
% sz              From parseMermData, how many rows in the data file
% col             From parseMermData, how many columns in the data file
% n               From parseMermData, length of split array 
% 
% Output:
% timeElapsed     An array of elapsed times between the origin and each pt
% origin          The first point in the data file (in datevec format)
% 
% Description: 
% This function gives the time elapsed between the first point (origin)
% and every other point in the data file. 
% 
% Last modified by dorisli on June 25,2019 ver. R2018a
 
timeElapsed = zeros(1,n);
d = strcat(split(2),{' '},split(3));
origin = datevec(d);

x = 2;
for i = (2 + col):col:sz
    d = strcat(split(i),{' '},split(i + 1));
    t = datevec(d);
    timeElapsed(x) = etime(t,origin);
    x = x + 1;
end 