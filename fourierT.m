function varargout=fourierT(Fs,data)
% [f,Y]=fourierT(Fs,data)
% 
% Inputs:
% Fs          The sampling frequency of the data
% data        The data to be transformed (or equation) 
% 
% Outputs:
% f           The frequency interval 
% P1          The fourier transformation values
% 
% Description:
% This function performs a Fourier Transformation using matlab's fft (fast
% Fourier Transform). 
% 
% Last modified by dorisli on July 3, 2019 ver. R2018a 

L = length(data);
Y = fft(data);
P1 = abs(Y(1:L/2+1));
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

% Optional Outputs
varns={f,P1};
varargout=varns(1:nargout);