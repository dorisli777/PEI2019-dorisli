function [lonPred,latPred]=predictMerm(webpage,mermaidNum,time,hdcut)
  % [lonPred,latPred]=predictMerm(webpage,mermaidNum,time,hdcut)
  % 
  % Inputs:
  % webpage         The website name with data
  %                 (ex:'http://geoweb.princeton.edu/people/simons/SOM/P017_030.txt')
  % mermaidNum      Number of mermaid (ex: 'P017')
  % time            Time desired for prediction in 'dd-mmm-yyyy HH:MM:SS'
  %                 (ex: '20-Jun-2019 11:30:00')
  % hdcut           Number of lines to cut off the top of the file (def: 0)
  % 
  % Outputs: 
  % latPred         Predicted latitude of the mermaid
  % lonPred         Predicted longitude of the mermaid
  % 
  % Description:
  % This function gives a prediction for a mermaid location (lon,lat) given
  % a specified time, data file, and mermaid number using polyfit. 
  % 
  % Last modified by dorisli on June 25,2019

defval('hdcut',0)

% read in and parse the data
[split,sz,col,n]=parseMermData(webpage);  

% check to make sure mermaid wanted is from correct file
if (strcmp(split(1),mermaidNum) == 0)
    throw(MException('MyComponent:noSuchVariable','Mermaid Num provided is not the same as file'))
end

% initialize lat and lon arrays
[lat,lon,~]=plotMerm(webpage);

% calculating elapsed time
[timeElapsed,origin]=timePassed(split,sz,col,n);

% en = length(lonArray);
% fitting polynomial functions 
[pLon,SLon] = polyfit(timeElapsed(hdcut+1:end),lon(hdcut+1:end),7);
[pLat,SLat] = polyfit(timeElapsed(hdcut+1:end),lat(hdcut+1:end),7);

% predictions
tim = datevec(time);
t = etime(tim,origin);

[lonP,delta] = polyval(pLon,t,SLon);
lonPred = strcat(num2str(lonP),{'+/-'},num2str(delta));
disp('Predicted longitude = ')
disp(lonPred)

[latP,delta] = polyval(pLat,t,SLat);
latPred = strcat(num2str(latP),{'+/-'},num2str(delta));
disp('Predicted latitude = ')
disp(latPred)

% plotting Longitude values and fitted line
figure(1)
clf

scatter(timeElapsed,lon,20,'filled');
hold on
y1 = polyval(pLon,timeElapsed);
plot(timeElapsed,y1);
title('Plot of Time and Longitude Values')
ylabel('Longitude (in degrees)')
xlabel('Time (in seconds)')
legend('Locations of Mermaids','Fitted line')
hold off 

% plotting Latitude values and fitted line
figure(2)
clf

scatter(timeElapsed,lat,20,'filled');
hold on
y2 = polyval(pLat,timeElapsed);
plot(timeElapsed, y2);
title('Plot of Time and Latitude Values')
ylabel('Latitude (in degrees)')
xlabel('Time (in seconds)')
legend('Locations of Mermaids','Fitted line')
hold off
