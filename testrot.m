function varargout=testrot(fileX,fileY,fileZ,stla,stlo,evla,evlo)
% [f]=testrot(fileX,fileY,fileZ,stla,stlo,evla,evlo)
% 
% INPUTS:
% 
% fileX
% fileY
% fileZ 
% stla 
% stlo
% evla 
% evlo 
% 
% OUPUT:
% 
% f 
% 
% Description:
% 
% 
% Last modified by dorisli on August 1, 2019 ver. R2018a 

defval('fileX', '~/Documents/MINISEED/07/06/PP.S0001.00.HHX.D.2019.187.030000.SAC')
defval('fileY', '~/Documents/MINISEED/07/06/PP.S0001.00.HHY.D.2019.187.030000.SAC')
defval('fileZ', '~/Documents/MINISEED/07/06/PP.S0001.00.HHZ.D.2019.187.030000.SAC')
% Princeton's Guyot Hall seismometer 
defval('stla', 40.3458117)
defval('stlo', -74.6569256)
% California 2019-07-06 03:19:53 earthquake 
defval('evla', 35.77)
defval('evlo',-117.60)

% read in three sac files (different components)
[seisDX,~,~,~,tims]=readsac(fileX);
[seisDY]=readsac(fileY);
[seisDZ]=readsac(fileZ);

% calculate azimuth 
az = azimuth(stla,stlo,evla,evlo);

% rotate the north and east components 
[vT,vR]=rt_rotate(seisDX,seisDY,az);

% plot the rotation 
f=figure(1);
clf

subplot(3,1,1)
plot(tims,seisDZ)
title('Vertical Component')
xlim([1500 3600])

subplot(3,1,2)
plot(tims,vT)
title('Transverse Component')
xlim([1500 3600])

subplot(3,1,3)
plot(tims,vR)
title('Radial Component')
xlim([1500 3600])

% Optional Output
varns={f};
varargout=varns(1:nargout);