function Glam = cubqui1D_spjac(p,u)
%obtain values of u
uu = u(1:p.nu);
% compute dG/dlam 
Glam = - p.mat.M*(uu + uu.^3 -uu.^5);
end
