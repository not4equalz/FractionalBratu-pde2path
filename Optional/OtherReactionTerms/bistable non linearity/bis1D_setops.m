function p=bis1D_setops(p)
% assemble the FEM matrices K and M

% Built into pde2path
[K,~,~] = p.pdeo.fem.assema(p.pdeo.grid,1,0,0);
[~,M,~] = p.pdeo.fem.assema(p.pdeo.grid,0,1,0);

% assign matrices to the object
p.mat.K = K;
p.mat.M = M;

% Dirichlet boundary conditions by stiff spring constant
ssc = 1e6;              % stiff-spring constant
bd  = [1 p.np];         % endpoint node indices 
p.mat.K(bd,bd) = p.mat.K(bd,bd) + ssc*speye(2);
end
