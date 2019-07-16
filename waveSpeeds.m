function varargout=waveSpeeds(eq,epiDist)
% 
% 
% 
% 

depth = [eq.PreferredDepth];
n = length(depth);

ttp = zeros(1,n);
tts = zeros(1,n);

for i=1:n
    TT=tauptime('ph','ttp','depth',depth(1),'degrees',epiDist(1));
    ttp(i) = TT.time;
    
    TT=tauptime('ph','tts','depth',depth(1),'degrees',epiDist(1));
    tts(i) = TT.time;
end

% Optional outputs
varns={ttp,tts};
varargout=varns(1:nargout);
