close all; keep pphome;
%% Initialization
%number of intervals of dx (so this is equal to N-1)
%Recommended to choose even, because the center 
% of the domain will become a node.
nx = 100;

lx=1;   %length of the interval
laminit = -1;        %initial lambda

% Initialize Problem
p=[];
p = bratu1D_init(p, 0.5*lx, nx, laminit);

%% Continuation
% Continue for at most 400 points 
tic;
p = cont(p, 900);
time = toc;

%% bifurcation diagram plot
figure(3); clf(3);
plotbra('p',3,1,'cl','r');
xlabel('\lambda'); ylabel('max(u)');