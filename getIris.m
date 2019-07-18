function varargout=getIris(minMag,maxMag,radcoord,startT,endT)
% [eq]=getIris(minMag,maxMag,startT,endT)
% 
% Inputs:
% minMag
% maxMag
% radcoord 
% startT 
% endT 
% 
% Outputs:
% eq 
% 
% Description:
% 
% 
% Last modified by dorisli on July 16, 2019 ver R2018a 

eq = irisFetch.Events('MinimumMagnitude',minMag,'MaximumMagnitude',maxMag,...
    'radialcoordinates',radcoord,'startTime',startT,'endTime',endT);

% plot events on world map 
figure(1)
clf
worldmap world;
load coastlines;
plotm(coastlat, coastlon);
hold on
plotm([eq.PreferredLatitude],[eq.PreferredLongitude],'r*');
plotm(40.3458117,-74.6569256,'g*');
title(sprintf('Locations of all Events from %s to %s',startT,endT))
hold off

% Optional outputs
varns={eq};
varargout=varns(1:nargout);

