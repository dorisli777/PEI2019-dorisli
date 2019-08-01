function varargout=rotate_seis(seisData,az,eq,epiDist,len,Fs,colo,cohi,depthMin,depthMax)
% [seisrotT,seisrotR]=rotate_seis(seisData,az,eq,epiDist,len,Fs,colo,cohi,depthMin,depthMax)
% 
% INPUTS:
% 
% seisData 
% 
% OUTPUTS: 
% 
% seisrotT
% seisrotR
% 
% Description:
% 
% 
% Last modified by dorisli on August 1, 2019 ver. R2018a 

% get seismic data from X and Y components 
comp2='X';
comp3='Y';
[~,seisDX]=irisSeis(eq,epiDist,len,Fs,colo,cohi,depthMin,depthMax,comp2);
[~,seisDY]=irisSeis(eq,epiDist,len,Fs,colo,cohi,depthMin,depthMax,comp3);

seisDataX = zeros(size(seisDX));
seisDataY = zeros(size(seisDY));
seisrotT = zeros(size(seisDataX));
seisrotR = zeros(size(seisDataY));

% rotate the data
for i = 1:size(seisData,2)
    vx=seisDX(:,i);
    vy=seisDY(:,i);
    [vxr,vyr]=rt_rotate(vx,vy,az(i));
    seisDataX(:,i)=vxr;
    seisDataY(:,i)=vyr;
    
    % scale and add distances to data 
    seisrotT(:,i)=((seisDataX(:,i)-...
       mean(seisDataX(:,i)))/sqrt(mean(abs(seisDataX(:,i))))) + epiDist(i);
    seisrotR(:,i)=((seisDataY(:,i)-...
       mean(seisDataY(:,i)))/sqrt(mean(abs(seisDataY(:,i))))) + epiDist(i);
end

% Optional Outputs 
varns={seisrotT,seisrotR};
varargout=varns(1:nargout);