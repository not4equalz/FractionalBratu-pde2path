function p=bratu_setops_rad(p)
% assemble the radial FEM matrices K and M

% radial coordinate
r = p.pdeo.grid.p(1,:)';

% radial weight for a d-dimensional ball
w = r.^(p.d-1);

% Built into pde2path
[K,~,~] = p.pdeo.fem.assema(p.pdeo.grid,w,0,0);
[~,M,~] = p.pdeo.fem.assema(p.pdeo.grid,0,w,0);

% assign matrices to the object
p.mat.K = K;
p.mat.M = M;

% Dirichlet boundary condition at r = R
% No Dirichlet condition at r = 0:
% u_r(R)=0 is the natural boundary condition
ssc = 1e6;              % stiff-spring constant
bd  = p.np;             % outer boundary node only

p.mat.K(bd,bd) = p.mat.K(bd,bd) + ssc;

end