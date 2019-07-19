function varargout=waveSpeeds(eq,epiDist)
% [TTP,TTS,fig]=waveSpeeds(filenameP,filenameS)
% 
% Inputs:
% eq             Returned from irisFetch.m; and object containing information
%                on all the events found in database
% epiDist        The epicentral distances (in km) between each event and the 
%                origin
% 
% Output:
% TTP            The predicted travel times of P waves through TAUP
% TTS            The predicted travel times of S waves through TAUP
% fig            The plot handle of the P and S wave travel times against
%                distances 
% 
% Description:
% This function plots the P and S wave travel times (calculated with TAUP) 
% against distance (in deg). 
% 
% Last modified by dorisli on July 19, 2019 ver. R2018a

% Find wave speeds of each earthquake / event
n = length(eq);
TTP = zeros(1,n);
TTS = zeros(1,n);
epiDis = km2deg(epiDist);

for i=1:n
    [~,tt]=system(sprintf('~/Documents/MATLAB/PEI2019-dorisli/tauptimeP %d %d',...
        eq(i).PreferredDepth,epiDis(i)));
    ttp = strings;
    for j=1:length(tt)-1
        ttp = strcat(ttp,tt(j));
    end
    ttp = str2double(ttp);
    TTP(1,i)=ttp;
    [~,tt]=system(sprintf('~/Documents/MATLAB/PEI2019-dorisli/tauptimeS %d %d',...
       eq(i).PreferredDepth,epiDis(i)));
    tts = strings;
    for j=1:length(tt)-1
        tts=strcat(tts,tt(j));
    end
    tts = str2double(tts);
    TTS(1,i)=tts;
end

% plot the waves 
fig=figure(3);
clf
plot(epiDis,TTP)
hold on
grid on
plot(epiDis,TTS)
title('P and S Wave Travel Times (Min Mag:3.3, Max Rad:17 deg)')
xlabel('Epicentral Distance (deg)')
ylabel('Travel Times (sec)')
legend('P Wave','S Wave')
hold off

% saveas(fig,'~/Documents/MATLAB/EQCatalogFig/PSWavesMAG3.png')

%%%%%%%% ALTERNATIVE METHOD %%%%%%%%%

% defval('filenameP','~/Documents/MATLAB/Pwave.txt')
% defval('filenameS','~/Documents/MATLAB/Swave.txt')
% 
% % Scan and parse data of P and S wave arrival times from TAUP
% fileID = fopen(filenameP);
% P = textscan(fileID,'%f %f %f %f %f %f %f %f %f %f');
% fclose(fileID);
% Pwave = cell2mat(P);
% 
% fileID = fopen(filenameS);
% S = textscan(fileID,'%f %f %f %f %f %f %f %f %f %f');
% fclose(fileID);
% Swave=cell2mat(S);
% 
% % generate epicentral distances (in deg)
% xx=linspace(0,100,10);
% 
% % plot the waves 
% fig=figure(3);
% clf
% plot(xx,Pwave)
% hold on
% grid on
% plot(xx,Swave)
% title('P and S Wave Travel Times at Depth 23km')
% xlabel('Epicentral Distance (deg)')
% ylabel('Travel Times (sec)')
% legend('P Wave','S Wave')
% hold off

% saveas(fig,'~/Documents/MATLAB/EQCatalogFig/PSWaves.png')

% Optional outputs
varns={TTP,TTS,fig};
varargout=varns(1:nargout);
