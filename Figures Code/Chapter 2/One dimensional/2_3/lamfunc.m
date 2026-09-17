function lam = lamfunc(x)
lam = 8*((asech(exp(-x/2))).^2).*exp(-x);
end