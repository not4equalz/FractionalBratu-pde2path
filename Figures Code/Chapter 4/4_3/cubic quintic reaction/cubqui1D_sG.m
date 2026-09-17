function r = cubqui1D_sG(p,u)
% Residual G(u,lam) of the model

%optain parameters and set lambda to be the first one
par = u(p.nu+1:end);
lam = par(1);

%obtain values of u
uu = u(1:p.nu);

cubqui = uu + uu.^3 -uu.^5;

% compute G(u,lam)
r = p.mat.K*uu - p.mat.M*(lam*cubqui);
end
