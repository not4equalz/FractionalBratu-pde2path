function Glam = bratu3D_spjac(p,u)
%obtain values of u
uu = u(1:p.nu);
% compute dG/dlam 
Glam = - p.mat.M*(exp(uu));
end
