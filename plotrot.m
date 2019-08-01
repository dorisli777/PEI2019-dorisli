function varargout=plotrot(seisData,seisrotT,seisrotR,tt,len)
% fig=plotrot(seisData,seisrotT,seisrotR,tt,len)
% 
% INPUTS:
% 
% seisData    An nxm matrix of seismic data of the event, beginning with
%             data from the time of the event to the specified length of
%             time
% seisrotT    From rotate_seis, an nxm array of rotated transverse 
%             component values 
% seisrotR    From rotate_seis, an nxm array of rotated radial 
%             component values 
% tt          A vector of times in sec (x-axis) corresponding to the 
%             seismic data
% len         The length of data plotted since the event time (minutes)
% 
% 
% OUTPUT:
% 
% fig         The figure handle of the plot of the three rotated seismic 
%             components 
% 
% Description:
% This function plots the transverse and radial components of seismic data
% along with the original seismogram (against time) within the given
% parameters in eventCatalog.m 
% 
% Last modified by dorisli on August 1, 2019 ver. R2018a 

fig=figure(2);
clf

% plot vertical component
subplot(3,1,1)
plot(seisData,tt)
title('Vertical Component')
xlabel('Epicentral Distance (km)')
ylabel('Time (sec)')
ylim([0,len*60])
m=max(max(seisData))+150;
xlim([0,m])

% plot transverse component
subplot(3,1,2)
plot(seisrotT,tt)
title('Transverse Component')
xlabel('Epicentral Distance (km)')
ylabel('Time (sec)')
ylim([0,len*60])
m=max(max(seisrotT))+150;
xlim([0,m])

% plot radial component
subplot(3,1,3)
plot(seisrotR,tt)
title('Radial Component')
xlabel('Epicentral Distance (km)')
ylabel('Time (sec)')
ylim([0,len*60])
m=max(max(seisrotR))+150;
xlim([0,m])

% saveas(fig,'~/Documents/MATLAB/EQCatalogFig/MAG7/wavedir/Y.png')

% Optional outputs
varns={fig};
varargout=varns(1:nargout);