function Gu = bratu1D_sGjac(p,u)
% Jacobian of bratu1D_sG wrt nodal unknowns u
par = u(p.nu+1:end);
lam = par(1);
% obtain values of u
uu = u(1:p.nu);
%derivative of nonlinear part
df = lam*exp(uu);
%assemble jacobian
Gu = p.mat.K - p.mat.M*spdiags(df,0,p.nu,p.nu);
end
