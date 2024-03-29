function varargout=magDist(magnitude,distance)
% fig=magDist(magnitude,distance)
%
% INPUTS:
% 
% magnitude     An array of observable magnitude values 
% distance      An array of distances (corresponding to the magnitudes) 
%               at which the earthquakes were observable (in km)
%
% OUTPUT: 
% 
% fig           The plot handle for the relation graph
% 
% Description:
% This function plots the observable magnitude and distance (in km) 
% relations from a certain seismometer (def: Princeton Guyot Hall). 
% 
% Last modified by dorisli on July 22, 2019 ver.R2018a 

mag=[7.5,7.3,7,7.1,7.9,7,3.04,4.6,3.4,4.4,5.4,5.9,5.2,8.2,7.5,7.5,3.8,3.04,...
    2.6,5.1,6.6,5.7,5.9,5.7,6.6,6.8,6.2,6.5,7.5,6.8,7,7.1,6.8,7.3,2.3,2.17,...
    2.3];

dist=[2681.9,3484.9,5407.9,5727.8,5488,6138.8,226.37,374.52,726.23,1027.9,...
    2263.1,2263.9,2701.7,12424,13726,15314,886.45,226.37,261.38,2323.8,...
    3319.5,3322.4,3323.9,3306.6,4337.4,4316.8,4316.3,4350.3,4736.9,5401.6,...
    5407.9,6238.6,6889.9,8008.1,269.57,130.91,269.57];

defval('magnitude',mag)
defval('distance',dist)

% plot relations 
fig=figure(4);
clf
scatter(distance,magnitude,'Filled')
grid on
title('Observable Earthquakes from Guyot Hall')
xlabel('Epicentral Distance (km)')
ylabel('Magnitude of Event')
ylim([0 10])

% saveas(fig,'~/Documents/MATLAB/PEI2019-dorisli/catalog_figures/EpiDist.png')

% Optional Output
varns={fig};
varargout=varns(1:nargout);