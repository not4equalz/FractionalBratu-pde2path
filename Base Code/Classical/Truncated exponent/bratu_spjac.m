function Glam = bratu_spjac(p,u)
%obtain values of u
uu = u(1:p.nu);
par = u(p.nu+1:end);
M = par(2);
T = zeros(size(uu));
for k = 0:M
    T = T + uu.^k / factorial(k);
end

% compute dG/dlam 

Glam = - p.mat.M*(T);
end
