function varargout=rotate_seis(seisData,az,eq,epiDist,len,Fs,colo,cohi,depthMin,depthMax)
% [seisrotT,seisrotR,seisX,seisY]=rotate_seis(seisData,az,eq,epiDist,...
%                                    len,Fs,colo,cohi,depthMin,depthMax)
% 
% INPUTS:
% 
% seisData    An nxm matrix of seismic data of the event, beginning with
%             data from the time of the event to the specified length of
%             time
% az          An array of azimuth values corresponding to the events in eq 
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
% 
% OUTPUTS: 
% 
% seisrotT    An nxm array of rotated transverse component values 
% seisrotR    An nxm array of rotated radial component values 
% seisX       An nxm array of unrotated X component data 
% seisY       An nxm array of unrotated Y component data 
% 
% Description:
% This function rotates the nxm arrays of seismic data from the north and
% east components. It then scales and adds epicentral distances to the
% data. 
% 
% Last modified by dorisli on August 8, 2019 ver. R2018a 

% get seismic data from X and Y components 
comp2='X';
comp3='Y';
[~,seisDX]=irisSeis(eq,epiDist,len,Fs,colo,cohi,depthMin,depthMax,comp2);
[~,seisDY]=irisSeis(eq,epiDist,len,Fs,colo,cohi,depthMin,depthMax,comp3);

% initialize arrays 
seisDataX = zeros(size(seisDX));
seisDataY = zeros(size(seisDY));
seisX = zeros(size(seisDX));
seisY = zeros(size(seisDY));
seisrotT = zeros(size(seisDataX));
seisrotR = zeros(size(seisDataY));

% rotate the data
for i = 1:size(seisData,2)
    vx=seisDX(:,i);
    vy=seisDY(:,i);
    [vxr,vyr]=rt_rotate(vx,vy,az(i));
    seisDataX(:,i)=vxr;
    seisDataY(:,i)=vyr;
    
    % scale and add distances to rotated data 
    [t]=scaleSeis(seisDataX(:,i),epiDist(i));
    seisrotT(:,i)=t;
    [r]=scaleSeis(seisDataY(:,i),epiDist(i));
    seisrotR(:,i)=r;
   
    % scale and add distances to unrotated data 
    [x]=scaleSeis(seisDX(:,i),epiDist(i));
    seisX(:,i)=x;
    [y]=scaleSeis(seisDY(:,i),epiDist(i));
    seisY(:,i)=y;
end

% Optional Outputs 
varns={seisrotT,seisrotR,seisX,seisY};
varargout=varns(1:nargout);