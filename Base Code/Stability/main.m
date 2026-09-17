%run pde2path and determine stable solutions

%% pde2path simulation
% ask user whether to run pde2path simulation (needed only once)
% change parameters inside 3D/bratu_cmds
answer = input('Run pde2path simulation and (re)generate data? [y/n]: ', 's');
if isempty(answer)
    answer = 'n';
end
answer = lower(answer(1));
if answer == 'y'
    cmds
end
close all;

%% stability

[stabilities, paramvals, normvals] = folderstability('p');


%% dotplot
%plot bifurcation diagram red if unstable and green if stable in dots

% Stable when largest eigenvalue is negative
stable   = stabilities == 1;
unstable = stabilities == 0;

figure;

plot(paramvals(stable), ...
     normvals(stable), ...
     'g.', ...
     'MarkerSize',14);

hold on;

plot(paramvals(unstable), ...
     normvals(unstable), ...
     'r.', ...
     'MarkerSize',14);

xlabel('$\lambda$', ...
    'Interpreter','latex', ...
    'FontSize',16);

ylabel('$\|u\|_{\infty}$', ...
    'Interpreter','latex', ...
    'FontSize',16);

legend( ...
    {'Stable','Unstable'}, ...
    'Location','best');

title('Stability of solution branch');

grid on;