%% Bratu model
close all; keep pphome; 
%% Homogeneous solution branch
nx = 100;
p=[]; p=bratu_init(p,0.5,0.5,nx);

tic;
p=cont(p, 500);  
TIME = toc;
