%run stability for 1D,2D,and 3D  and generate subplot
%to do this need to place branches inside working folder 
%working folder contains init files for suppressing outfu warning

%% stability

[stabilities1, paramvals1, normvals1] = folderstability('1Dmats');
[stabilities2, paramvals2, normvals2] = folderstability('2Dmats');
[stabilities3, paramvals3, normvals3] = folderstability('3Dmats');

%% dotplot
%plot bifurcation diagram red if unstable and green if stable in dots

% Stable when largest eigenvalue is negative
stable1   = stabilities1 == 1;
unstable1 = stabilities1 == 0;

stable2  = stabilities2 == 1;
unstable2 = stabilities2 == 0;

stable3   = stabilities3 == 1;
unstable3 = stabilities3 == 0;

%% 1D plot
close all; 
figure(3); clf(3);
theme(figure(3), "light");

subplot(1,3,1);

plot(paramvals1(stable1), ...
     normvals1(stable1), ...
     'g.', ...
     'MarkerSize',14);

hold on;

plot(paramvals1(unstable1), ...
     normvals1(unstable1), ...
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
    'Location','northeast');

title('Stability of solution branch 1D');

grid on;

% 2D plot
subplot(1,3,2);

plot(paramvals2(stable2), ...
     normvals2(stable2), ...
     'g.', ...
     'MarkerSize',14);

hold on;

plot(paramvals2(unstable2), ...
     normvals2(unstable2), ...
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
    'Location','northeast');

title('Stability of solution branch 2D');

grid on;


%3D plot
subplot(1,3,3);

plot(paramvals3(stable3), ...
     normvals3(stable3), ...
     'g.', ...
     'MarkerSize',14);

hold on;

plot(paramvals3(unstable3), ...
     normvals3(unstable3), ...
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
    'Location','northeast');

title('Stability of solution branch 3D');

grid on;
