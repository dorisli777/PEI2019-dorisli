function [plt]=plotMerm(webpage,hdcut)
% [plt]=plotMerm(webpage,hdcut)
%
% Input:
% webpage     The name of the webpage with data
%             (ex: 'http://geoweb.princeton.edu/people/simons/SOM/P017_030.txt')
% hdcut       Number of lines to cut off the top of the file (def: 0)
% 
% Output:
% plt         Scatter plot of locations of the mermaid 
%
% Description:
% This function plots the longitude and latitude of mermaid locations
% on a scatter plot (lon vs lat).
% 
% Last modified by dorisli on June 26, 2019

defval('hdcut',0)

[lat,lon]=findMermLatLon(webpage,hdcut);

% plotting lat and lon
plt = scatter(lon,lat,20,'filled');
grid on
title('Plot of P017 Mermaids (Nov 27, 2018 - Jun 12, 2019)')
ylabel('Latitude (in degrees)')
xlabel('Longitude (in degrees)')
legend('Mermaid Locations')
