function p=bratu2D_setops(p)
% assemble the FEM matrices K and M

% Built into pde2path
[K,~,~] = p.pdeo.fem.assema(p.pdeo.grid,1,0,0);
[~,M,~] = p.pdeo.fem.assema(p.pdeo.grid,0,1,0);

% assign matrices to the object
p.mat.K = K;
p.mat.M = M;

% Dirichlet boundary conditions by stiff spring constant
ssc = 1e6;              


%obtain grid
xy = p.pdeo.grid.p;
x = xy(1,:)';
y = xy(2,:)';

xmin = min(x); xmax = max(x);
ymin = min(y); ymax = max(y);
tol=1e-10;


%Find boundary nodes
bd = find(abs(x-xmin) < tol | abs(x-xmax) < tol | ...
          abs(y-ymin) < tol | abs(y-ymax) < tol);

% apply stiff-spring penalty
p.mat.K(bd,bd) = p.mat.K(bd,bd) + ssc*speye(length(bd));
end
