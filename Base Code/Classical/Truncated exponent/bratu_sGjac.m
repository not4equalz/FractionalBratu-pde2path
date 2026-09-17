function Gu = bratu_sGjac(p,u)
% Jacobian of bratu1D_sG wrt nodal unknowns u

%obtain all parameters
par = u(p.nu+1:end);
%lambda is the first one
lam = par(1);
M = par(2);
% obtain values of u
uu = u(1:p.nu);

T = zeros(size(uu));
for k = 0:(M-1)
    T = T + uu.^k / factorial(k);
end

%derivative of nonlinear part
df = lam*T;

%assemble jacobian
Gu = p.mat.K - p.mat.M*spdiags(df,0,p.nu,p.nu);
end
