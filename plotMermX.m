function [timeLon,plt]=plotMermX(split,lon)
  % [timeLon,plt]=plotMermX(split,lon)
  % 
  % Input:
  % ..

sz = length(split) - 1;
col = 15;
n = sz/col;

timeLon = zeros(1,n);

x = 1;
for i = 3:15:sz
  t = split(i);
  [~, ~, ~, H, MN, S] = datavec(t);
  seconds = H*3600+MN*60+S;
  timeLon(x) = seconds;
  x = x + 1;
end 

plt = scatter(timeLon,lon);
