close all; keep pphome;
%% Initialization

%number of intervals of dx (so this is equal to N-1)
%Recommended to choose even, because the center 
% of the domain will become a node.
nx = 32;

lx=1;   %length of the interval
laminit = -1;        %initial lambda

% Initialize Problem
q=[];
%dsmax is very small in this init; for speed, you might want to increase it.
q = bratu3D_init(q, 0.5*lx, nx, laminit);

%% Continuation
% Continue for at most 2000 points 
tic;
q = cont(q, 1115);
time = toc;

%% bifurcation diagram plot
figure(3); clf(3);
plotbra('q',3,1,'cl','r');
xlabel('\lambda'); ylabel('max(u)');