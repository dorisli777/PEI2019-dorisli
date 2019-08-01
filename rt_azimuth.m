function varargout=rt_azimuth(eq,originLat,originLon,depthMin,depthMax)
% [az]=rt_azimuth(eq,originLat,originLon,depthMin,depthMax)
% 
% INPUTS:
% 
% eq           Returned from irisFetch.m; and object containing information
%              on all the events found in database
% originLat    Latitude of seismogram being used to pull data from
% originLon    Longitude of seismogram being used to pull data from
% depthMin     The minimum depth of earthquake (km)
% depthMax     The maximum depth of earthquake (km)
% 
% OUPUT:
% 
% az           An array of azimuth values corresponding to the events in eq 
% 
% Description:
% This function calculates azmiuth values between the station and event
% epicenters based off information given in eq. Uses matlab function
% "azimuth".
% 
% Last modified by dorisli on August 1, 2019 ver. R2018a 

x=1;
for i=1:length(eq)
    if (eq(i).PreferredDepth >= depthMin) && (eq(i).PreferredDepth <= depthMax)
        az(x) = azimuth(originLat,originLon,eq(i).PreferredLatitude,eq(i).PreferredLongitude);
        x = x + 1;
    end
end

% Optional Output 
varns={az};
varargout=varns(1:nargout);