function varargout=savepdf(fig,filename)
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
  % Last modified by dorisli on June 28 ,2019 ver. R2018a

  print(fig,'-dpdf','-bestfit',filename)
  
  % Optional Output
  varns={filename};
  varargout=varns(1:nargout);
