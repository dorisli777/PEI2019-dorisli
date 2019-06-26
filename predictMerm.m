function [lonPred,latPred]=predictMerm(webpage,mermaidNum,time,hdcut)
% [lonPred,latPred]=predictMerm(webpage,mermaidNum,time,hdcut)
% 
% Inputs:
% webpage         The website name with data
%                 (ex:'http://geoweb.princeton.edu/people/simons/SOM/P017_030.txt')
% mermaidNum      Number of mermaid (ex: 'P017')
% time            Time desired for prediction in 'dd-mmm-yyyy HH:MM:SS'
%                 (ex: '28-Jun-2019 11:30:00')
% hdcut           Number of lines to cut off the top of the file (def: 0)
% 
% example: 
% predictMerm('http://geoweb.princeton.edu/people/simons/SOM/P017_030.txt',...
% 'P017','28-Jun-2019 11:30:00',0);
% 
% Outputs: 
% latPred         Predicted latitude of the mermaid
% lonPred         Predicted longitude of the mermaid
% 
% Description:
% This function gives a prediction for a mermaid location (lon,lat) given
% a specified time, data file, and mermaid number using polyfit. 
% 
% Last modified by dorisli on June 26,2019 ver. R2018a

defval('webpage','http://geoweb.princeton.edu/people/simons/SOM/P017_030.txt')
defval('mermaidNum','P017')
defval('time','24-Jun-2019 08:44:20')
defval('hdcut',0) 

% ask for user input for pts used in regression and order of polynomial 
numPt = input('How many points for regression: ');
degree = input('Order of polynomial: ');

defval('numPt',20)
defval('degree',3)

numPts = numPt - 1;

% read in and parse the data
[split,sz,col,n]=parseMermData(webpage,hdcut);  

% check to make sure mermaid wanted is from correct file
if (strcmp(split(1),mermaidNum) == 0)
    throw(MException('MyComponent:noSuchVariable',...
        'Mermaid Num provided is not the same as file'))
end

% check to make sure # of regression pts is fewer than # of data pts
if (numPts > n)
     throw(MException('MyComponent:noSuchVariable',...
        'Value of pts for regression exceeds number of data points'))
end

% initialize lat and lon arrays
[lat,lon]=findMermLatLon(webpage,hdcut);

% calculating elapsed time
[timeElapsed,origin]=timePassed(split,sz,col,n);

% fitting polynomial functions 
[pLon,SLon,muLon] = polyfit(timeElapsed(end-numPts:end),lon(end-numPts:end),degree);
[pLat,SLat,muLat] = polyfit(timeElapsed(end-numPts:end),lat(end-numPts:end),degree);

% convert time into date vector
tim = datevec(time);
t = etime(tim,origin); 

%%%%%%%% longitude predictions and line fitting %%%%%%%%%
[lonP,delta] = polyval(pLon,t,SLon,muLon);
lonPred = strcat(num2str(lonP),{' +/- '},num2str(delta));
disp(sprintf('Predicted longitude = %s', char(lonPred)))
% disp('StDev = ')
% disp(muLon(2))

% finding lon correlation coefficent
y1 = polyval(pLon,timeElapsed(end-numPts:end),[],muLon);
rLon = 1 - (SLon.normr/norm(lon(end-numPts:end) - mean(lon(end-numPts:end))))^2;
disp(sprintf('R^2 value for lon = %d\n',rLon))

% finding longitide residuals
resLon = lon(end-numPts:end)-y1;

%%%%%%%% latitude predictions and line fitting %%%%%%%%%
[latP,delta] = polyval(pLat,t,SLat,muLat);
latPred = strcat(num2str(latP),{' +/- '},num2str(delta));
disp(sprintf('Predicted latitude = %s', char(latPred)))
% disp('StDev = ')
% disp(muLat(2))

% finding lat correlation coefficent
y2 = polyval(pLat,timeElapsed(end-numPts:end),[],muLat);
rLat = 1 - (SLat.normr/norm(lat(end-numPts:end) - mean(lat(end-numPts:end))))^2;
disp(sprintf('R^2 value for lat = %d ',rLat))

% finding latitude residuals 
resLat = lat(end-numPts:end)-y2;

%%%%%%%% plotting Longitude values and fitted line %%%%%%%%
figure(1)
clf

scatter(timeElapsed(end-numPts:end),lon(end-numPts:end),20,'filled');
hold on
plot(timeElapsed(end-numPts:end),y1);
title('Plot of Time and Longitude Values')
ylabel('Longitude (in degrees)')
xlabel('Time (in seconds)')
legend('Locations of Mermaids','Fitted line')
hold off 

% plotting Latitude values and fitted line
figure(2)
clf

scatter(timeElapsed(end-numPts:end),lat(end-numPts:end),20,'filled');
hold on
plot(timeElapsed(end-numPts:end), y2);
title('Plot of Time and Latitude Values')
ylabel('Latitude (in degrees)')
xlabel('Time (in seconds)')
legend('Locations of Mermaids','Fitted line')
hold off

% plotting residuals 
figure(3)
clf
histogram(resLon)
title('Residuals of the Longitide')
xlabel('Residual Value')
ylabel('Abundance')

figure(4)
clf
histogram(resLat)
title('Residuals of the Latitude')
xlabel('Residual Value')
ylabel('Abundance')



