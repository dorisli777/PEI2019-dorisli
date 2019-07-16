function varargout=eventCatalog(minMag,maxMag,startT,endT,originLat,originLon)
% []=eventCatalog(minMag,maxMag,startT,endT,originLat,originLon)
% 
% Inuputs: 
% 
% 
% Outputs:
% 
% 
% Description:
% 
% 
% Last modified by dorisli on July 16, 2019 ver R2018a

defval('minMag',5)
defval('maxMag',10)
defval('startT','2019-01-13 00:00:00')
defval('endT','2019-04-30 00:00:00')

% origin defaulted to Princeton's seismometer 
defval('originLat', 40.3458117)
defval('originLon', -74.6569256)

% get events from IRIS
[eq]=getIris(minMag,maxMag,startT,endT);

% calculate epicentral distances from events to specified origin 
[epiDist]=epicentralDist(eq,originLat,originLon);

% get p, s, and surface wave speeds from tauP
[TTP,TTS]=waveSpeeds(eq,epiDist);
disp(TTP)

% get data from selected seismometer 
[tims,seisData]=irisSeis(eq);
% mseed2sac 

% plot seismograms from pton data 


% plot wave speeds on top 


% Optional outputs
varns={};
varargout=varns(1:nargout);