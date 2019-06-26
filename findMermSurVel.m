function [surfaceVel,surVelX,surVelY]=findMermSurVel(dist,distX,distY,timeElapsed,split,sz,col,n)
% [surfaceVel,surVelX,surVelY]=findMermSurVel(dist,distX,distY,timeElapsed,split,sz,col,n)
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
% split            From parseMermData, the array of strings from data file
% sz               From parseMermData, how many rows in data file 
% col              From parseMermData, number of columns in data file 
% n                From parseMermData, size of split array 
% 
% Outputs:
% surfaceVel       An array of surface velocity vectors at each mermaid 
%                  location
% surVelX          An array of the X-component of surface velocity vectors 
% surVelY          An array of the Y-component of surface velocity vectors 
% 
% Description:
% This function determines the surface velocities (km/s) and its X and Y 
% components at each mermaid location by calculating the velocities between
% the points that occur on the same day. 
% 
% Last modified by dorisli on June 25,2019 ver. R2018a

surfaceVel = zeros(1,n);
surVelX = zeros(1,n);
surVelY = zeros(1,n);

% calculate velocities between pts that occur on the same day
x = 2;
for i = (2 + col):col:sz
    if (strcmp(split(i),split(i - col)) == 1)
        surfaceVel(x) = dist(x)/timeElapsed(x);
        surVelX(x) = distX(x)/timeElapsed(x);
        surVelY(x) = distY(x)/timeElapsed(x);
    end
    x = x + 1;
end

% convert from radians to km 
for i = 1:n
    surfaceVel(i) = rad2km(surfaceVel(i));
    surVelX(i) = rad2km(surVelX(i));
    surVelY(i) = rad2km(surVelY(i));
end