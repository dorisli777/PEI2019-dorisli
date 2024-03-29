function varargout=getShipData(time)
% [sLat,sLon]=getShipData
% 
% Inputs:
% time         The time wanted for predictions (ex: '07-Aug-2019 23:00:00')
% 
% Outputs:
% sLat         The ship track's latitude 
% sLon         The ship track's longitude 
% 
% Description:
% This function finds and plots the ship's track from August 5,2019 to
% August 31, 2019 and predicts where all the mermaids will be on a given
% time within the ship journey. 
% 
% Last modified by dorisli on June 28, 2019 ver. R2018a

defval('time','07-Aug-2019 08:00:00')

% ship track data 
date_time = [{'05-Aug-2019 08:00:00'},{'06-Aug-2019 18:00:00'},{'07-Aug-2019 08:00:00'},...
    {'07-Aug-2019 23:00:00'},{'08-Aug-2019 13:00:00'}, {'09-Aug-2019 04:00:00'},...
    {'10-Aug-2019 08:00:00'}, {'11-Aug-2019 23:00:00'}, {'13-Aug-2019 01:00:00'},...
    {'14-Aug-2019 19:00:00'}, {'17-Aug-2019 01:00:00'}, {'18-Aug-2019 19:00:00'},...
    {'19-Aug-2019 08:00:00'}, {'20-Aug-2019 02:00:00'}, {'20-Aug-2019 20:00:00'},...
    {'21-Aug-2019 14:00:00'}, {'22-Aug-2019 13:00:00'}, {'23-Aug-2019 02:00:00'},...
    {'23-Aug-2019 15:00:00'}, {'24-Aug-2019 05:00:00'}, {'24-Aug-2019 19:00:00'},...
    {'25-Aug-2019 12:00:00'}, {'26-Aug-2019 04:00:00'}, {'26-Aug-2019 21:00:00'},...
    {'27-Aug-2019 14:00:00'}, {'30-Aug-2019 18:00:00'}, {'31-Aug-2019 08:00:00'}];
sLon = [-149.3, -151.0, -150.0, -149.0, -148.0, -146.0, -144.0, -142.0, -135.0,...
    -136.0, -141.0, -149.0, -151.0, -154.0, -157.0, -160.0, -164.0, -166.0,...
    -168.0, -170.0, -172.0, -174.9, -177.6, -179.0, -180.0, -166.3, -166.3];
sLat = [-17.3, -12.0, -10.0, -8.0, -6.0, -5.0, -6.0, -8.0, -13.0, -17.0, -22.0,...
    -27.0, -28.0, -29.0, -30.0, -31.0, -30.0, -29.0, -28.0, -27.0, -26.0, -25.65...
    -25.63, -25.0, -24.0, -22.2, -22.2];

% find index at where time appears in date_time array 
n = length(date_time);
for i = 1:n
    if (strcmp(time,date_time(i)) == 1)
        index = i;
    end
end

% all mermaid location predictions 
[lon1,lat1]=predictMerm('http://geoweb.princeton.edu/people/simons/SOM/P001_030.txt','N001',time);
[lon2,lat2]=predictMerm('http://geoweb.princeton.edu/people/simons/SOM/P002_030.txt','N002',time,1);
% [lon3,lat3]=predictMerm('http://geoweb.princeton.edu/people/simons/SOM/P003_030.txt','N003',time);
[lon4,lat4]=predictMerm('http://geoweb.princeton.edu/people/simons/SOM/P004_030.txt','N004',time);
[lon5,lat5]=predictMerm('http://geoweb.princeton.edu/people/simons/SOM/P005_030.txt','N005',time);
% [lon6,lat6]=predictMerm('http://geoweb.princeton.edu/people/simons/SOM/P006_030.txt','P006',time);
% [lon7,lat7]=predictMerm('http://geoweb.princeton.edu/people/simons/SOM/P007_030.txt','P007',time,3);
[lon8,lat8]=predictMerm('http://geoweb.princeton.edu/people/simons/SOM/P008_030.txt','P008',time);
[lon9,lat9]=predictMerm('http://geoweb.princeton.edu/people/simons/SOM/P009_030.txt','P009',time);
[lon10,lat10]=predictMerm('http://geoweb.princeton.edu/people/simons/SOM/P010_030.txt','P010',time);
[lon11,lat11]=predictMerm('http://geoweb.princeton.edu/people/simons/SOM/P011_030.txt','P011',time);
[lon12,lat12]=predictMerm('http://geoweb.princeton.edu/people/simons/SOM/P012_030.txt','P012',time);
[lon13,lat13]=predictMerm('http://geoweb.princeton.edu/people/simons/SOM/P013_030.txt','P013',time);
[lon16,lat16]=predictMerm('http://geoweb.princeton.edu/people/simons/SOM/P016_030.txt','P016',time);
[lon17,lat17]=predictMerm('http://geoweb.princeton.edu/people/simons/SOM/P017_030.txt','P017',time);
[lon18,lat18]=predictMerm('http://geoweb.princeton.edu/people/simons/SOM/P018_030.txt','P018',time);
[lon19,lat19]=predictMerm('http://geoweb.princeton.edu/people/simons/SOM/P019_030.txt','P019',time);
[lon20,lat20]=predictMerm('http://geoweb.princeton.edu/people/simons/SOM/P020_030.txt','P020',time);
[lon21,lat21]=predictMerm('http://geoweb.princeton.edu/people/simons/SOM/P021_030.txt','P021',time);
[lon22,lat22]=predictMerm('http://geoweb.princeton.edu/people/simons/SOM/P022_030.txt','P022',time);
[lon23,lat23]=predictMerm('http://geoweb.princeton.edu/people/simons/SOM/P023_030.txt','P023',time);
[lon24,lat24,]=predictMerm('http://geoweb.princeton.edu/people/simons/SOM/P024_030.txt','P024',time);
% [lon25,lat25]=predictMerm('http://geoweb.princeton.edu/people/simons/SOM/P025_030.txt','P025',time);

predLon = [lon1,lon2,lon4,lon5,lon8,lon9,lon10,lon11,lon12,...
    lon13,lon16,lon17,lon18,lon19,lon20,lon21,lon22,lon23,lon24];
predLat = [lat1,lat2,lat4,lat5,lat8,lat9,lat10,lat11,lat12,...
    lat13,lat16,lat17,lat18,lat19,lat20,lat21,lat22,lat23,lat24];

% array of mermaid labels (for plotting)
MermLabels = [{'N001'},{'N002'},{'N004'},{'N005'},{'P008'},{'P009'},...
    {'P010'},{'P011'},{'P012'},{'P013'},{'P016'},{'P017'},{'P018'},{'P019'},{'P020'},...
    {'P021'},{'P022'},{'P023'},{'P024'}];

% plot the ship track and mermaid predictions
f = figure(1);
clf

dx = 0.5;
dy = 0.5;
plot(sLon,sLat,'-o')
text(sLon+dx,sLat+dy,date_time,'Fontsize',7)
hold on 
grid on
scatter(predLon,predLat,'filled')
text(predLon+dx,predLat+dy,MermLabels)
% text(sLon(index),sLat(index),'X','Fontsize',13)
title(sprintf('Ship Track on %s',time))
xlabel('Longitude (in degrees)')
ylabel('Latitude (in degrees)')
hold off 

% savepdf(f,time)

% Optional outputs
varns={sLon,sLat};
varargout=varns(1:nargout);
