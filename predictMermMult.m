function varargout=predictMermMult(webpage,hdcut)
% [multLon,multLat]=predictMermMult(webpage,mermaidNum,time)
% 
% Input:
% webpage         The website name with data
%                 (ex:'http://geoweb.princeton.edu/people/simons/SOM/P017_030.txt')
% time            Time desired for prediction in 'dd-mmm-yyyy HH:MM:SS'
%                 (ex: '28-Jun-2019 11:30:00')
% hdcut           Number of lines to cut off the top of the file (def: 0)
% 
% Outputs: 
% multLon         Multiplicative factor of error increase with each week
%                 for longitude 
% multLat         Multiplicative factor of error increase with each week
%                 for latitude
% 
% Description:
% This function returns a scaling factor for error of the prediction (from
% findResiduals) over a specified number of weeks. 
% 
% Last modified by dorisli on June 28, 2019 ver. R2018a

defval('webpage','http://geoweb.princeton.edu/people/simons/SOM/P017_030.txt')
defval('hdcut',0)
defval('numPt',20)
defval('degree',2)

weeks = input('How many weeks predicted? ');
defval('weeks',3)
points = weeks * 2;

errorLon = zeros(1,weeks);
errorLat = zeros(1,weeks);

% getting errors of each week 
x = 1;
for i = 1:2:points
    [meanResLon,meanResLat]=findResiduals(webpage,i,hdcut);
    errorLon(x) = meanResLon;
    errorLat(x) = meanResLat;
    x = x + 1;
end

diffLon = zeros(1,weeks-1);
diffLat = zeros(1,weeks-1);

% finding mult factor of each new week
for i = 2:weeks
    diffLon(i-1) = abs(errorLon(i)/errorLon(i-1));
    diffLat(i-1) = abs(errorLat(i)/errorLat(i-1));
end

% average of all scaling factors
multLon = mean(diffLon);
disp(sprintf('Scaling factor for error over %i weeks = %d',weeks,multLon))

multLat = mean(diffLat);
disp(sprintf('Scaling factor for error over %i weeks = %d',weeks,multLat))

% optional output
varns={multLon,multLat};
varargout=varns(1:nargout);
    

