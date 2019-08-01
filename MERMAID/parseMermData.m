function varargout=parseMermData(webpage,hdcut)
% [split,sz,col,n]=parseMermData(webpage,hdcut)
% 
% Input:
% webpage      The name of the webpage with data
%             (ex:'http://geoweb.princeton.edu/people/simons/SOM/P017_030.txt')
% hdcut        Number of lines to cut off the top of the file (def: 0)
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
% Last modified by dorisli June 26, 2019 ver. R2018a

defval('webpage','http://geoweb.princeton.edu/people/simons/SOM/P017_030.txt')
defval('hdcut',0)

% read in and parse the data
webname = webread(webpage);
spli = strsplit(webname);

% Number of columns of the data file
col = 15;

% check to make sure hdcut is less than num of data points
if (hdcut > (length(spli) - 1)/col)
     throw(MException('MyComponent:noSuchVariable',...
        'Value of hdcut exceeds number of data points'))
end

split = spli((hdcut*col)+1:end);
sz = length(split)-1;
n = sz/col; 

% optional output
varns={split,sz,col,n};
varargout=varns(1:nargout);