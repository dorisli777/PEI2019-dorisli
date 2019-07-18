function varargout=irisSeis(eq,epiDist)
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
% find data file in computer 
for i=1:length(eq)
    t = datetime(datenum(eq(i).PreferredTime),'ConvertFrom','datenum');
    [Y,M,D,H] = datevec(t);
    [file]=mcms2mat(Y,M,D,H,00,00,0,0);
    load(file{1})
    seisD(:,i)=sx;
    names{i}=file{1};
end

tt=linspace(hx.B,hx.E,hx.NPTS);

seisData=zeros(size(seisD));
for i=1:length(eq)
    seisData(:,i)=((seisD(:,i)-mean(seisD(:,i)))/sqrt(mean(abs(seisD(:,i))))) + epiDist(i);
end

% for i=1:length(eq)
%     st = datestr(datenum(eq(i).PreferredTime)-1/48,31);
%     en = datestr(datenum(eq(i).PreferredTime)+1/24,31);
%     
%     trace = irisFetch.Traces('LD','PANJ','*','BHZ',st,en,'includePZ');
%     e = 24*3600*(datenum(en) - datenum(st));
%     tt = linspace(0, e, trace.sampleCount);
% 
%     seisData(:,i) = trace.data;
%     disp(i)
% %     figure(i+1)
% %     clf
% %     plot(tt, trace.data);
% end
% tims = tt;

% figure(2)
% clf
% plot(tims,seisData)

% Optional outputs
varns={tt,seisData,names};
varargout=varns(1:nargout);