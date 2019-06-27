function [velPred,rVel,velXPred,rVelX,velYPred,rVelY]=predictMermVel(webpage,mermaidNum,time,hdcut,numPt,degree)
% [velPred,rVel]=predictMermVel(webpage,mermaidNum,time,hdcut)
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
% velpred         The velocity prediction at a given time with error
% rVel            the R^2 value of the velocity prediction 
% 
% Description:
% This function returns the predicted velocity for a mermaid location at a
% specified time using polyfit. Is called during predictMerm. 
% 
% Last modified by dorisli on June 27, 2019 ver. R2018a

defval('webpage','http://geoweb.princeton.edu/people/simons/SOM/P017_030.txt')
defval('mermaidNum','P017')
defval('time','24-Jun-2019 08:44:20')
defval('hdcut',0) 

% % ask for user input for pts used in regression and order of polynomial 
% numPt = input('How many points for regression: ');
% degree = input('Order of polynomial: ');

defval('numPt',20)
defval('degree',3)

numPts = numPt - 1;

% parse data file
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

% find lat and lon 
[lat,lon]=findMermLatLon(webpage,hdcut);

% find velocities
[timeElapsed]=timeTwoPts(split,sz,col,n);
[velocity,velX,velY,~,~,~]=findMermVel(timeElapsed,lat,lon,n);

% fit the data 
[timeElapsed1,origin]=timePassed(split,sz,col,n);

[pVel,SVel,muVel] = polyfit(timeElapsed1(end-numPts:end),...
    velocity(end-numPts:end),degree);
[pVelX,SVelX,muVelX] = polyfit(timeElapsed1(end-numPts:end),...
    velX(end-numPts:end),degree);
[pVelY,SVelY,muVelY] = polyfit(timeElapsed1(end-numPts:end),...
    velY(end-numPts:end),degree);

% convert time into date vector
tim = datevec(time);
t = etime(tim,origin); 

% predict the velocity based off the given time 
[velP,deltaVel] = polyval(pVel,t,SVel,muVel);
velPred = strcat(num2str(velP),{' +/- '},num2str(deltaVel));

[velXP,deltaVelX] = polyval(pVelX,t,SVelX,muVelX);
velXPred = strcat(num2str(velXP),{' +/- '},num2str(deltaVelX));

[velYP,deltaVelY] = polyval(pVelY,t,SVelY,muVelY);
velYPred = strcat(num2str(velYP),{' +/- '},num2str(deltaVelY));

% calculating R^2 value
rVel = 1 - (SVel.normr/norm(velocity(end-numPts:end) -...
    mean(velocity(end-numPts:end))))^2;
rVelX = 1 - (SVelX.normr/norm(velX(end-numPts:end) -...
    mean(velX(end-numPts:end))))^2;
rVelY = 1 - (SVelY.normr/norm(velY(end-numPts:end) -...
    mean(velY(end-numPts:end))))^2;

