function varargout=eventCatalog(minMag,maxMag,maxRad,startT,endT,originLat,originLon)
% [names,seisData]=eventCatalog(minMag,maxMag,maxRad,startT,endT,originLat,originLon)
% 
% Inputs: 
% minMag       The minimum magnitude of an event
% maxMag       The maximum magnitude of an event
% maxRad       Maximum radial distance around a specified origin
% startT       Start time to search for events
% endT         End time to search for events
% originLat    Latitude of seismogram being used to pull data from
% originLon    Longitude of seismogram being used to pull data from
% 
% Outputs:
% names        Names of converted *.mat files 
% seisData     Seismic data of all the recorded events 
% 
% Description:
% This function creates a catalog of events recorded by a certain 
% seismometer (origin) given specific parameters as defined in the input. 
% This function uses irisFetch.m, mcms2mat.m, and mseed2sac. 
% 
% Last modified by dorisli on July 17, 2019 ver R2018a

defval('minMag',3)
defval('maxMag',10)
defval('maxRad',20)
defval('startT','2019-02-00 00:00:00')
defval('endT','2019-03-00 00:00:00')

% origin defaulted to Princeton's seismometer 
defval('originLat', 40.3458117)
defval('originLon', -74.6569256)

% get events from IRIS
radcoord = [originLat,originLon,maxRad];
[eq]=getIris(minMag,maxMag,radcoord,startT,endT);

% calculate epicentral distances from events to specified origin 
[epiDist]=epicentralDist(eq,originLat,originLon);

% get data from selected seismometer 
[tt,seisData,names]=irisSeis(eq,epiDist);

% plot the data 
figure(2)
clf 
plot(seisData,tt)
grid on
title(sprintf('Seismic Activity from %s to %s',startT,endT))
xlabel('Epicentral Distance (in km)')
ylabel('Time (in sec)')

% create table of data 
tm=cellstr(reshape([eq.PreferredTime],23,[])');
T=table(tm,transpose([eq.PreferredLatitude]),transpose([eq.PreferredLongitude]),...
    transpose([eq.PreferredMagnitudeValue]),transpose(epiDist),...
    'VariableNames',{'Time','Lat','Lon','Mag','EpiDist'});
disp(T)

% Optional outputs
varns={names,seisData};
varargout=varns(1:nargout);