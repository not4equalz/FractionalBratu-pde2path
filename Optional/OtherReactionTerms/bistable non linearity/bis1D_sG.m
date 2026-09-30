function r = bis1D_sG(p,u)
% Residual G(u,lam) of the model

%optain parameters and set lambda to be the first one
par = u(p.nu+1:end);
lam = par(1);

%obtain values of u
uu = u(1:p.nu);

bis = uu.*(uu - 1/4).*(1-uu);

% compute G(u,lam)
r = p.mat.K*uu - p.mat.M*(lam*bis);
end
