close all; keep pphome;
%% Initialization
%number of intervals of dx (so this is equal to N-1)
%Recommended to choose even, because the center 
% of the domain will become a node.
nx = 100;

lx=1;   %length of the interval

% Initialize Problem
p=[];
p = bis1D_init(p, 0.5*lx, nx, -10);

q=[];
q = bis1D_init(q, 0.5*lx, nx, 0);

%% Continuation
% Continue for at most 400 points 
tic;
p = cont(p, 100);
q = cont(q,100);
time = toc;

%% bifurcation diagram plot
figure(3); clf(3);
plotbra('p',3,1,'cl','r');
plotbra('q',3,1,'cl','r');
xlabel('\lambda'); ylabel('max(u)');

%% switch to bifurcation point
%p = swibra('p','bpt1','q',0.01);
%p = cont(p,1000);