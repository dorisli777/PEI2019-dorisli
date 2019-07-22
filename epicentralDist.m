function varargout=epicentralDist(eq,originLat,originLon)
% epiDist=epicentralDist(eq,originLat,originLon)
% 
% INPUTS:
% 
% eq           Returned from irisFetch.m; and object containing information
%              on all the events found in database
% originLat    Latitude of seismogram being used to pull data from
% originLon    Longitude of seismogram being used to pull data from
% 
% OUTPUT:
% 
% epiDist      The epicentral distances (in km) between each event and the 
%              origin
% 
% Description: 
% This function computes the epicentral distances in km between each event 
% and the specified origin (where the seismometer is). 
% 
% Last modified by dorisli on July 22, 2019 ver R2018a 

% epicentral distance in km
epiDist = deg2km(distance(originLat,originLon,...
    [eq.PreferredLatitude],[eq.PreferredLongitude]));

% Optional outputs
varns={epiDist};
varargout=varns(1:nargout);