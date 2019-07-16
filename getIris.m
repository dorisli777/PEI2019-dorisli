function varargout=getIris(minMag,maxMag,startT,endT)
% [eq]=getIris(minMag,maxMag,startT,endT)
% 
% Inputs:
% minMag
% maxMag
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
    'startTime',startT,'endTime',endT);

% plot events on world map 
figure(1)
clf
worldmap world;
load coastlines;
plotm(coastlat, coastlon);
hold on
plotm([eq.PreferredLatitude],[eq.PreferredLongitude],'r*');

% Optional outputs
varns={eq};
varargout=varns(1:nargout);

