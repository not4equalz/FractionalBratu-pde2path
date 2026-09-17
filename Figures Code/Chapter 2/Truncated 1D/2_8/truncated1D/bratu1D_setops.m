function p=bratu1D_setops(p)

[K,~,~] = p.pdeo.fem.assema(p.pdeo.grid,1,0,0);


[~,M,~] = p.pdeo.fem.assema(p.pdeo.grid,0,1,0);

p.mat.K = K;
p.mat.M = M;


ssc = 1e6;       
bd  = [1 p.np];         
p.mat.K(bd,bd) = p.mat.K(bd,bd) + ssc*speye(2);
end
