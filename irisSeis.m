function varargout=irisSeis(eq)
% [tims,seisData]=irisSeis(eq)
% 
% Input:
% eq
% 
% Outputs:
% tims
% seisData
% 
% Description:
% 
% 
% Last modified by dorisli on July 16, 2019 ver R2018a 

% pull the data from seismometers with the origin time of the earthquake

for i=1:length(eq)
    st = datestr(datenum(eq(i).PreferredTime)-1/48,31);
    en = datestr(datenum(eq(i).PreferredTime)+1/24,31);
    
    trace = irisFetch.Traces('LD','PANJ','*','BHZ',st,en,'includePZ');
    e = 24*3600*(datenum(en) - datenum(st));
    tt = linspace(0, e, trace.sampleCount);
    
    seisData(:,i) = trace.data;
    
%     figure(i+1)
%     clf
%     plot(tt, trace.data);
end

tims = tt;

% figure(2)
% clf
% plot(tims,seisData)

% Optional outputs
varns={tims,seisData};
varargout=varns(1:nargout);