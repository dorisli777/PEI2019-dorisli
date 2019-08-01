function varargout=rt_azimuth(eq,originLat,originLon,depthMin,depthMax)
% [az]=rt_azimuth(eq,originLat,originLon,depthMin,depthMax)
% 
% INPUTS:
% 
% eq 
% 
% OUPUT:
% 
% az 
% 
% Description:
% 
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