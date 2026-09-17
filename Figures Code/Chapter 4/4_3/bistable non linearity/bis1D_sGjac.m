function Gu = bis1D_sGjac(p,u)
% Jacobian of bratu1D_sG wrt nodal unknowns u

%obtain all parameters
par = u(p.nu+1:end);
%lambda is the first one
lam = par(1);
% obtain values of u
uu = u(1:p.nu);

%derivative of nonlinear part
df = lam*(-3*uu.^2 +10/4 * uu -1/4);

%assemble jacobian
Gu = p.mat.K - p.mat.M*spdiags(df,0,p.nu,p.nu);
end
