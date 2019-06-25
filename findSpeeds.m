function [speed,surfaceSpeed,deepSpeed]=findSpeeds(velocity,surfaceVel,deepVel)
% [speed,speedSur,speedDeep]=findSpeeds(velocity,surfaceVel,deepVel)
% 
% Inputs:
% velocity       From findMermVel, an array of velocity vectors at each 
%                mermaid location
% surfaceVel     From findMermSurVel, an array of surface velocity vectors
%                at each mermaid location
% deepVel        From findMermDeepVel, an array of deep velocity vectors
%                at each mermaid location
% 
% Outputs:
% speed          The speeds of velocities at each mermaid location 
% surfaceSpeed   The speeds of surface velocities at each mermaid location
% deepSpeed      The speeds of deep velocities at each mermaid location
% 
% Description:
% This function calculates the speeds (km/s) of the velocities, surface
% velocities, and deep velocities at each mermaid location. 
% 
% Last modified by dorisli on June 25, 2019

speed = zeros(1,n);
surfaceSpeed = zeros(1,n);
deepSpeed = zeros(1,n);

% convert velocities into speeds 
for i = 1:n
    speed(i) = abs(velocity(i));
    surfaceSpeed(i) = abs(surfaceVel(i));
    deepSpeed(i) = abs(deepVel(i));
end

% plot speed
histogram(speed)
title('Histogram of Speeds of P017')
ylabel('Abundance of Speed')
xlabel('Speed (km/s)')

