function varargout=rotate_seis(n,e,phi)
% 
% 
% 

defval('phi',45)

deg_to_rad = pi/180;

cphi = cos(phi*deg_to_rad);
sphi = sin(phi*deg_to_rad);

r = cphi*n + sphi*e;
t = -sphi*n + cphi*e;

% Optional Outputs 
varns={r,t};
varargout=varns(1:nargout);