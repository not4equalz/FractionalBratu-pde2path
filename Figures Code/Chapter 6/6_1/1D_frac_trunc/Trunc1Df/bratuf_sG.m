function r = bratuf_sG(p,u)
% Residual G(u,lam) of the model

%optain parameters and set lambda to be the first one
par = u(p.nu+1:end);
lam = par(1);
M = par(2);
%obtain values of u
uu = u(1:p.nu);

T = zeros(size(uu));
for k = 0:M
    T = T + uu.^k / factorial(k);
end
% compute G(u,lam)
r = -p.mat.M*(p.mat.Kalpha*uu)- p.mat.M*(lam*T);
end
