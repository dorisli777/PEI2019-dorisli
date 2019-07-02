function varargout=plotWeatherData(filename,begWeek,endWeek)
% plt=plotWeatherData(filename)
% 
% Input:
% filename        Filename with full path 
%                 (def: '~/Documents/MATLAB/WeatherDataBackup/all.asc')
% begWeek         How many weeks to be cut off from top of file (def:0)
% endWeek         How many weeks to observe (def:1)
% 
% Output:
% plt             Plot of weather data (def: Temperature vs Time)
% 
% Description:
% This function reads in data outputted by a weather station and parses it
% and plots the variables. 
% 
% Last modified by dorisli on July 2, 2019 ver. R2018a

defval('filename','~/Documents/MATLAB/WeatherDataBackup/all.asc')
defval('begWeek',0)
defval('endWeek',1)
hdcut = 7*begWeek*1440;
lines = 7*endWeek*1440;

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

% splitting arrays based of time desired for observation 
time = Sc(hdcut+1:lines+1);
measurement6 = Dm(hdcut+1:lines+1);
measurement7 = Sm(hdcut+1:lines+1);
temp = Ta(hdcut+1:lines+1);
measurement9 = Ua(hdcut+1:lines+1);
pressure = Pa(hdcut+1:lines+1);
rain = Rc(hdcut+1:lines+1);
measurement12 = Hc(hdcut+1:lines+1);

% plot data 
plt = scatter(time,temp,'filled');
title('Temperature and Time ')
xlabel('Time (in seconds)')
ylabel('Temperature (in C)')

% Optional Outputs
varns={plt};
varargout=varns(1:nargout);