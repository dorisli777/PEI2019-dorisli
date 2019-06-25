function [split,sz,col,n]=parseMermData(webpage)
% [split,sz,col,n]=parseMermData(webpage)
% 
% Input:
% webpage      The name of the webpage with data
%             (ex: 'http://geoweb.princeton.edu/people/simons/SOM/P017_030.txt')
% 
% Output:
% split        The array of strings from data file
% sz           How many rows in data file 
% col          Number of columns in data file 
% n            Size of split array 
% 
% Description:
% This function takes in Mermaid data and separates it by whitespace into 
% different string arrays.
% 
% Last modified by dorisli June 24, 2019

% read in and parse the data
webname = webread(webpage);
split = strsplit(webname);

sz = length(split)-1;
% Number of columns of the data file
col = 15;
n = sz/col; 