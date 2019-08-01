function varargout=plotMermVel(webpage,hdcut)
% [velocity,surfaceVel,deepVel]=plotMermVel(webpage,hdcut)
% 
% Input:
% webpage     The website with data 
%             (ex: 'http://geoweb.princeton.edu/people/simons/SOM/P017_030.txt')
% hdcut       Number of lines to cut off the top of the file (def: 0)
% 
% Output: 
% velocity     Array of velocities at each location
% surfaceVel   Array of surface velocity values
% deepVel      Array of deep velocity values 
% 
% Description:
% This function plots the velocity, surface velocity, and deep velocities
% of the mermaid locations. 
%
% Last modified by dorisli on June 26, 2019 ver. R2018a

defval('webpage','http://geoweb.princeton.edu/people/simons/SOM/P017_030.txt')
defval('hdcut',0)

% read in and parse the data   
[split,sz,col,n]=parseMermData(webpage,hdcut);  

% latitude and longitude arrays
[lat,lon]=findMermLatLon(webpage,hdcut);

% find velocities
[timeElapsed]=timeTwoPts(split,sz,col,n);
[velocity,velX,velY,dist,distX,distY]=findMermVel(timeElapsed,lat,lon,n);

% find surface velocities
[surfaceVel,surVelX,surVelY]=findMermSurVel(dist,distX,distY,...
    timeElapsed,split,sz,col,n);

% find deep velocities 
[deepVel,deepVelX,deepVelY]=findMermDeepVel(dist,distX,distY,...
    timeElapsed,split,sz,col,n);

% plotting the velocities  
f = figure(1);
clf 

quiver(lon,lat,velX,velY,'filled')
grid on
title(sprintf('Plot of %s Mermaids (%s to %s)', char(split(1)),...
    char(split(2)), char(split(2 + sz - col))))
ylabel('Latitude (in degrees)')
xlabel('Longitude (in degrees)')
legend('Velocities (km/s)')

% savepdf(f,'Velocity_Merm')

% plotting surface and deep velocities 
f1 = figure(2);
clf

scatter(lon,lat,10,'filled')
hold on
quiver(lon,lat,surVelX,surVelY,'filled')
quiver(lon,lat,deepVelX,deepVelY,'filled')
grid on
title(sprintf('Plot of %s Mermaids (%s to %s)', char(split(1)),...
    char(split(2)), char(split(2 + sz - col))))
ylabel('Latitude (in degrees)')
xlabel('Longitude (in degrees)')
legend('Mermaid Locations','Surface Velocity (km/s)','Deep Velocity (km/s)')
hold off

% savepdf(f1,'sur_and_deep_Velocity_Merm')

% optional output
varns={velocity,surfaceVel,deepVel};
varargout=varns(1:nargout);
