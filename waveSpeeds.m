function varargout=waveSpeeds(eq,epiDist,minMag,maxRad)
% [TTPs,TTSs,epiDiss,fig]=waveSpeeds(eq,epiDist,minMag,maxRad)
% 
% Inputs:
% eq             Returned from irisFetch.m; and object containing information
%                on all the events found in database
% epiDist        The epicentral distances (in km) between each event and the 
%                origin
% minMag         The minumum magnitude of an event
% maxRad         Maximum radial distance around a specified origin
% 
% Output:
% TTPs           The sorted predicted travel times of P waves through TAUP
% TTSs           The sorted predicted travel times of S waves through TAUP
% epiDiss        The sorted epiDists of each event (in deg)
% fig            The plot handle of the P and S wave travel times against
%                distances 
% 
% Description:
% This function finds and plots the P and S wave travel times (calculated 
% with TAUP) of the event depths and distances given by irisFetch. The
% alternative method allows input of text files and plots a general P and S
% wave curve at a given depth. 
% 
% Last modified by dorisli on July 22, 2019 ver. R2018a

n = length(eq);
TTP = zeros(1,n);
TTS = zeros(1,n);
epiDis = km2deg(epiDist);

for i=1:n
    % getting P wave travel times from bash script 'tauptimeP'
    [~,tt]=system(sprintf('~/Documents/MATLAB/PEI2019-dorisli/tauptimeP %d %d',...
        eq(i).PreferredDepth,epiDis(i)));
    ttp = strings;
    for j=1:length(tt)-1
        ttp = strcat(ttp,tt(j));
    end
    ttp = str2double(ttp);
    TTP(1,i)=ttp;
    % getting S wave travel times from bash script 'tauptimeS'
    [~,tt]=system(sprintf('~/Documents/MATLAB/PEI2019-dorisli/tauptimeS %d %d',...
       eq(i).PreferredDepth,epiDis(i)));
    tts = strings;
    for j=1:length(tt)-1
        tts=strcat(tts,tt(j));
    end
    tts = str2double(tts);
    TTS(1,i)=tts;
end

% plot the P and S waves 
TTPs = sort(TTP);
TTSs = sort(TTS);
epiDiss = sort(epiDis);

fig=figure(2);
clf
plot(epiDiss,TTPs)
hold on
grid on
plot(epiDiss,TTSs)
title(sprintf('P and S Wave Travel Times (Min Mag:%d, Max Rad:%d deg)',...
    minMag,maxRad))
xlabel('Epicentral Distance (deg)')
ylabel('Travel Times (sec)')
legend('P Wave','S Wave')
hold off

% saveas(fig,'~/Documents/MATLAB/EQCatalogFig/PSWavesMAG4.png')

%%%%%%%%%%%%%%%%%%%%%%%% ALTERNATIVE METHOD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Optional outputs
varns={TTPs,TTSs,epiDiss,fig};
varargout=varns(1:nargout);