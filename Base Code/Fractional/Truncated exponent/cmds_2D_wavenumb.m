addpath("1D\", "2D\", "3D\");

close all; keep pphome;
%% Initialization
%truncation depth M
M=3;

%fractional order alpha
alpha = 0.75;

%number of intervals of dx (so this is equal to N-1)
%Recommended to choose even, because the center 
% of the domain will become a node.
nx = 100;

lx=1;   %length of the interval
laminit = 1;        %initial lambda

% Initialize Problem
p=[];
p = bratu_init(p, 0.5*lx, nx, laminit, 2, M,5,5,3, 60, alpha);

%% Continuation
% Continue for at most 400 points 
tic;
p = cont(p, 900);
time = toc;

%% bifurcation diagram plot
figure(3); clf(3);
plotbra('p',3,1,'cl','r');
xlabel('\lambda'); ylabel('max(u)');