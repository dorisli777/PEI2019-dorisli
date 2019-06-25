function [velocity,surfaceVel,deepVel]=plotMermVel(webpage)
  % [velocity,surfaceVel,deepVel]=plotMermVel(webpage)
  % 
  % Input:
  % webpage     The website with data 
  %             (ex: 'http://geoweb.princeton.edu/people/simons/SOM/P017_030.txt')
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
  % Last modified by dorisli on June 25, 2019

% read in and parse the data   
[split,sz,col,n]=parseMermData(webpage);  

% latitude and longitude arrays
[lat,lon,~]=plotMerm(webpage);

% find velocities
[timeElapsed]=timeTwoPts(split,sz,col,n);
[velocity,velX,velY,dist,distX,distY]=findMermVel(timeElapsed,lat,lon,n);

% find surface velocities
[surfaceVel,surVelX,surVelY]=findMermSurVel(dist,distX,distY,timeElapsed,sz,col,n);

% find deep velocities 
[deepVel,deepVelX,deepVelY]=findMermDeepVel(dist,distX,distY,timeElapsed,sz,col,n);

% plotting the velocities  
figure(1)
clf 

quiver(lon,lat,velX,velY,'filled')
grid on
title('Plot of P017 Mermaids (Nov 27, 2018 - Jun 12, 2019)')
ylabel('Latitude (in degrees)')
xlabel('Longitude (in degrees)')
legend('Velocities (km/s)')

figure(2)
clf

scatter(lon,lat,10,'filled')
hold on
quiver(lon,lat,surVelX,surVelY,'filled')
quiver(lon,lat,deepVelX,deepVelY,'filled')
grid on
title('Plot of P017 Mermaids (Nov 27, 2018 - Jun 12, 2019)')
ylabel('Latitude (in degrees)')
xlabel('Longitude (in degrees)')
legend('Mermaid Locations','Surface Velocity (km/s)','Deep Velocity (km/s)')
hold off
