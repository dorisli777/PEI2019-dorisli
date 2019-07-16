function varargout=epicentralDist(eq,originLat,originLon)
% [epiDist]=epicentralDist(eq,originLat,originLon)
% 
% Input: 
% eq 
% originLat
% originLon 
% 
% Output:
% epiDist
% 
% Description: 
% 
% 
% Last modified by dorisli on July 16, 2019 ver R2018a 

% epicentral distance in deg
epiDist = distance(originLat,originLon,...
    [eq.PreferredLatitude],[eq.PreferredLongitude]);

% Optional outputs
varns={epiDist};
varargout=varns(1:nargout);