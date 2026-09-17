close all; keep pphome;
%% Initialization
nx = 20;          % number of radial intervals
R = 1;             % radius of the ball
d = 3;             % dimension of the original ball
laminit = 3;      % initial lambda

% Initialize radially symmetric problem
p=[];
p = bratu1D_init(p,R,nx,laminit,d);

%% Continuation
tic;
p = cont(p,1400);
time = toc;

%% Bifurcation diagram
figure(3); clf(3);
plotbra('p',3,1,'cl','r');
xlabel('\lambda'); ylabel('max(u)');
