function [lat,lon,plt]=plotMerm(webpage)
  % [lat,lon,plt]=plotMerm(webpage)
  %
  % Input:
  % webpage     The name of the webpage with data
  %             (ex: 'http://geoweb.princeton.edu/people/simons/SOM/P017_030.txt')
  % 
  % Output:
  % lat         Array of latitude values
  % lon         Array of longitude values
  % plt         Scatter plot of locations of the mermaid 
  %
  % Description:
  % This function finds the latitudes and longitudes of the mermaid 
  % locations and plots them on a scatter plot (lon vs lat).
  % 
  % Last modified by dorisli on June 24, 2019

% read in and parse the data
[split,sz,col,n]=parseMermData(webpage);  

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

% plot the mermaid locations
plt = scatter(lon,lat,20,'filled');
grid on
title('Plot of P017 Mermaids (Nov 27, 2018 - Jun 12, 2019)')
ylabel('Latitude (in degrees)')
xlabel('Longitude (in degrees)')
legend('Mermaid Locations')
