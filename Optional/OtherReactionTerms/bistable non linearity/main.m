%run stability for 1D,2D,and 3D  and generate subplot
%to do this need to place branches inside working folder 
%working folder contains init files for suppressing outfu warning
keep pphomel; close all;
%% stability

[stabilities1, paramvals1, normvals1] = folderstability('p');
[stabilities2, paramvals2, normvals2] = folderstability('q');


%% dotplot
%plot bifurcation diagram red if unstable and green if stable in dots

% Stable when largest eigenvalue is negative
stable1   = stabilities1 == 1;
unstable1 = stabilities1 == 0;

stable2  = stabilities2 == 1;
unstable2 = stabilities2 == 0;


%% 1D plot
close all; 
figure(3); clf(3);
theme(figure(3), "light");


plot(paramvals1(stable1),normvals1(stable1),'g.','MarkerSize',14);
hold on;
plot(paramvals1(unstable1), normvals1(unstable1),'r.','MarkerSize',14);

plot(paramvals2(stable2),normvals2(stable2),'g.','MarkerSize',14);
plot(paramvals2(unstable2), normvals2(unstable2),'r.','MarkerSize',14);



xlabel('$\lambda$', ...
    'Interpreter','latex', ...
    'FontSize',16);

ylabel('$\|u\|_{\infty}$', ...
    'Interpreter','latex', ...
    'FontSize',16);

legend( ...
    {'Stable','Unstable'}, ...
    'Location','northeast');

title('Stability of solution branches 1D bistable non-linearity reaction');

grid on;



