function Gu = bratu2Df_sGjac(p,u)
% Jacobian of bratu1D_sG wrt nodal unknowns u

%obtain all parameters
par = u(p.nu+1:end);
%lambda is the first one
lam = par(1);
% obtain values of u
uu = u(1:p.nu);

%derivative of nonlinear part
df = lam*exp(uu);

%assemble jacobian
Gu = -p.mat.M*p.mat.Kalpha - p.mat.M*spdiags(df,0,p.nu,p.nu);
end
