function varargout=eventCatalog(minMag,maxMag,maxRad,startT,endT,originLat,...
    originLon,len,Fs,colo,cohi,depthMin,depthMax,comp)
% [names,seisData,fig,TTPs,TTSs]=eventCatalog(minMag,maxMag,maxRad,startT,...
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
% depth Max    The maximum depth of earthquake (km)
% comp         The desired component of seismic data ('X','Y','Z')
% 
% OUTPUTS:
% 
% names        Names of converted *.mat files 
% seisData     Seismic data of all the recorded events 
% fig          Figure handle of the plot of seismic data vs time and
%              epicentral distance
% TTPs         The sorted predicted travel times of P waves through TAUP
% TTSs         The sorted predicted travel times of S waves through TAUP
% 
% Description:
% This function creates a catalog of events recorded by a certain 
% seismometer (origin) given specific parameters as defined in the input. 
% This function uses irisFetch.m, mcms2mat.m, and mseed2sac. 
% 
% Last modified by dorisli on July 26, 2019 ver R2018a

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
defval('colo',0.05)
defval('cohi',3)
defval('depthMin',0)
defval('depthMax',700)
defval('comp','Z')

% get events from IRIS
[eq]=getIris(minMag,maxMag,maxRad,originLat,originLon,startT,endT);

% calculate epicentral distances from events to specified origin 
[epiDist]=epicentralDist(eq,originLat,originLon,depthMin,depthMax);

% getting P and S wave travel times of each event 
[Pwave0,Swave0,Pwave700,Swave700,xx]=waveSpeeds(eq,epiDist,minMag,maxRad);
epiDists=deg2km(xx);

% get data from selected seismometer 
[tt,seisData,names]=irisSeis(eq,epiDist,len,Fs,colo,cohi,depthMin,depthMax,comp);

% rotate the north and east components
comp2='X';
[~,seisDX]=irisSeis(eq,epiDist,len,Fs,colo,cohi,depthMin,depthMax,comp2);
comp3='Y';
[~,seisDY]=irisSeis(eq,epiDist,len,Fs,colo,cohi,depthMin,depthMax,comp3);

seisDataX = zeros(size(seisDX));
seisDataY = zeros(size(seisDY));
for i = 1:size(seisData,2)
    vx=seisDX(:,i);
    vy=seisDY(:,i);
    [vxr,vyr]=rotate_seis(vx,vy);
    seisDataX(:,i)=vxr;
    seisDataY(:,i)=vyr;
end

fig=figure(2);
clf
subplot(3,1,1)
plot(seisDataX,tt)
ylim([0,len*60])
% m=max(max(seisData))+150;
% xlim([0,m])

subplot(3,1,2)
plot(seisDataY,tt)
ylim([0,len*60])
% m=max(max(seisData))+150;
% xlim([0,m])

subplot(3,1,3)
plot(seisData,tt)
ylim([0,len*60])
m=max(max(seisData))+150;
xlim([0,m])

% % plot the data 
% fig=figure(3);
% clf 
% plot(seisData,tt)
% hold on 
% plot(epiDists,Pwave0)
% plot(epiDists,Swave0)
% plot(epiDists,Pwave700)
% plot(epiDists,Swave700)
% grid on
% title({sprintf('Seismic Activity HH%s from %s to %s',comp,startT,endT) ; ...
%     sprintf('(Min Mag: %.2f, Max Rad: %.0f, Filter: %.2f to %.2f, Depth: %.0f to %.0f km)',...
%     minMag,maxRad,colo,cohi,depthMin,depthMax)})
% xlabel('Epicentral Distance (km)')
% ylabel('Time (sec)')
% ylim([0,len*60])
% m=max(max(seisData))+150;
% xlim([0,m])
% hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fig=figure(3);
% clf 
% subplot(3,1,1)
% plot(seisData,tt)
% grid on
% title({sprintf('Seismic Activity HH%s from %s to %s',comp,startT,endT) ; ...
%     sprintf('(Min Mag: %.2f, Max Rad: %.0f, Filter: %.2f to %.2f, Depth: %.0f to %.0f km)',...
%     minMag,maxRad,colo,cohi,depthMin,depthMax)})
% xlabel('Epicentral Distance (km)')
% ylabel('Time (sec)')
% ylim([0,len*60])plot the data 
% m=max(max(seisData))+150;
% xlim([0,m])
% 
% subplot(3,1,2)
% plot(r,tt)
% grid on
% title({sprintf('Seismic Activity HH%s from %s to %s',comp2,startT,endT) ; ...
%     sprintf('(Min Mag: %.2f, Max Rad: %.0f, Filter: %.2f to %.2f, Depth: %.0f to %.0f km)',...
%     minMag,maxRad,colo,cohi,depthMin,depthMax)})
% xlabel('Epicentral Distance (km)')
% ylabel('Time (sec)')
% ylim([0,len*60])
% m=max(max(seisDataX))+150;
% xlim([0,m])
% 
% subplot(3,1,3)
% plot(t,tt)
% grid on
% title({sprintf('Seismic Activity HH%s from %s to %s',comp3,startT,endT) ; ...
%     sprintf('(Min Mag: %.2f, Max Rad: %.0f, Filter: %.2f to %.2f, Depth: %.0f to %.0f km)',...
%     minMag,maxRad,colo,cohi,depthMin,depthMax)})
% xlabel('Epicentral Distance (km)')
% ylabel('Time (sec)')
% ylim([0,len*60])
% m=max(max(seisDataY))+150;
% xlim([0,m])

% saveas(fig,'~/Documents/MATLAB/EQCatalogFig/MAG7/wavedir/Y.png')

% create table of data 
tm=cellstr(reshape([eq.PreferredTime],23,[])');
T=table(tm,transpose([eq.PreferredLatitude]),transpose([eq.PreferredLongitude]),...
    transpose([eq.PreferredMagnitudeValue]),transpose(epiDist),...
    'VariableNames',{'Time','Lat','Lon','Mag','EpiDist'});
disp(T)

% Optional outputs
varns={names,seisData,fig,Pwave0,Swave0};
varargout=varns(1:nargout);