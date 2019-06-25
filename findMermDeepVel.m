function [deepVel,deepVelX,deepVelY]=findMermDeepVel(dist,distX,distY,timeElapsed,sz,col,n)
% [deepVel,deepVelX,deepVelY]=findMermDeepVel(dist,distX,distY,timeElapsed,sz,col,n)
% 
% Inputs:
% dist             From findMermVel, an array of great circle distances 
%                  from the orign to each mermaid location
% distX            From findMermVel, an array of longitude distances 
%                  (X-component) between origin and each mermaid location
% distY            From findMermVel, an array of latitude distances 
%                  (Y-component) between origin and each mermaid location
% timeElapsed      From findMermVel, an array of time (in seconds) passed 
%                  between each point and the point directly before it
% sz               From parseMermData, how many rows in data file 
% col              From parseMermData, number of columns in data file 
% n                From parseMermData, size of split array 
% 
% Outputs:
% deepVel          An array of deep velocity vectors at each mermaid 
%                  location
% deepVelX         An array of the X-component of deep velocity vectors 
% deepVelY         An array of the Y-component of deep velocity vectors 
% 
% Description:
% This function determines the deep velocities (km/s) and its X and Y 
% components at each mermaid location by calculating the velocities between
% the points that occur on different days. 
% 
% Last modified by dorisli on June 25,2019 

deepVel = zeros(1,n);
deepVelX = zeros(1,n);
deepVelY = zeros(1,n);

% calculate velocities between locations on different days 
x = 2;
for i = (2 + col):col:sz
    if (strcmp(split(i),split(i - col)) == 0)
        deepVel(x) = dist(x)/timeElapsed(x);
        deepVelX(x) = distX(x)/timeElapsed(x);
        deepVelY(x) = distY(x)/timeElapsed(x);
    end
    x = x + 1;
end

% convert from radians to km 
for i = 1:n
    deepVel(i) = rad2km(deepVel(i));
    deepVelX(i) = rad2km(deepVelX(i));
    deepVelY(i) = rad2km(deepVelY(i));
end
