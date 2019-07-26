function varargout=irisSeisComp(t,MN,S,seisD,rawData,Fs,colo,cohi,index,...
    names,file,len,comp,sx,sy,sz)
% [seisD,index,names]=irisSeisComp(t,MN,S,seisD,rawData,Fs,colo,cohi,index,...
%     names,file,len,comp,sx,sy,sz)
% 
% INPUTS:
% 
% t           
% MN
% S 
% seisD 
% rawData 
% Fs 
% colo
% cohi
% index 
% names
% file
% len
% comp
% sx 
% sy
% sz 
% 
% OUTPUTS:
% 
% seisD
% index
% names
% 
% Description:
% This function is used specifically in conjunction with irisSeis and is
% not made to be used independently (hence all the input arguments). This
% function returns either the X, Y, or Z components of seismic data. 
% 
% Last modified by dorisli on July 26, 2019 ver. R2018a 

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