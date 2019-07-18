function varargout=getIris(minMag,maxMag,radcoord,startT,endT)
% eq=getIris(minMag,maxMag,startT,endT)
% 
% Inputs:
% minMag       The minimum magnitude of an event
% maxMag       The maximum magnitude of an event
% radcoord     Maximum radial distance around a specified origin
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
% Last modified by dorisli on July 18, 2019 ver R2018a 

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
plotm(40.3458117,-74.6569256,'g*');
title(sprintf('Locations of Events from %s to %s (Min Mag: %f and Max Rad: %d)',...
    startT,endT,minMag,radcoord(3)))
hold off

% saveas(fig,'~/Documents/MATLAB/EQCatalogFig/WorldMapEQMag3.png')

% Optional outputs
varns={eq,fig};
varargout=varns(1:nargout);

