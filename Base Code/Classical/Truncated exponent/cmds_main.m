addpath("1D\", "2D\", "3D\");

close all; keep pphome;
%% Initialization
%dimension d and truncation depth M
d=2;
K=3;


%number of intervals of dx (so this is equal to N-1)
%Recommended to choose even, because the center 
% of the domain will become a node.
nx = 30;

lx=1;   %length of the interval
laminit = -1;        %initial lambda

% Initialize Problem
p=[];
p = bratu_init(p, 0.5*lx, nx, laminit, d, K,1,1,1,1);

%% Continuation
% Continue for at most 400 points 
tic;
p = cont(p, 900);
time = toc;

%% bifurcation diagram plot
figure(3); clf(3);
plotbra('p',3,1,'cl','r');
xlabel('\lambda'); ylabel('max(u)');