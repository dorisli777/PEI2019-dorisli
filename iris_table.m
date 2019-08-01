function varargout=iris_table(eq,epiDist)
% fig=iris_table(eq,epiDist)
% 
% INPUTS:
% 
% eq          Returned from irisFetch.m; and object containing information
%             on all the events found in database
% epiDist     The epicentral distances (in km) between each event and the 
%             origin
% 
% OUTPUT:
% 
% T           A table of information of each event given by irisFetch.
%             Returns time, lat, lon, mag, and epicentral distance. 
% 
% Description:
% This function makes a table of information of each event given by eq
% (from irisFetch). It gives the time of event, the latitude and longitude,
% the magnitude, and epicentral distance from the selected station. 
% 
% Last modified by dorisli on August 1, 2019 ver. R2018a 

tm=cellstr(reshape([eq.PreferredTime],23,[])');
T=table(tm,transpose([eq.PreferredLatitude]),transpose([eq.PreferredLongitude]),...
    transpose([eq.PreferredMagnitudeValue]),transpose(epiDist),...
    'VariableNames',{'Time','Lat','Lon','Mag','EpiDist'});
disp(T)

% Optional outputs
varns={T};
varargout=varns(1:nargout);