function varargout=findResiduals(webpage,predFac,hdcut)
% [meanResLon,meanResLat]=findResiduals(webpage,predFac,hdcut)
% 
% Inputs:
% webpage         The website name with data
%                 (ex:'http://geoweb.princeton.edu/people/simons/SOM/P017_030.txt')
% predFac         How many points in the future you want to predict 
% hdcut           Number of lines to cut off the top of the file (def: 0)
% 
% Outputs: 
% meanResLon      Residual values of predicting the longitudes
% meanResLat      Residual values of predicting the latitudes
% 
% Description:
% This function returns the mean residual of prediction for latitude and
% longitude of the next location and time through polyfit. 
% 
% Last modified by dorisli on June 28, 2019 ver. R2018a

defval('webpage','http://geoweb.princeton.edu/people/simons/SOM/P017_030.txt')
defval('predFac',5)
defval('hdcut',0) 

% ask for user input for pts used in regression and order of polynomial 
numPts = input('How many points for regression: ');
degree = input('Order of polynomial: ');

defval('numPts',20)
defval('degree',2)

% read in and parse the data
[split,sz,col,n]=parseMermData(webpage,hdcut);  

% check to make sure # of regression pts is fewer than # of data pts
if (numPts > n)
     throw(MException('MyComponent:noSuchVariable',...
        'Value of pts for regression exceeds number of data points'))
end

% initialize lat and lon arrays
[lat,lon]=findMermLatLon(webpage,hdcut);

% calculating elapsed time
[timeElapsed,origin]=timePassed(split,sz,col,n);

% creating array of time in format 'dd-mmm-yyyy HH:MM:SS'
timeArray = strings(1,n);
x = 1;
for i = 2:col:sz
    timeArray(x) = strcat(split(i),{' '},split(i+1));
    x = x + 1;
end

% create residual arrays 
resLon = zeros(1,n-numPts);
resLat = zeros(1,n-numPts);

x = 0;
i = 1;
while (i+numPts+x+predFac) < n
    % fitting polynomial functions 
    [pLon,SLon,muLon] = polyfit(timeElapsed(i:numPts+x),lon(i:numPts+x),degree);
    [pLat,SLat,muLat] = polyfit(timeElapsed(i:numPts+x),lat(i:numPts+x),degree);

    % convert time into date vector
    tim = datevec(timeArray(i+numPts+x+predFac));
    t = etime(tim,origin);
    
    % longitude predictions 
    [lonP,~] = polyval(pLon,t,SLon,muLon);

    % latitude predictions
    [latP,~] = polyval(pLat,t,SLat,muLat);
    
    % calculate residuals 
    resLon(i) = abs(lon(i+numPts+x+predFac)-lonP);
    resLat(i) = abs(lat(i+numPts+x+predFac)-latP);
    
    x = x + 1;
    i = i + 1;
end

meanResLon = mean(resLon)*110;
meanResLat = mean(resLat)*110;
disp(sprintf('Mean Longitude residual = %d km',meanResLon))
disp(sprintf('Mean Latitude residual = %d km',meanResLat))

%%%%%%%%%%%%%%%%%%%%%% uncomment to plot graphs %%%%%%%%%%%%%%%%%%%%%%%%%%%
% % plotting residuals 
% f = figure(1);
% clf
% histogram(resLon)
% title('Residuals of the Longitide (month prediction)')
% xlabel('Residual Value')
% ylabel('Abundance')
% 
% % savepdf(f,'res_lon_month')
% 
% f1 = figure(2);
% clf
% histogram(resLat)
% title('Residuals of the Latitude (month prediction)')
% xlabel('Residual Value')
% ylabel('Abundance')
% 
% % savepdf(f1,'res_lat_month')

% optional output
varns={meanResLon,meanResLat};
varargout=varns(1:nargout);
