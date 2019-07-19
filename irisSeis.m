function varargout=irisSeis(eq,epiDist)
% [tt,seisData,names]=irisSeis(eq,epiDist)
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
% names       An array of file names of all seismic data used/converted
% 
% Description:
% This function takes the time of each event and finds the corresponding
% file in the specified directory and retrieves the seismic data. This 
% function scales and filters the seismic data as well. Uses mcms2sac.m 
% and mseed2sac. 
% 
% Last modified by dorisli on July 19, 2019 ver R2018a 

% pull the data from seismometers with the origin time of the earthquake
for i=1:length(eq)
    t = datetime(datenum(eq(i).PreferredTime),'ConvertFrom','datenum');
    [Y,M,D,H,MN] = datevec(t);
    % if the data is too close to end of hour, go to next file
    if MN >= 56
        if H ~= 23
            H = H + 1;
        end
    end
    [file]=mcms2mat(Y,M,D,H,00,0,0);
    load(file{1})
    % filter the data 
    [x]=bandpass(sx,110,1,2);
    seisD(:,i)=x;
    names{i}=file{1};
end

% create time vectors 
tt=linspace(hx.B,hx.E,hx.NPTS);

%%%%%%%%%%%%%%%%%%%%%%%%% ALTERNATE METHOD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for i=1:length(eq)
%     st = datestr(datenum(eq(1).PreferredTime)-1/24,31);
%     en = datestr(datenum(eq(i).PreferredTime)+2/24,31);
%     
%     trace = irisFetch.Traces('LD','PANJ','*','BHZ',st,en,'includePZ');
%     seisD(:,i)=trace.data;
% end
% 
% e=(datenum(trace.endTime)-datenum(trace.startTime))*3600*24;
% tt=linspace(0, e, trace.sampleCount);
% names=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% scale and add distances to seismic data 
seisData=zeros(size(seisD));
for i=1:length(eq)
    seisData(:,i)=((seisD(:,i)-...
        mean(seisD(:,i)))/sqrt(mean(abs(seisD(:,i))))) + epiDist(i);
end

% Optional outputs
varns={tt,seisData,names};
varargout=varns(1:nargout);