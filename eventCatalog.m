function varargout=eventCatalog(minMag,maxMag,maxRad,startT,endT,originLat,originLon)
% []=eventCatalog(minMag,maxMag,startT,endT,originLat,originLon)
% 
% Inputs: 
% 
% 
% Outputs:
% 
% 
% Description:
% 
% 
% Last modified by dorisli on July 16, 2019 ver R2018a

defval('minMag',3)
defval('maxMag',10)
defval('maxRad',20)
defval('startT','2019-03-00 00:00:00')
defval('endT','2019-03-10 00:00:00')

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

% create table of data 
tm=cellstr(reshape([eq.PreferredTime],23,[])');
rn=(1:length(epiDist));
T=table(tm,transpose([eq.PreferredLatitude]),transpose([eq.PreferredLongitude]),...
    transpose([eq.PreferredMagnitudeValue]),transpose(epiDist),...
    'VariableNames',{'Time','Lat','Lon','Mag','EpiDist'},'RowNames',rn);
disp(T)

% % plot seismograms from pton data
% figure(3)
% clf
% s_wplot(seisData,{'direction','l2r'},{'deflection',0.9},{'figure','old'}, ...
%     {'fontsize',13'});
% title(sprintf('Seismic Activity between %s and %s',startT,endT))
% ylabel('Time (in sec)')
% xlabel('')

% Optional outputs
varns={names,seisData};
varargout=varns(1:nargout);