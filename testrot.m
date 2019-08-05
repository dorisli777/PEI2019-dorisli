function varargout=testrot(fileX,fileY,fileZ,stla,stlo,evla,evlo)
% [f]=testrot(fileX,fileY,fileZ,stla,stlo,evla,evlo)
% 
% INPUTS:
% 
% fileX     The filename with full path of the X component of seismic data
% fileY     The filename with full path of the Y component of seismic data
% fileZ     The filename with full path of the Z component of seismic data
% stla      The station latitude
% stlo      The station longitude
% evla      The event latitude 
% evlo      The event longitude 
% 
% OUPUT:
% 
% vT        The transverse component 
% vR        The radial component 
% f         The figure handle of the three plotted seismograms 
% 
% Description:
% This function takes in three SAC files (from X,Y,Z components) and
% rotates the north and east components to return the transverse and radial
% components of data. It then plots the seismograms. 
% Used in conjunction with readsac.m 
% 
% Last modified by dorisli on August 5, 2019 ver. R2018a 

defval('fileX', '~/Documents/MINISEED/07/06/PP.S0001.00.HHX.D.2019.187.030000.SAC')
defval('fileY', '~/Documents/MINISEED/07/06/PP.S0001.00.HHY.D.2019.187.030000.SAC')
defval('fileZ', '~/Documents/MINISEED/07/06/PP.S0001.00.HHZ.D.2019.187.030000.SAC')
% Princeton's Guyot Hall seismometer 
defval('stla', 40.3458117)
defval('stlo', -74.6569256)
% California 2019-07-06 03:19:53 earthquake 
defval('evla', 35.77)
defval('evlo',-117.60)

% read in three sac files (different components)
[seisDX,~,~,~,tims]=readsac(fileX);
[seisDY]=readsac(fileY);
[seisDZ]=readsac(fileZ);

% calculate azimuth 
az = azimuth(stla,stlo,evla,evlo);

% rotate the north and east components 
[vT,vR]=rt_rotate(seisDX,seisDY,az);

% plot the rotations
f=figure(1);
clf

subplot(3,1,1)
plot(tims,seisDZ)
title('Vertical Component')
xlabel('Time (sec)')
ylabel('Uncorrected Counts')
ylim([min(seisDZ)-7000 max(seisDZ)+7000])
xlim([1500 3600])

subplot(3,1,2)
plot(tims,vT)
title('Transverse Component')
xlabel('Time (sec)')
ylabel('Uncorrected Counts')
ylim([min(vT)-7000 max(vT)+7000])
xlim([1500 3600])

subplot(3,1,3)
plot(tims,vR)
title('Radial Component')
ylabel('Uncorrected Counts')
xlabel('Time (sec)')
ylim([min(vR)-7000 max(vR)+7000])
xlim([1500 3600])

suptitle({sprintf('Ridgecrest 7.1 Earthquake (%.2f,%.2f) on 2019-07-06 03:19:53 UTC',evla,evlo) ;...
    sprintf('recorded at Guyot Hall (%.2f,%.2f) at 03:00:00 UTC',stla,stlo)})

% Optional Output
varns={vT,vR,f};
varargout=varns(1:nargout);