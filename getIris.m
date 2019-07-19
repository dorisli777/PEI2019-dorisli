function varargout=getIris(minMag,maxMag,maxRad,originLat,originLon,startT,endT)
% [eq,fig]=getIris(minMag,maxMag,maxRad,originLat,originLon,startT,endT)
% 
% Inputs:
% minMag       The minimum magnitude of an event
% maxMag       The maximum magnitude of an event
% maxRad       Maximum radial distance around a specified origin
% originLat    Latitude of seismometer station
% originLon    Longitude of seismometer station 
% startT       Start time to search for events
% endT         End time to search for events
% 
% Outputs:
% eq           Returned from irisFetch.m; and object containing information
%              on all the events found in database 
% fig          Figure handle of the map of world with detected seismic events
% 
% Description:
% This function uses irisFetch to find events given the parameters in the
% input. 
% 
% Last modified by dorisli on July 19, 2019 ver R2018a 

radcoord = [originLat,originLon,maxRad];
eq = irisFetch.Events('MinimumMagnitude',minMag,'MaximumMagnitude',maxMag,...
    'radialcoordinates',radcoord,'startTime',startT,'endTime',endT);

% plot events on world map 
fig=figure(1);
clf
worldmap world;
load coastlines;
plotm(coastlat, coastlon);
hold on
plotm([eq.PreferredLatitude],[eq.PreferredLongitude],'r*');
plotm(originLat,originLon,'g*');
title(sprintf('Locations of Events from %s to %s (Min Mag: %f and Max Rad: %d)',...
    startT,endT,minMag,radcoord(3)))
hold off

% saveas(fig,'~/Documents/MATLAB/EQCatalogFig/WorldMapEQMag3.png')

% Optional outputs
varns={eq,fig};
varargout=varns(1:nargout);