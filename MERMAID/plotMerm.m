function varargout=plotMerm(webpage,hdcut)
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
% Last modified by dorisli on June 26, 2019 ver. R2018a

defval('webpage','http://geoweb.princeton.edu/people/simons/SOM/P017_030.txt')
defval('hdcut',0)

[split,sz,col,~]=parseMermData(webpage,hdcut);
[lat,lon]=findMermLatLon(webpage,hdcut);

% plotting lat and lon
plt = scatter(lon,lat,20,'filled');
grid on
title(sprintf('Plot of %s Mermaids (%s to %s)', char(split(1)),...
    char(split(2)), char(split(2 + sz - col))))
ylabel('Latitude (in degrees)')
xlabel('Longitude (in degrees)')
legend('Mermaid Locations')

% optional output
varns={plt};
varargout=varns(1:nargout);