function r = bratu1D_sG(p,u)
%algebraic residual for 1D Bratu in FEM form
%Here written as  c*K*u - M*(lambda*exp(u)) = 0
%
%Parameters are stored after the nodal values:
%par(1)=lambda

par = u(p.nu+1:end);
lam = par(1);
c   = 1;

uu = u(1:p.nu);

r = c*(p.mat.K*uu) - p.mat.M*(lam*exp(uu));
end
