%% Bratu 1D model (Dirichlet u=0 at both ends)
close all;

%% Homogeneous solution branch
nx = 500;
p=[]; p=bratu1D_init(p,0.5,nx);   
tic;
p=cont(p,350);
TIME = toc;
