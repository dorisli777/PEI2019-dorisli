function varargout=eventCatalog(minMag,maxMag,maxRad,startT,endT,originLat,...
    originLon,len,Fs,colo,cohi,depthMin,depthMax)
% [names,seisData,fig]=eventCatalog(minMag,maxMag,maxRad,startT,...
%              endT,originLat,originLon,len,Fs,colo,cohi,depthMin,depthMax)
% 
% INPUTS: 
% 
% minMag       The minimum magnitude of an event
% maxMag       The maximum magnitude of an event
% maxRad       Maximum radial distance around a specified origin
% startT       Start time to search for events
% endT         End time to search for events
% originLat    Latitude of seismogram being used to pull data from
% originLon    Longitude of seismogram being used to pull data from
% len          The length of data plotted since the event time (minutes)
% Fs           The sampling frequency (Hz)
% colo         The lower corner frequency (Hz)
% cohi         The higher corner frequency (Hz)
% depthMin     The minimum depth of earthquake (km)
% depthMax     The maximum depth of earthquake (km)
% 
% OUTPUTS:
% 
% names        Names of converted *.mat files 
% seisData     Seismic data of all the recorded events 
% fig          Figure handle of the plot of seismic data vs time and
%              epicentral distance
% 
% Description:
% This function creates a catalog of events recorded by a certain 
% seismometer (origin) given specific parameters as defined in the input. 
% This function uses irisFetch.m, mcms2mat.m, and mseed2sac. 
% 
% Last modified by dorisli on August 1, 2019 ver R2018a

defval('minMag',6)
defval('maxMag',10)
defval('maxRad',30)
defval('startT','2018-01-01 00:00:00')
defval('endT','2019-04-30 07:00:00')
% origin defaulted to Princeton's seismometer 
defval('originLat', 40.3458117)
defval('originLon', -74.6569256)
defval('len',60)
defval('Fs',100)
defval('colo',1)
defval('cohi',3)
defval('depthMin',0)
defval('depthMax',700)

% get events from IRIS
[eq]=getIris(minMag,maxMag,maxRad,originLat,originLon,startT,endT);

% calculate epicentral distances from events to specified origin 
[epiDist]=epicentralDist(eq,originLat,originLon,depthMin,depthMax);

% calculate azmiuths of each event to the station
[az]=rt_azimuth(eq,originLat,originLon,depthMin,depthMax);

% getting P and S wave travel times of each event 
[Pwave0,Swave0,Pwave700,Swave700,xx]=waveSpeeds(eq,epiDist,minMag,maxRad);
epiDists=deg2km(xx);

% get data from selected seismometer 
[tt,seisData,names]=irisSeis(eq,epiDist,len,Fs,colo,cohi,depthMin,depthMax,'Z');

% uncomment to rotate the north and east components
[seisrotT,seisrotR,seisX,seisY]=rotate_seis(seisData,az,eq,...
    epiDist,len,Fs,colo,cohi,depthMin,depthMax);

% plot radial and transverse components 
plotrot(seisData,seisrotT,seisrotR,tt,len)

% plot the data 
plotseis(seisData,Pwave0,Swave0,Pwave700,Swave700,tt,epiDists,...
    len,startT,endT,minMag,maxRad,colo,cohi,depthMin,depthMax)

% plot the 3 components (unrotated)
plotseiscomp(seisData,seisX,seisY,tt,len,startT,endT,minMag,maxRad,...
    colo,cohi,depthMin,depthMax)

% create table of data 
tm=cellstr(reshape([eq.PreferredTime],23,[])');
T=table(tm,transpose([eq.PreferredLatitude]),transpose([eq.PreferredLongitude]),...
    transpose([eq.PreferredMagnitudeValue]),transpose(epiDist),...
    'VariableNames',{'Time','Lat','Lon','Mag','EpiDist'});
disp(T)

% Optional outputs
varns={names,seisData};
varargout=varns(1:nargout);