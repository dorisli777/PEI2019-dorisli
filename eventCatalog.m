function varargout=eventCatalog(minMag,maxMag,maxRad,startT,endT,originLat,originLon)
% [names,seisData,fig,TTP,TTS]=eventCatalog(minMag,maxMag,maxRad,startT,...
%                              endT,originLat,originLon)
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
% fig          Figure handle of the plot of seismic data vs time and
%              epicentral distance
% TTP          The predicted travel times of P waves through TAUP
% TTS          The predicted travel times of S waves through TAUP
% 
% Description:
% This function creates a catalog of events recorded by a certain 
% seismometer (origin) given specific parameters as defined in the input. 
% This function uses irisFetch.m, mcms2mat.m, and mseed2sac. 
% 
% Last modified by dorisli on July 19, 2019 ver R2018a

defval('minMag',7)
defval('maxMag',10)
defval('maxRad',180)
defval('startT','2018-01-01 00:00:00')
defval('endT','2019-04-30 07:00:00')
% origin defaulted to Princeton's seismometer 
defval('originLat', 40.3458117)
defval('originLon', -74.6569256)

% get events from IRIS
[eq]=getIris(minMag,maxMag,maxRad,originLat,originLon,startT,endT);

% calculate epicentral distances from events to specified origin 
[epiDist]=epicentralDist(eq,originLat,originLon);

% getting P and S wave travel times of each event 
[TTP,TTS]=waveSpeeds(eq,epiDist,minMag,maxRad);

% get data from selected seismometer 
[tt,seisData,names]=irisSeis(eq,epiDist);

% plot the data 
fig=figure(3);
clf 
plot(seisData,tt)
% hold on 
% plot(epiDist,TTP)
% plot(epiDist,TTS)
grid on
title(sprintf('Seismic Activity from %s to %s (Min Mag: %f and Max Rad: %d)',...
    startT,endT,minMag,maxRad))
xlabel('Epicentral Distance (in km)')
ylabel('Time (in sec)')

% saveas(fig,'~/Documents/MATLAB/EQCatalogFig/NEWEQCatalogMag3.png')

% create table of data 
tm=cellstr(reshape([eq.PreferredTime],23,[])');
T=table(tm,transpose([eq.PreferredLatitude]),transpose([eq.PreferredLongitude]),...
    transpose([eq.PreferredMagnitudeValue]),transpose(epiDist),...
    'VariableNames',{'Time','Lat','Lon','Mag','EpiDist'});
disp(T)

% Optional outputs
varns={names,seisData,fig,TTP,TTS};
varargout=varns(1:nargout);