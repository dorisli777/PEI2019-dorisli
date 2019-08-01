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
% output alongside with the original singal. Uses the readsac.m,  
% bandpass.m, and plotsac.m programs from repository slepian_oscar. 
% 
% Last modified by dorisli on July 15, 2019 ver. R2018a

defval('filename','~/Documents/MINISEED/07/06/PP.S0001.00.HHZ.D.2019.187.030000.SAC')

% reading in and parsing sac file
[SeisData,HdrData]=readsac(filename);

defval('Fs',110)
defval('colo',0.01)
defval('cohi',0.1)

% filter 
[xf]=bandpass(SeisData,Fs,colo,cohi);
[f,P1]=fourierT(Fs,SeisData);

% plot unfiltered data 
subplot(3,1,1)
plotsac(SeisData,HdrData);
xlim([1800 3600])

% plot filtered data 
subplot(3,1,2)
[filt] = plotsac(xf,HdrData);
xlim([1800 3600])

subplot(3,1,3)
plot(f,P1)

% Optional Output 
varns={filt};
varargout=varns(1:nargout);