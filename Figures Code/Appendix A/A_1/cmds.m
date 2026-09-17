close all; keep pphome;
%% Initialization
nx = 100; %is N-1 i.e. the number of intervals
lx=1;   %length of the interval [-lx/2, lx/2]
laminit = 0;        %initial lambda
% Initialize Problem
p=[];
p = bratu1D_init(p, 0.5*lx, nx, laminit);
%% Continuation
p = cont(p, 900); %for at most 900 points
%% bifurcation diagram plot
figure(3); clf(3);
plotbra('p',3,1,'cl','r');
xlabel('\lambda'); ylabel('max(u)');