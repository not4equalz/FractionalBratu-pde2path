function [c,a,f,b]=bratu_G(p,u) 
% pde for Bratu 
par=u(p.nu+1:end); u=pdeintrp(p.mesh.p,p.mesh.t,u(1:p.nu)); 
c=1; a=0;f=par(1)*exp(u); b=0;
