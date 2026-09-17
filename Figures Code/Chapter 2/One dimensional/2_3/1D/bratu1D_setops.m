function p=bratu1D_setops(p)
% assemble and store FEM operators for 1D Bratu and impose Dirichlet BC
%
% Uses a stiff-spring enforcement of u=0 at x=-lx and x=+lx
% (end nodes of the 1D grid). This mirrors the 2D recdbc1(...,ssc) idea.

% basic FEM matrices (stiffness K, mass M)
% stiffness K uit c
[K,~,~] = p.pdeo.fem.assema(p.pdeo.grid,1,0,0);

% mass M uit a
[~,M,~] = p.pdeo.fem.assema(p.pdeo.grid,0,1,0);

p.mat.K = K;
p.mat.M = M;

% Dirichlet u=0 at endpoints via penalty on K
ssc = 1e6;             % stiff-spring constant (same order as 2D demo)
bd  = [1 p.np];         % endpoint node indices (1D)
p.mat.K(bd,bd) = p.mat.K(bd,bd) + ssc*speye(2);
end
