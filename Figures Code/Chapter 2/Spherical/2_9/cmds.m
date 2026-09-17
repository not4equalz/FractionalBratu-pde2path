close all; keep pphome;
%% Initialization
nx = 100;          % number of radial intervals
R = 1;             % radius of the ball
laminit = 0.02;      % initial lambda

% Initialize radially symmetric problems
p1=[];
p1 = bratu1D_init(p1,R,nx,laminit,1);

p2 =[];
p2 = bratu1D_init(p2,R,nx,laminit,2);

p3=[];
p3 = bratu1D_init(p3,R,nx,laminit,3);

p4=[];
p4 = bratu1D_init(p4,R,150,laminit,10);




%% Continuation
p1 = cont(p1, 5000);
p2 = cont(p2, 5000);
p3 = cont(p3, 5000);
p4 = cont(p4, 5000);

%% Bifurcation diagram



figure(3); clf(3);
theme(figure(3), "light");
subplot(2,2,1);
plotbra('p1',3,1,'cl','k');
xlabel('\lambda'); ylabel('max(u)');
title('d=1');

subplot(2,2,2);
plotbra('p2',3,1,'cl','k');
xlabel('\lambda'); ylabel('max(u)');
title('d=2');

subplot(2,2,3);
plotbra('p3',3,1,'cl','k');
xlabel('\lambda'); ylabel('max(u)');
title('d=3');

subplot(2,2,4);
plotbra('p4',3,1,'cl','k');
xlabel('\lambda'); ylabel('max(u)');
title('d=10');
sgtitle('Bifurcation diagrams of GB models on ball domain')
