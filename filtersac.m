function varargout=filtersac(filename,Fs,colo,cohi)
% [filt]=filtersac(filename,Fs,colo,cohi)
% 
% Inputs:
% filename
% Fs         The sampling frequency (Hz)
% colo       The lower corner frequency (Hz)
% cohi       The higher corner frequency (Hz)
% 
% Outputs:
% filt       The plot handle of the filtered signal 
% 
% Description:
% This function filters (using bandpass filtering) a signal and plots the
% output alongside with the original singal. Uses the readsac.m and 
% bandpass.m programs from repository slepian_oscar. 
% 
% Last modified by dorisli on July 14,2019 ver. R2018a

defval('filename','~/Documents/MINISEED/07/06/PP.S0001.00.HHY.D.2019.187.030000.SAC')

% reading in and parsing sac file
[SeisData,HdrData,~,~,tims]=readsac(filename);

defval('Fs',110)
defval('colo',0.01)
defval('cohi',0.10)

% filter 
[xf]=bandpass(SeisData,Fs,colo,cohi);

% plot unfiltered data 
subplot(2,1,1)
plot(tims,SeisData)

% Guyot Hall STLO and STLA, check with SAC2SAC, check with HdrData
lola=guyotphysics(0);

% Cosmetics and annotation
title(sprintf('recorded at Princeton University Guyot Hall %s (%10.5f%s,%10.5f%s)',deblank(HdrData.KSTNM),...
		 lola(1),176,lola(2),176),...
	         'FontWeight','Normal');
ylabel(sprintf('uncorrected %s component',...
		  HdrData.KCMPNM));
xlabel(sprintf('time (s) since %4.4i (%3.3i) %2.2i:%2.2i:%2.2i.%3.3i',...
		  HdrData.NZYEAR,HdrData.NZJDAY,...
		  HdrData.NZHOUR,HdrData.NZMIN,HdrData.NZSEC,HdrData.NZMSEC));
axis tight
longticks(gca,2)

% plot filtered data 
subplot(2,1,2)
filt = plot(tims,xf);

% Guyot Hall STLO and STLA, check with SAC2SAC, check with HdrData
lola=guyotphysics(0);

% Cosmetics and annotation
title(sprintf('recorded at Princeton University Guyot Hall %s (%10.5f%s,%10.5f%s)',deblank(HdrData.KSTNM),...
		 lola(1),176,lola(2),176),...
	         'FontWeight','Normal');
ylabel(sprintf('uncorrected %s component',...
		  HdrData.KCMPNM));
xlabel(sprintf('time (s) since %4.4i (%3.3i) %2.2i:%2.2i:%2.2i.%3.3i',...
		  HdrData.NZYEAR,HdrData.NZJDAY,...
		  HdrData.NZHOUR,HdrData.NZMIN,HdrData.NZSEC,HdrData.NZMSEC));
axis tight
longticks(gca,2)

% Optional Output 
varns={filt};
varargout=varns(1:nargout);