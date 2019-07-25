function varargout=irisSeis(eq,epiDist,len,Fs,colo,cohi,depthMin,depthMax)
% [tt,seisData,names]=irisSeis(eq,epiDist,len,Fs,colo,cohi,depthMin,depthMax)
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
% depthMin 
% depth Max 
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
% function scales and filters the seismic data as well. Uses mcms2sac.m 
% and mseed2sac. 
% 
% Last modified by dorisli on July 23, 2019 ver R2018a 

% pull the data from seismometers with the origin time of the earthquake
rawData = zeros(3600*Fs*2,length(epiDist));
seisD = zeros(len*60*Fs,length(epiDist));
names = cell(2,length(epiDist));

index=1;
for i=1:length(eq)
    if (eq(i).PreferredDepth >= depthMin) && (eq(i).PreferredDepth <= depthMax)
        t = datetime(datenum(eq(i).PreferredTime),'ConvertFrom','datenum');
        [Y,M,D,H,MN,S] = datevec(t);
        [file]=mcms2mat(Y,M,D,H,00,0,0);
        load(file{1})
        % check to make sure file is an hour long 
        if length(sx) == 3600*Fs
            % filter the data 
            [x]=bandpass(sx,Fs,colo,cohi);
            rawData(1:3600*Fs,index)=x;
            names{1,index}=file{1};
    
            % download hour after 
            t = t + 1/24;
            [Y,M,D,H] = datevec(t);
            [file]=mcms2mat(Y,M,D,H,00,0,0);
            load(file{1})
            if length(sx) == 3600*Fs
                % filter the data 
                [xa]=bandpass(sx,Fs,colo,cohi);
                rawData((3600*Fs+1):end,index)=xa;
                names{2,index}=file{1};
        
                % clip data: takes points at the event time and 60 min after event time 
                sec=ceil(MN*60+S);
                st=sec*Fs;
                en=st+len*60*Fs-1;
                seisD(:,index) = rawData(st:en,index);
                index = index + 1;
            else
                disp(sprintf('Failed to get data from fragemented File %s',file{1}))
            end
        else 
            disp(sprintf('Failed to get data from fragemented File %s',file{1}))
        end
    end
end

% create time vector
e=len*60;
tt=linspace(0,e,e*Fs);

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
disp(size(seisD))
for i=1:size(seisD,2)
    seisData(:,i)=((seisD(:,i)-...
        mean(seisD(:,i)))/sqrt(mean(abs(seisD(:,i))))) + epiDist(i);
end

% Optional outputs
varns={tt,seisData,names};
varargout=varns(1:nargout);