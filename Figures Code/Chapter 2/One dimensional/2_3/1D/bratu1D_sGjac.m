function Gu = bratu1D_sGjac(p,u)
%Jacobian of bratu1D_sG wrt nodal unknowns u

par = u(p.nu+1:end);
lam = par(1);
c   = 1;

uu = u(1:p.nu);

%d/du [lam*exp(u)] = lam*exp(u)
df = lam*exp(uu);

Gu = c*p.mat.K - p.mat.M*spdiags(df,0,p.nu,p.nu);
end
