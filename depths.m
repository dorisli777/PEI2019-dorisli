function varargout=depths(eq,epiDist,depthMin,depthMax)
% [dep]=depths(eq,epiDist,depthMin,depthMax)
% 
% INPUTS:
% 
% eq           Returned from irisFetch.m; and object containing information
%              on all the events found in database
% epiDist      The epicentral distances (in km) between each event and the 
%              origin
% depthMin     The minimum depth of earthquake (km)
% depthMax     The maximum depth of earthquake (km)
% 
% OUPUT:
% 
% dep          An array of depths corresponding to the events in eq 
% 
% Description:
% This function returns an array of depths corresponding to the events
% found in irisFetch and the given parameters in eventCatalog.m
% 
% Last modified by dorisli on August 5, 2019 ver. R2018a 

dep=size(epiDist);

x=1;
for i=1:length(eq)
    if (eq(i).PreferredDepth >= depthMin) && (eq(i).PreferredDepth <= depthMax)
        dep(x)=eq(i).PreferredDepth;
        x=x+1;
    end
end

% Optional Output 
varns={dep};
varargout=varns(1:nargout);