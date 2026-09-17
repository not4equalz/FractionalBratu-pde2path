function r = bratu1D_sG(p,u)


par = u(p.nu+1:end);
lam = par(1);
c   = 1;
N = par(2);



uu = u(1:p.nu);
%truncated part
T = zeros(size(uu));
for k = 0:N
    T = T + uu.^k / factorial(k);
end

r = c*(p.mat.K*uu) - p.mat.M*(lam*T);
end
