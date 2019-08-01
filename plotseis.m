function varargout=plotseis(seisData,Pwave0,Swave0,Pwave700,Swave700,tt,epiDists,...
    len,startT,endT,minMag,maxRad,colo,cohi,depthMin,depthMax)
% fig=plotseis(seisData,Pwave0,Swave0,Pwave700,Swave700,tt,...
%             len,startT,endT,minMag,maxRad,colo,cohi,depthMin,depthMax)
% 
% INPUTS:
% 
% seisData    An nxm matrix of seismic data of the event, beginning with
%             data from the time of the event to the specified length of
%             time
% Pwave0      An array of predicted P wave arrivals at depth 0 km
% Swave0      An array of predicted S wave arrivals at depth 0 km
% Pwave700    An array of predicted P wave arrivals at depth 700 km
% Swave700    An array of predicted S wave arrivals at depth 700 km
% tt          A vector of times in sec (x-axis) corresponding to the 
%             seismic data
% epiDists    An array of epicentral distances (km) 
% len         The length of data plotted since the event time (minutes)
% startT      Start time to search for events
% endT        End time to search for events
% minMag      The minimum magnitude of an event
% maxRad      Maximum radial distance around a specified origin
% colo        The lower corner frequency (Hz)
% cohi        The higher corner frequency (Hz)
% depthMin    The minimum depth of earthquake (km)
% depthMax    The maximum depth of earthquake (km)
% 
% OUTPUT:
% 
% fig         The figure handle of the plot of seismic data with P and S
%             wave arrivals
% 
% Description:
% This function plots all the seismic data correlating to the given
% parameters in eventCatalog.m against epicentral distances. It also plots
% the predicted P and S wave arrivals between depths of 0 and 700 km. 
% 
% Last modified by dorisli on August 1, 2019 ver. R2018a 

fig=figure(3);
clf 

plot(seisData,tt)
hold on 
plot(epiDists,Pwave0)
plot(epiDists,Swave0)
plot(epiDists,Pwave700)
plot(epiDists,Swave700)
grid on
title({sprintf('Seismic Activity HHZ from %s to %s',startT,endT) ; ...
    sprintf('(Min Mag: %.2f, Max Rad: %.0f, Filter: %.2f to %.2f, Depth: %.0f to %.0f km)',...
    minMag,maxRad,colo,cohi,depthMin,depthMax)})
xlabel('Epicentral Distance (km)')
ylabel('Time (sec)')
ylim([0,len*60])
m=max(max(seisData))+150;
xlim([0,m])
hold off

% saveas(fig,'~/Documents/MATLAB/EQCatalogFig/MAG7/wavedir/Y.png')

% Optional outputs
varns={fig};
varargout=varns(1:nargout);