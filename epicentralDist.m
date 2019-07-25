function varargout=epicentralDist(eq,originLat,originLon,depthMin,depthMax)
% epiDist=epicentralDist(eq,originLat,originLon,depthMin,depthMax)
% 
% INPUTS:
% 
% eq           Returned from irisFetch.m; and object containing information
%              on all the events found in database
% originLat    Latitude of seismogram being used to pull data from
% originLon    Longitude of seismogram being used to pull data from
% depthMin
% depthMax 
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
% Last modified by dorisli on July 24, 2019 ver R2018a 

% epicentral distance in km
x=1;
for i=1:length(eq)
    if (eq(i).PreferredDepth >= depthMin) && (eq(i).PreferredDepth <= depthMax)
        epiDist(x) = deg2km(distance(originLat,originLon,...
             eq(i).PreferredLatitude,eq(i).PreferredLongitude));
         x = x + 1;
    end
end
% Optional outputs
varns={epiDist};
varargout=varns(1:nargout);