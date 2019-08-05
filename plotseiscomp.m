function varargout=plotseiscomp(seisData,seisX,seisY,tt,...
    len,startT,endT,minMag,maxRad,colo,cohi,depthMin,depthMax)
% fig=plotseiscomp(seisData,Pwave0,Swave0,Pwave700,Swave700,tt,...
%             len,startT,endT,minMag,maxRad,colo,cohi,depthMin,depthMax)
% 
% INPUTS:
% 
% seisData    An nxm matrix of seismic data of the event, beginning with
%             data from the time of the event to the specified length of
%             time
% seisX       An nxm array of unrotated X component data 
% seisY       An nxm array of unrotated Y component data 
% tt          A vector of times in sec (x-axis) corresponding to the 
%             seismic data
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
% fig         The figure handle of the plot of the three unrotated
%             seismograms
% 
% Description:
% This function plots the three unrotated components of seismic data
% (X, Y, and Z components) given the parameters in eventCatalog.m 
% 
% Last modified by dorisli on August 5, 2019 ver. R2018a 

fig=figure(4);
clf 

% plot Z component 
subplot(3,1,1)
plot(seisData,tt)
grid on
title({sprintf('Seismic Activity HHZ from %s to %s',startT,endT) ; ...
    sprintf('(Min Mag: %.2f, Max Rad: %.0f, Filter: %.2f to %.2f, Depth: %.0f to %.0f km)',...
    minMag,maxRad,colo,cohi,depthMin,depthMax)})
xlabel('Epicentral Distance (km)')
ylabel('Time since start of Event (sec)')
ylim([0,len*60]) 
m=max(max(seisData))+150;
xlim([0,m])

% plot X component 
subplot(3,1,2)
plot(seisX,tt)
grid on
title({sprintf('Seismic Activity HHX from %s to %s',startT,endT) ; ...
    sprintf('(Min Mag: %.2f, Max Rad: %.0f, Filter: %.2f to %.2f, Depth: %.0f to %.0f km)',...
    minMag,maxRad,colo,cohi,depthMin,depthMax)})
xlabel('Epicentral Distance (km)')
ylabel('Time since start of Event (sec)')
ylim([0,len*60])
m=max(max(seisX))+150;
xlim([0,m])

% plot Y component 
subplot(3,1,3)
plot(seisY,tt)
grid on
title({sprintf('Seismic Activity HHY from %s to %s',startT,endT) ; ...
    sprintf('(Min Mag: %.2f, Max Rad: %.0f, Filter: %.2f to %.2f, Depth: %.0f to %.0f km)',...
    minMag,maxRad,colo,cohi,depthMin,depthMax)})
xlabel('Epicentral Distance (km)')
ylabel('Time since start of Event (sec)')
ylim([0,len*60])
m=max(max(seisY))+150;
xlim([0,m])

% saveas(fig,'~/Documents/MATLAB/EQCatalogFig/MAG7/wavedir/Y.png')

% Optional outputs
varns={fig};
varargout=varns(1:nargout);