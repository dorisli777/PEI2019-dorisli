function varargout=scaleSeis(data,epiDist)
% scaledData=plotseis(data,epiDist)
% 
% INPUTS:
% 
% data        The data set (a vector) wished to be scaled 
% epiDist     The distance added to each point 
% 
% OUTPUT:
% 
% scaledData  The resulting scaled data (a vector)
% 
% Description:
% This function scales and adds epicentral distances to given data. Built
% to be used with eventCatalog.m and for seismic data. 
% 
% Last modified by dorisli on August 1, 2019 ver. R2018a 

scaledData = ((data-mean(data))/sqrt(mean(abs(data)))) + epiDist;

% Optional outputs
varns={scaledData};
varargout=varns(1:nargout);