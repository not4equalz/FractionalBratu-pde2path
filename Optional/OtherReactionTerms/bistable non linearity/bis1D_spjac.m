function Glam = bis1D_spjac(p,u)
%obtain values of u
uu = u(1:p.nu);
% compute dG/dlam 
Glam = - p.mat.M*(uu.*(uu - 1/4).*(1-uu));
end
