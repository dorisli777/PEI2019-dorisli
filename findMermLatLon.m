function [lat,lon]=findMermLatLon(webpage,hdcut)
% [lat,lon]=plotMerm(webpage,hdcut)
%
% Input:
% webpage     The name of the webpage with data
%             (ex: 'http://geoweb.princeton.edu/people/simons/SOM/P017_030.txt')
% hdcut       Number of lines to cut off the top of the file (def: 0)
% 
% Output:
% lat         Array of latitude value 
% lon         Array of longitude values
%
% Description:
% This function finds the latitudes and longitudes of the mermaid 
% locations.
% 
% Last modified by dorisli on June 26, 2019 ver. R2018a

defval('webpage','http://geoweb.princeton.edu/people/simons/SOM/P017_030.txt')
defval('hdcut',0)

% read in and parse the data
[split,sz,col,n]=parseMermData(webpage,hdcut);  

% latitude and longitude arrays
lat = zeros(1,n);
lon = zeros(1,n);

% inputting latitude and longitude values from file
x = 1;
for i = 4:col:sz
    lat(x) = str2double(split(i));
    lon(x) = str2double(split(i + 1));
    x = x + 1;
end