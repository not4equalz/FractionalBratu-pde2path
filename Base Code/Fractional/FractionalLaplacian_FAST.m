function Ks = FractionalLaplacian_FAST(K,M,np,h,s)
%set quadrature coefficient and lower/upper bounds
k = -1/log(h);
Np = ceil(pi^2/(4*(1-s)*k^2));
Nm = ceil(pi^2/(4*s*k^2));

coeff = -k*sin(s*pi)/pi;

Ks = zeros(np,np);

for l = -Nm:Np
    alpha = exp(k*l);
    A = alpha*M + K;
    %lsqminnorm is replaced with LU decomposition, matrix is assumed not singular.
    dA = decomposition(A,'lu');
    V = dA\K;
    Ks = Ks + exp(s*k*l)*V;
end

Ks = coeff*Ks;

end