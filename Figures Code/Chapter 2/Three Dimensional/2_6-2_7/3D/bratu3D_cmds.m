%% Bratu 3D model (Dirichlet u=0 at both ends)
close all; keep pphome;

q = [];
lx = 0.5; 
nx = 26 ; 

q = bratu3D_init(q,lx,nx, 0.2);
tic;
q = cont(q,1100);
TIME = toc;
