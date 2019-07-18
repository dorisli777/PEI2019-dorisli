function varargout=waveSpeeds(filenameP,filenameS)
% [fig]=waveSpeeds(filenameP,filenameS)
% 
% Inputs:
% filenameP      Calculated from TAUP, the P wave travel times at distances
%                0 to 100 degrees (incremented by 10 deg)
% filenameS      Calculated from TAUP, the S wave travel times at distances
%                0 to 100 degrees (incremented by 10 deg)
% 
% Output:
% fig            The plot handle of the P and S wave travel times against
%                distances 
% 
% Description:
% This function plots the P and S wave travel times (calculated with TAUP) 
% against distance (in deg). 
% 
% Last modified by dorisli on July 18, 2019 ver. R2018a

defval('filenameP','~/Documents/MATLAB/Pwave.txt')
defval('filenameS','~/Documents/MATLAB/Swave.txt')

% Scan and parse data of P and S wave arrival times from TAUP
fileID = fopen(filenameP);
P = textscan(fileID,'%f %f %f %f %f %f %f %f %f %f');
fclose(fileID);
Pwave = cell2mat(P);

fileID = fopen(filenameS);
S = textscan(fileID,'%f %f %f %f %f %f %f %f %f %f');
fclose(fileID);
Swave=cell2mat(S);

% generate epicentral distances (in deg)
xx=linspace(0,100,10);

% plot the waves 
fig=figure(3);
clf
plot(xx,Pwave)
hold on
grid on
plot(xx,Swave)
title('P and S Wave Travel Times at Depth 23km')
xlabel('Epicentral Distance (deg)')
ylabel('Travel Times (sec)')
legend('P Wave','S Wave')
hold off

% saveas(fig,'~/Documents/MATLAB/EQCatalogFig/PSWaves.png')

% Optional outputs
varns={fig};
varargout=varns(1:nargout);
