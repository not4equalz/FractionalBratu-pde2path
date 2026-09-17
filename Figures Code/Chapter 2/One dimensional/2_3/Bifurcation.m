close all; keep pphome;
addpath('1D/')
%1. select lambda
%2. Find zeros theta using Newton Raphson
%3. Find max of u
%4. do simulation with pde2path
%5. plot bifurcation diagrams

lambda = linspace(0.01, 3.5138, 400);   %lambda array from 0 to lam_c

%theta initial guesses
theta0 = linspace(0,50,500);

%initialize array to store zeros
allTheta = zeros(length(lambda),length(theta0));

%NR
tol = 1e-4;

%perform NR for each lambda
for k = 1:length(lambda)
    
    theta = theta0;
    for i=1:1e5
        newTheta = theta - (theta-sqrt(2*lambda(k))*cosh(theta/4))./...
            (1-sqrt(lambda(k)/8)*sinh(theta/4));
        
        if max(abs(newTheta-theta)) < tol
            break;
        end
        
        theta = newTheta;
    end
    %store in allTheta, each row is another lambda
    allTheta(k,:) = newTheta;

end

%filter out unique theta values
theta_pairs = zeros(length(lambda),2);

for k = 1:length(lambda)

    theta_roots = allTheta(k,:);

    theta_roots = theta_roots(isfinite(theta_roots));    
    theta_roots = real(theta_roots);                
    theta_roots = theta_roots(theta_roots >= 0);           
    theta_roots = round(theta_roots,10);             
    theta_roots = unique(round(theta_roots,5));    

    theta_pairs(k,:) = theta_roots(1:2);

end

%% pde2path simulation
% ask user whether to run pde2path simulation
answer = input('Run pde2path simulation and (re)generate data? [y/n]: ', 's');
if isempty(answer)
    answer = 'n';
end
answer = lower(answer(1));
if answer == 'y'
    bratu1D_cmds
end
close all;

%% plot bifurcation diagrams and calculate errors
figure(1);
clf
theme(figure(1), "light"); 

% common axis settings
x_limits = [0, 3.6];
y_limits = [0, 8];
axFontSize = 14;

tiledlayout(1,3);

%plot NR branches (LEFT)
ax1 = nexttile;
hold on;

%error calculation
yNR1 = 2*log(cosh(theta_pairs(:,1)/4));
yNR2 = 2*log(cosh(theta_pairs(:,2)/4));

yNRerr1 = abs(lambda  - lamfunc(yNR1'));
yNRerr2 = abs(lambda  - lamfunc(yNR2'));
%MAX ERROR NR SIM
yNRerr = max(max(yNRerr1), max(yNRerr2));
fprintf('Maximum error in NR solution: %g\n', yNRerr);

% maximum norm is same as u(1/2) = 2log(cosh(theta/4))
h1 = plot(lambda, yNR1, 'r', 'LineWidth', 1.5);
h2 = plot(lambda, yNR2, 'b', 'LineWidth', 1.5);



legend([h1 h2], {'Lower Solution','Upper solution'}, 'Location', 'northeast');

xlabel('$\lambda$', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('$\|u\|_{\infty}$', 'Interpreter', 'latex', 'FontSize', 16);
xlim(x_limits);
ylim(y_limits);
title('Newton-Raphson branches','FontSize',14);

grid on;
box on;
set(ax1,'FontSize',axFontSize);

%plot pde2path solution (RIGHT)
ax2 = nexttile;
hold on;
plotbra('p',1,1,'cl','k','lw',2)
xlabel('$\lambda$', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('$\|u\|_{\infty}$', 'Interpreter', 'latex', 'FontSize', 16);
xlim(x_limits);
ylim(y_limits);
title('pde2path solution','FontSize',14);

grid on;
box on;
set(ax2,'FontSize',axFontSize);

%% find error
[lam,umax] =extract_p2p_data(); 
yP2Perr = max(abs(lam-lamfunc(umax)));
fprintf('Maximum error in P2P solution: %g\n', yP2Perr);

%% exact arsech solution (RIGHT)
ax2 = nexttile;
hold on;
x = linspace(0,8, 1000);
y = lamfunc(x);
plot(y,x, 'Color','r');
xlabel('$\lambda$', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('$\|u\|_{\infty}$', 'Interpreter', 'latex', 'FontSize', 16);
xlim(x_limits);
ylim(y_limits);
title('Exact solution','FontSize',14);

grid on;
box on;
set(ax2,'FontSize',axFontSize);

sgtitle("Bifurcation diagram of 1D Bratu equation" ,'FontSize', 15);