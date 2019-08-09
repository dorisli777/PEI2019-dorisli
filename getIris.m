function varargout=getIris(minMag,maxMag,maxRad,originLat,originLon,startT,endT)
% [eq,fig]=getIris(minMag,maxMag,maxRad,originLat,originLon,startT,endT)
% 
% INPUTS:
% 
% minMag       The minimum magnitude of an event
% maxMag       The maximum magnitude of an event
% maxRad       Maximum radial distance around a specified origin
% originLat    Latitude of seismometer station
% originLon    Longitude of seismometer station 
% startT       Start time to search for events
% endT         End time to search for events
% 
% OUTPUTS:
% 
% eq           Returned from irisFetch.m; and object containing information
%              on all the events found in database 
% fig          Figure handle of the map of world with detected seismic events
% 
% Description:
% This function uses irisFetch to find events given the parameters in the
% input. 
% 
% Last modified by dorisli on August 8, 2019 ver R2018a 

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
title({sprintf('Events from %s to %s UTC',startT,endT) ; sprintf('(Min Mag: %.1f and Max Rad: %.0f deg)',...
    minMag,radcoord(3))})
hold off

saveas(fig,'~/Documents/MATLAB/PEI2019-dorisli/catalog_figures/WorldMapEQMag7.png')

% Optional outputs
varns={eq,fig};
varargout=varns(1:nargout);