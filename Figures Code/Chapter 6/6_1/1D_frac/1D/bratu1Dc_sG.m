function r = bratu1Dc_sG(p,u)
% Residual G(u,lam) of the model

%optain parameters and set lambda to be the first one
par = u(p.nu+1:end);
lam = par(1);

%obtain values of u
uu = u(1:p.nu);

% compute G(u,lam)
r = p.mat.K*uu - p.mat.M*(lam*exp(uu));
end
