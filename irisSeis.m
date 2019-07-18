function varargout=irisSeis(eq,epiDist)
% [tt,seisData]=irisSeis(eq,epiDist)
% 
% Input:
% eq          Returned from irisFetch.m; and object containing information
%             on all the events found in database
% epiDist     The epicentral distances (in km) between each event and the 
%             origin
% 
% Outputs:
% tt          A vector of times in sec (x-axis) corresponding to the 
%             seismic data
% seisData    An nxm matrix of all seismic data of each event 
% 
% Description:
% This function takes the time of each event and finds the corresponding
% file in the specified directory and retrieves the seismic data. Uses
% mcms2sac.m and mseed2sac. 
% 
% Last modified by dorisli on July 17, 2019 ver R2018a 

% pull the data from seismometers with the origin time of the earthquake
% find data file in computer 
for i=1:length(eq)
    t = datetime(datenum(eq(i).PreferredTime),'ConvertFrom','datenum');
    [Y,M,D,H] = datevec(t);
    [file]=mcms2mat(Y,M,D,H,00,00,0,0);
    load(file{1})
    seisD(:,i)=sx;
    names{i}=file{1};
end

% create time vectors 
tt=linspace(hx.B,hx.E,hx.NPTS);

% scale and add distances to seismic data 
seisData=zeros(size(seisD));
for i=1:length(eq)
    seisData(:,i)=((seisD(:,i)-...
        mean(seisD(:,i)))/sqrt(mean(abs(seisD(:,i))))) + epiDist(i);
end

% Optional outputs
varns={tt,seisData,names};
varargout=varns(1:nargout);