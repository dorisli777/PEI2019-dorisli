function varargout=plotWeatherData(filename)
% plt=plotWeatherData(filename,begWeek,endWeek)
% 
% Input:
% filename      Filename with full path 
%               (def: '~/Documents/MATLAB/WeatherDataBackup/all.asc')
% 
% Output:
% plt           Plot of weather data and the fitted Fourier line 
%               (ex: Temperature vs Time)
% 
% Description:
% This function reads in data outputted by a weather station, parses it,
% and then plots the variables. It also performs a fourier fit and
% transformation (using fft) on temperature vs time. 
% 
% Last modified by dorisli on July 2, 2019 ver. R2018a

defval('filename','~/Documents/MATLAB/WeatherDataBackup/weeks/xx10')

% read and parse in file 
fileID = fopen(filename);
D = textscan(fileID,'%d %d %s %d %s %d %d %d %d %d %d %d');
fclose(fileID);

% split into arrays 
Sc = cell2mat(D(:,1));
Dm = cell2mat(D(:,6));
Sm = cell2mat(D(:,7));
Ta = cell2mat(D(:,8));
Ua = cell2mat(D(:,9));
Pa = cell2mat(D(:,10));
Rc = cell2mat(D(:,11));
Hc = cell2mat(D(:,12));

% If using all the data, ask how many weeks to be used in graphing 
cond = input('Are you using all the data (yes = 1/no = 0)? ');
defval('cond',0)
if (cond == 1)
    begWeek = input('If using all points, how many weeks to cut off? ');
    endWeek = input('If using all points, how many weeks to plot? ');
    defval('begWeek',0)
    defval('endWeek',1)
    hdcut = 7*begWeek*1440;
    lines = 7*endWeek*1440;
elseif (cond == 0)
    hdcut = 0;
    lines = length(Sc) - 1;
end

% splitting arrays based of time desired for observation 
time = Sc(hdcut+1:lines+1);
measurement6 = Dm(hdcut+1:lines+1);
measurement7 = Sm(hdcut+1:lines+1);
temp = Ta(hdcut+1:lines+1);
measurement9 = Ua(hdcut+1:lines+1);
pressure = Pa(hdcut+1:lines+1);
rain = Rc(hdcut+1:lines+1);
measurement12 = Hc(hdcut+1:lines+1);

% Fourier fit to temp and time 
fitT = fit(double(time),double(temp),'fourier7');
disp(fitT)

% Fourier transform
Fs = 1/60;
[f,Y]=fourierT(Fs,temp);

% plot time and temperature and the fitted line 
plt = figure(1);
clf
scatter(time,temp,'filled');
hold on
plot(fitT)
title('Temperature and Time ')
xlabel('Time (in seconds)')
ylabel('Temperature (in C)')
legend('Temperatures (C)','Fitted Fourier Line')
hold off 

% plot the fourier transformation 
figure(2);
clf
plot(f,abs(Y))
title('Single Sided Amplitude Spectrum of Temperature')
xlabel('Frequency (Hz)')
ylabel('abs(Y)')

% plot all the data against time 
figure(3);
clf
subplot(4,2,1)
plot(time,measurement6)
title('Dm and Time ')
xlabel('Time (in seconds)')
ylabel('Dm (in D)')

subplot(4,2,2)
plot(time,measurement7)
title('Sm and Time ')
xlabel('Time (in seconds)')
ylabel('Sm (in M)')

subplot(4,2,3)
scatter(time,temp,'filled');
title('Temperature and Time ')
xlabel('Time (in seconds)')
ylabel('Temperature (in C)')

subplot(4,2,4)
plot(time,measurement9)
title('Ua and Time ')
xlabel('Time (in seconds)')
ylabel('Ua (in P)')

subplot(4,2,5)
plot(time,pressure)
title('Pressure and Time')
xlabel('Time (in seconds)')
ylabel('Pressure (in B)')

subplot(4,2,6)
plot(time,rain)
title('Rainfall and Time')
xlabel('Time (in seconds)')
ylabel('Rainfall (in M)')

subplot(4,2,7)
plot(time,measurement12)
title('Hc and Time ')
xlabel('Time (in seconds)')
ylabel('Hc (in M)')

% Optional Outputs
varns={plt};
varargout=varns(1:nargout);