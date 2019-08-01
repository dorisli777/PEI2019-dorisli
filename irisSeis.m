function varargout=irisSeis(eq,epiDist,len,Fs,colo,cohi,depthMin,depthMax,comp)
% [tt,seisData,names]=irisSeis(eq,epiDist,len,Fs,colo,cohi,depthMin,depthMax,comp)
% 
% INPUTS:
% 
% eq          Returned from irisFetch.m; and object containing information
%             on all the events found in database
% epiDist     The epicentral distances (in km) between each event and the 
%             origin
% len         The length of data plotted since the event time (minutes)
% Fs          The sampling frequency (Hz)
% colo        The lower corner frequency (Hz)
% cohi        The higher corner frequency (Hz)
% depthMin    The minimum depth of earthquake (km)
% depth Max   The maximum depth of earthquake (km)
% comp        The desired component of seismic data ('X','Y','Z')
% 
% OUTPUTS:
% 
% tt          A vector of times in sec (x-axis) corresponding to the 
%             seismic data
% seisData    An nxm matrix of seismic data of the event, beginning with
%             data from the time of the event to the specified length of
%             time
% names       An array of file names of all seismic data used/converted
% 
% Description:
% This function takes the time of each event and finds the corresponding
% file in the specified directory and retrieves the seismic data. This 
% function scales and filters the seismic data as well. 
% Uses mcms2sac.m and mseed2sac 
% 
% Last modified by dorisli on August 1, 2019 ver R2018a 

rawData = zeros(3600*Fs*2,length(epiDist));
seisD = zeros(len*60*Fs,length(epiDist));
names = cell(2,length(epiDist));

% pull the data from seismometers with the origin time of the earthquake
index=1;
for i=1:length(eq)
    if (eq(i).PreferredDepth >= depthMin) && (eq(i).PreferredDepth <= depthMax)
        t = datetime(datenum(eq(i).PreferredTime),'ConvertFrom','datenum');
        [Y,M,D,H,MN,S] = datevec(t);
        [file]=mcms2mat(Y,M,D,H,00,0,0);
        load(file{1})
        
        [seisD,index,names]=irisSeisComp(t,MN,S,seisD,rawData,Fs,colo,cohi,...
            index,names,file,len,comp,sx,sy,sz);
    end
end

% create time vector
e=len*60;
tt=linspace(0,e,e*Fs);

if strcmp(comp,'Z')==1 
    % scale and add distances to vertical seismic data 
    seisData=zeros(size(seisD));
    for i=1:size(seisD,2)
        [data]=scaleSeis(seisD(:,i),epiDist(i));
        seisData(:,i)=data;
    end
else 
    % save X and Y components to rotate for later 
    seisData=seisD;
end

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

% Optional outputs
varns={tt,seisData,names};
varargout=varns(1:nargout);