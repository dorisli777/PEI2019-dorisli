function varargout=findMermVel(timeElapsed,lat,lon,n)
% [velocity,velX,velY,dist,distX,distY]=findMermVel(webpage);
% 
% Inputs: 
% timeElapsed      An array of elapsed times between the origin and each pt
% lat              From plotMerm, an array of latitude values
% lon              From plotMerm, an array of longitude values
% 
% Outputs:
% velocity         An array of velocity vectors at each mermaid location
% velX             An array of the X-component of velocity vectors 
% velY             An array of the Y-component of velocity vectors 
% dist             An array of great circle distances from the orign to 
%                  each mermaid location
% distX            An array of longitude distances (X-component) between 
%                  origin and each mermaid location
% distY            An array of latitude distances (Y-component) between 
%                  origin and each mermaid location
% 
% Description:
% This function computes the velocity (km/s) and its X and Y components of 
% each mermaid location based off the initial data point (origin).
% 
% Last modified by dorisli on June 25, 2019 ver. R2018a

velocity = zeros(1,n);
velX = zeros(1,n);
velY = zeros(1,n);

dist = zeros(1,n);
distX = zeros(1,n);
distY = zeros(1,n);
R = 6371;

% calculating general velocities
for x = 2:length(lat)
    dist(x) = distance(lat(x),lon(x),lat(x - 1),lon(x - 1));
    velocity(x) = dist(x)/timeElapsed(x);
    
    % separate components of velocity 
    distX(x) = deg2rad(lon(x)-lon(x-1))*R;
    velX(x) = distX(x)/timeElapsed(x);
    
    distY(x) = deg2rad(lat(x)-lat(x-1))*R;
    velY(x) = distY(x)/timeElapsed(x);
end

% convert from radians to km 
for i = 1:n
    velocity(i) = rad2km(velocity(i));
    velX(i) = rad2km(velX(i));
    velY(i) = rad2km(velY(i));
end

% optional output
varns={velocity,velX,velY,dist,distX,distY};
varargout=varns(1:nargout);