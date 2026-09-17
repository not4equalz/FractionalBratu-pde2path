function p=bratu3D_setops(p)
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
xyz = p.pdeo.grid.p;
x = xyz(1,:)';
y = xyz(2,:)';
z = xyz(3,:)';

xmin = min(x); xmax = max(x);
ymin = min(y); ymax = max(y);
zmin = min(z); zmax = max(z);
tol=1e-10;


%Find boundary nodes
bd = find(abs(x-xmin) < tol | abs(x-xmax) < tol | ...
          abs(y-ymin) < tol | abs(y-ymax) < tol | ...
          abs(z-zmin) < tol | abs(z-zmax) < tol);

% apply stiff-spring penalty
p.mat.K(bd,bd) = p.mat.K(bd,bd) + ssc*speye(length(bd));
end
