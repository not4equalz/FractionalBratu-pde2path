function Gu = bratu1D_sGjac(p,u)

par = u(p.nu+1:end);
lam = par(1);
c   = 1;
N = par(2);

uu = u(1:p.nu);


T = zeros(size(uu));
for k = 0:(N-1)
    T = T + uu.^k / factorial(k);
end

df = lam*T;

Gu = c*p.mat.K - p.mat.M*spdiags(df,0,p.nu,p.nu);
end
