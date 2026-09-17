close all; keep pphome;
addpath("truncated1D/");
%% Generate bifurcation diagrams for odd truncation T 
T = 2;
nx=300;
%generate 4 branches with different wave numbers
%use evenly spaced grid of 200 points
% T=3 by default
% change parameters inside cmds file
%% pde2path simulation
% ask user whether to run pde2path simulation
answer = input('Run pde2path simulation and (re)generate data? [y/n]: ', 's');
if isempty(answer)
    answer = 'n';
end
answer = lower(answer(1));
if answer == 'y'
    % this depends on T
    bratu1D_cmds(T, nx);
end
close all;
%this cell can be buggy, close all might not work.
%data should be saved, so rerun the script and input n
%% plot bifurcation diagram
figure(3);clf;


%other branches (only for odd T)
if mod(T,2)==1
    %main branch
plotbra('p',3,1,'cl','k','lw',2);
hold on;
% dark blue -> light blue
cols = [
    0.00 0.00 0.35
    0.00 0.10 0.55
    0.00 0.25 0.75
    0.00 0.45 0.90
    0 0.65 1.00
    0 0.85 1.00
];

kvals = [3 5 7 9 11 13];

for i = 1:6
    plotbra(sprintf('q%d',i),3,1,'cl',cols(i,:),'lw',2);
end

% dummy handles for correct legend colors
hLeg = gobjects(1,7);

hLeg(1) = plot(NaN,NaN,'k-','LineWidth',2);

for i = 1:6
    hLeg(i+1) = plot(NaN,NaN,'-','Color',cols(i,:),'LineWidth',2);
end

legendLabels = [{'Main branch'}, ...
    arrayfun(@(k) sprintf('Branch $k=%d$',k), kvals, 'UniformOutput', false)];

legend(hLeg, legendLabels, ...
       'Interpreter','latex', ...
       'FontSize',13, ...
       'Location','best');
else
plotbra('w',3,1,'cl','k','lw',2);
end
xlabel('$\lambda$', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('$\|u\|_{\infty}$', 'Interpreter', 'latex', 'FontSize', 16);
grid on;
box on;
theme(figure(3), "light"); 
sgtitle(sprintf('Bifurcation diagram of 1D Bratu equation with truncation depth $K = %d$', T), ...
        'Interpreter','latex','FontSize',15);