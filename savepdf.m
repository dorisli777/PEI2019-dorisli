function [filename]=savepdf(fig,filename)
  % [filename]=SAVEPDF(fig,filename)
  %
  % This function prints a figure to .pdf
  %
  % Input:
  % fig          Figure handle
  % filename     The output pdf filename
  % 
  % Output:
  % filename     The output pdf filename 
  % 
  % Last modified by dorisli on June 17,2019 ver. R2018a

  print(fig,'-dpdf',filename)
