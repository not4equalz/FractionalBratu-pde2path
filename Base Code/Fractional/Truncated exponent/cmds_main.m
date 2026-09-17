addpath("1D\", "2D\", "3D\");

close all; keep pphome;
%% Initialization
%dimension d and truncation depth M
d=3;
M=3;

%fractional order alpha
alpha = 0.75;

%number of intervals of dx (so this is equal to N-1)
%Recommended to choose even, because the center 
% of the domain will become a node.
nx = 6;

lx=1;   %length of the interval
laminit = 0;        %initial lambda

% Initialize Problem
p=[];
p = bratu_init(p, 0.5*lx, nx, laminit, d, M,1,1,1,1, alpha);

%% Continuation
% Continue for at most 400 points 
tic;
p = cont(p, 400);
time = toc;

%% bifurcation diagram plot
figure(3); clf(3);
plotbra('p',3,1,'cl','r');
xlabel('\lambda'); ylabel('max(u)');