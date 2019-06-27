function [mult]=predictMermMult(webpage,mermaidNum,time,hdcut,numPt,degree)
% [mult]=predictMermMult(webpage,mermaidNum,time)
% 
% Input:
% webpage         The website name with data
%                 (ex:'http://geoweb.princeton.edu/people/simons/SOM/P017_030.txt')
% mermaidNum      Number of mermaid (ex: 'P017')
% time            Time desired for prediction in 'dd-mmm-yyyy HH:MM:SS'
%                 (ex: '28-Jun-2019 11:30:00')
% hdcut           Number of lines to cut off the top of the file (def: 0)
% numPt           Number of data points to be used in the regression
%                 (def:20)
% degree          The degree of the polynomial fit (def:3)
% 
% Outputs: 
% mult            Multiplicative factor of error increase with each week
% 
% Description:
% This function returns a scaling factor for error of the prediction (from
% predictMerm) over a specified number of weeks. 
% 
% Last modified by dorisli on June 27, 2019 ver. R2018a

defval('hdcut',0)
defval('numPt',20)
defval('degree',3)

weeks = input('How many weeks predicted? ');
defval('weeks',3)
days = weeks * 7;

errorArray = zeros(1,weeks);

% getting errors of each week 
x = 1;
for i = 7:7:days
    t = datetime(time) + i;
    [~,~,deltaLon,~]=predictMerm(webpage,mermaidNum,t,hdcut,numPt,degree);
    errorArray(x) = deltaLon;
    x = x + 1;
end

diff = zeros(1,weeks - 1);

% finding mult factor of each new week
for i = 2:weeks
    diff(i - 1) = errorArray(i)/errorArray(i - 1);
end

% average of all scaling factors
mult = mean(diff);
disp(sprintf('Scaling factor for error over %i weeks = %d',weeks,mult))
    

