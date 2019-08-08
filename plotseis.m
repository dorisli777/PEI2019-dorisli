function varargout=plotseis(seisData,Pwave0,Swave0,Pwave700,Swave700,tt,epiDists,...
    len,startT,endT,minMag,maxRad,colo,cohi,depthMin,depthMax,dep)
% fig=plotseis(seisData,Pwave0,Swave0,Pwave700,Swave700,tt,...
%             len,startT,endT,minMag,maxRad,colo,cohi,depthMin,depthMax,dep)
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
% dep         An array of depths corresponding to the events in eq
% 
% OUTPUT:
% 
% fig         The figure handle of the plot of seismic data with P and S
%             wave arrivals
% 
% Description:
% This function plots all the seismic data correlating to the given
% parameters in eventCatalog.m against epicentral distances. It also plots
% the predicted P and S wave arrivals between depths of 0 and 700 km. The
% plot is color coordinated with earthquake depths. 
% 
% Last modified by dorisli on August 8, 2019 ver. R2018a 

fig=figure(3);
clf 

for i=1:size(seisData,2)
    % create colorbar correlating to depth of earthquake 
    cmap=colormap(gca,parula(ceil(max(dep))-floor(min(dep))));
    c=colorbar();
    caxis([min(dep) max(dep)]);
    set(get(c,'Title'),'String','Depths (km)')
    index=floor(dep(i)-min(dep));
    if index == 0
        index=1;
    end
    hold on
    % plot seismic data with color bar corresponding to depths
    plot(seisData(:,i),tt,'Color',cmap(index,:))
end
% plot P and S wave values 
plot(epiDists,Pwave0,'b')
plot(epiDists,Swave0,'r--')
plot(epiDists,Pwave700,'b')
plot(epiDists,Swave700,'r--')
grid on
title({sprintf('Seismic Activity HHZ from %s to %s UTC',startT,endT) ; ...
    sprintf('(Max Mag: %.2f, Max Rad: %.0f deg, Filter: %.2f to %.2f, Depth: %.0f to %.0f km)',...
    minMag,maxRad,colo,cohi,depthMin,depthMax)})
xlabel('Epicentral Distance (km)')
ylabel('Time since start of Event (sec)')
ylim([0,len*60])
m=max(max(seisData))+150;
xlim([0,m])

% saveas(fig,'~/Documents/MATLAB/PEI2019-dorisli/catalog_figures/seisDataMag7.png')

% Optional outputs
varns={fig};
varargout=varns(1:nargout);