function stab = stability_cubqui(p)
%Input p as the pde2path struct
%output is either 1 or 0 if stable or not

%% Retrieve information
%retrieve d, N, lambda, h and uInf
d = size(p.pdeo.grid.p, 1);
%be wary the stability argument gets rid of the boundary so N-2 is used
%instead of N
N = round(p.np^(1/d) -2);
h = 1/(N+1);
%number of internal points
Nd = N^d;
par = p.u(p.nu+1:end);
lam = par(1);
%essentially, uInf(k) = u(p.pdeo.grid.p(:,i)) 
uInf = p.u(1:p.nu); 


% Constructing A sparse
%% diagonal elements
% coordinates in phi_inverse ordering
Xphi = zeros(d,Nd);

for m = 1:Nd
    I = phi_inverse(m,d,N);

    % shift due to domain [-0.5,0.5]^d
    Xphi(:,m) = I/(N+1) - 0.5;
end

% match all coordinates to p2p
tol = h/4;

[~,xIp2p] = ismembertol(Xphi.', p.pdeo.grid.p.',tol,'ByRows',true);
% solution values in phi_inverse ordering
uPhi = uInf(xIp2p);

% insert complete diagonal at once
cubquiterm = 1 +3*uPhi.^2 -5*uPhi.^4;

diagA = lam*cubquiterm - 2*d/h^2;

A = spdiags(diagA(:),0,Nd,Nd);

%% off diagonal elements
el = 1/h^2;

for k = 1:d
    indexshift = N^(k-1);
    for m=1:Nd
        %part 1
        ikm = mod(floor((m-1)/indexshift) , N) + 1;
     

        if ikm < N
            n = m + indexshift;
            A(m,n) = el;
        end
        %part 2
        
        if (ikm > 1)
            n = m - indexshift;
            A(m,n) = el;
        end
    end

end
%% Determine max eigenvalue and if negative return stable
maxeig = eigs(A,1,'largestreal');
if maxeig <0
    stab = 1; % stable
else
    stab = 0; % unstable
end

end


%% helper function    
function multiI = phi_inverse(m, d, N)
%phi_inverse for the ordering

%initialize return
multiI = zeros(d, 1);

%loop over k
for k=1:d
    multiI(k) = mod(floor((m-1)/N^(k-1)) , N) + 1;
end
end
