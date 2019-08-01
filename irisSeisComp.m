function varargout=irisSeisComp(t,MN,S,seisD,rawData,Fs,colo,cohi,index,...
    names,file,len,comp,sx,sy,sz)
% [seisD,index,names]=irisSeisComp(t,MN,S,seisD,rawData,Fs,colo,cohi,index,...
%     names,file,len,comp,sx,sy,sz)
% 
% INPUTS:
% 
% t            The time of the event (in datetime format)
% MN           The minute of the event (HH:MN:SS)
% S            The second of th event (HH:MN:S)
% seisD        Array of seismic data from start time to specified end time
% rawData      Two hours of seismic data of the event 
% Fs           The sampling frequency (Hz)
% colo         The lower corner frequency (Hz)
% cohi         The higher corner frequency (Hz)
% index        A counter from a for loop in irisSeis.m
% names        Array of converted file names 
% file         The file name returned from mseed2mat.m
% len          The length of data plotted since the event time (minutes)
% comp         The desired component of seismic data ('X','Y','Z')
% sx           The x component of seismic data
% sy           The y component of seismic data
% sz           The z component of seismic data
% 
% OUTPUTS:
% 
% seisD        An nxm array of seismic data (each m column is an event)
% index        A counter from a for loop in irisSeis.m
% names        Array of converted file names
% 
% Description:
% This function is used specifically in conjunction with irisSeis and is
% not made to be used independently (hence all the input arguments). This
% function returns either the X, Y, or Z components of seismic data. 
% 
% Last modified by dorisli on August 1, 2019 ver. R2018a 

if strcmp(comp,'Y')==1
    % check to make sure file is an hour long 
    if length(sy) == 3600*Fs
        % filter the data 
        [x]=bandpass(sy,Fs,colo,cohi);
        rawData(1:3600*Fs,index)=x;
        names{1,index}=file{1};
    
        % download hour after 
        t = t + 1/24;
        [Y,M,D,H] = datevec(t);
        [file]=mcms2mat(Y,M,D,H,00,0,0);
        load(file{1})
        if length(sy) == 3600*Fs
            % filter the data 
            [xa]=bandpass(sy,Fs,colo,cohi);
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
elseif strcmp(comp,'Z')==1
    % check to make sure file is an hour long 
    if length(sz) == 3600*Fs
        % filter the data 
        [x]=bandpass(sz,Fs,colo,cohi);
        rawData(1:3600*Fs,index)=x;
        names{1,index}=file{1};
  
        % download hour after 
        t = t + 1/24;
        [Y,M,D,H] = datevec(t);
        [file]=mcms2mat(Y,M,D,H,00,0,0);
        load(file{1})
        if length(sz) == 3600*Fs
            % filter the data 
            [xa]=bandpass(sz,Fs,colo,cohi);
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
elseif strcmp(comp,'X')==1
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

% Optional Output
varns={seisD,index,names};
varargout=varns(1:nargout);