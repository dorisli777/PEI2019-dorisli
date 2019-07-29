function varargout=rt_rotate(n,e,phi)
% [r,t]=rt_rotate(n,e,phi)
% 
% INPUTS:
% 
% n     A vector of values in the north direction
% e     A vector of values in the east direction
% phi   The azimuth of the radial direction of motion (deg)
% 
% OUTPUTS:
% 
% r     Radial vector 
% t     Tangential (or transverse) direction 
% 
% Description:
% This function computes the radial and tangential components of motion
% given the north and east components and the azimuth from north of the
% radial direction. 
% 
% Last modified by dorisli on July 29, 2019 ver. R2018a 

deg_to_rad = pi/180;

cphi = cos(phi*deg_to_rad);
sphi = sin(phi*deg_to_rad);

r = cphi*n + sphi*e;
t = -sphi*n + cphi*e;

% Optional Output
varns={r,t};
varargout=varns(1:nargout);