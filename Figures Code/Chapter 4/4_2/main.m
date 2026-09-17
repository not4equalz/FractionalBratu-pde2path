%run stability for 1D,2D,and 3D  and generate subplot
%to do this need to place branches inside working folder 
%working folder contains init files for suppressing outfu warning
keep pphomel; close all;
%% stability

[stabilities1, paramvals1, normvals1] = folderstability('p');
[stabilities2, paramvals2, normvals2] = folderstability('q1');
[stabilities3, paramvals3, normvals3] = folderstability('q2');
[stabilities4, paramvals4, normvals4] = folderstability('q3');
[stabilities5, paramvals5, normvals5] = folderstability('q4');
[stabilities6, paramvals6, normvals6] = folderstability('q5');
[stabilities7, paramvals7, normvals7] = folderstability('q6');

%% dotplot
%plot bifurcation diagram red if unstable and green if stable in dots

% Stable when largest eigenvalue is negative
stable1   = stabilities1 == 1;
unstable1 = stabilities1 == 0;

stable2  = stabilities2 == 1;
unstable2 = stabilities2 == 0;

stable3   = stabilities3 == 1;
unstable3 = stabilities3 == 0;

stable4   = stabilities4 == 1;
unstable4 = stabilities4 == 0;

stable5  = stabilities5 == 1;
unstable5 = stabilities5 == 0;

stable6   = stabilities6 == 1;
unstable6 = stabilities6 == 0;

stable7   = stabilities7 == 1;
unstable7 = stabilities7 == 0;

%% 1D plot
close all; 
figure(3); clf(3);
theme(figure(3), "light");


plot(paramvals1(stable1),normvals1(stable1),'g.','MarkerSize',14);
hold on;
plot(paramvals1(unstable1), normvals1(unstable1),'r.','MarkerSize',14);

plot(paramvals2(stable2),normvals2(stable2),'g.','MarkerSize',14);
plot(paramvals2(unstable2), normvals2(unstable2),'r.','MarkerSize',14);

plot(paramvals3(stable3),normvals3(stable3),'g.','MarkerSize',14);
plot(paramvals3(unstable3), normvals3(unstable3),'r.','MarkerSize',14);

plot(paramvals4(stable4),normvals4(stable4),'g.','MarkerSize',14);
plot(paramvals4(unstable4), normvals4(unstable4),'r.','MarkerSize',14);

plot(paramvals5(stable5),normvals5(stable5),'g.','MarkerSize',14);
plot(paramvals5(unstable5), normvals5(unstable5),'r.','MarkerSize',14);

plot(paramvals6(stable6),normvals6(stable6),'g.','MarkerSize',14);
plot(paramvals6(unstable6), normvals6(unstable6),'r.','MarkerSize',14);

plot(paramvals7(stable7),normvals7(stable7),'g.','MarkerSize',14);
plot(paramvals7(unstable7), normvals7(unstable7),'r.','MarkerSize',14);

xlabel('$\lambda$', ...
    'Interpreter','latex', ...
    'FontSize',16);

ylabel('$\|u\|_{\infty}$', ...
    'Interpreter','latex', ...
    'FontSize',16);

legend( ...
    {'Stable','Unstable'}, ...
    'Location','northeast');

title('Stability of solution branches truncated 1D');

xlim([0,25]);
grid on;



