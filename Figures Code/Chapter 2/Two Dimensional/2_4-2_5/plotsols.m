addpath('2D/')
% plot solution profiles and/or bifurcation diagram of two dimensional model
% figure 1 contains solutions and figure 3 the bifurcation diagram
% To change simulation settings, go to 2D/bratu_cmds and/or 2D/bratu_init

%% pde2path simulation
% ask user whether to run pde2path simulation
answer = input('Run pde2path simulation and (re)generate data? [y/n]: ', 's');
if isempty(answer)
    answer = 'n';
end
answer = lower(answer(1));
if answer == 'y'
    bratu_cmds
end
close all;

%if you want the exact figures as in the thesis, change the settings
%in bratu_init.m, because different settings were used for the two figures
%then afterward, rerun the simulation

%% plot solution profiles
%list of saved points
files = {'p/pt5.mat','p/pt120.mat','p/pt280.mat'};

%first find global min and max over all three solutions
umin = inf;
umax = -inf;

for i = 1:3
    S = load(files{i});
    p = S.p;
    u = p.u(1:p.np);

    umin = min(umin,min(u));
    umax = max(umax,max(u));
end

%make figure with better layout
figure; clf;
tlo = tiledlayout(1,3,'TileSpacing','compact','Padding','compact');

for i = 1:3
    %load saved point
    S = load(files{i});
    p = S.p;

    %solution values
    u = p.u(1:p.np);

    %mesh data from saved point
    po = p.mesh.p;          % node coordinates, size 2 x np
    t  = p.mesh.t(1:3,:);   % triangle connectivity

    %parameter value
    lambda = p.u(p.nu+1);   % common pde2path trick: parameter appended to u

    %go to next tile
    ax = nexttile;

    %colored surface plot
    trisurf(t', po(1,:)', po(2,:)', u, u, ...
        'FaceColor','interp', ...
        'EdgeColor','none');

    xlabel('$x$', 'Interpreter','latex', 'FontSize',16);
    ylabel('$y$', 'Interpreter','latex', 'FontSize',16);
    zlabel('$u$', 'Interpreter','latex', 'FontSize',16);

    title(sprintf('$u$ with $\\lambda = %.4f$', lambda), ...
    'Interpreter','latex', 'FontSize',16);

    %same colormap and same color scaling for all subplots
    colormap(ax,jet);
    clim(ax,[umin umax]);

    %same view
    view(ax,45,30);

    %keep domain limits consistent
    xlim(ax,[min(po(1,:)) max(po(1,:))]);
    ylim(ax,[min(po(2,:)) max(po(2,:))]);

    %important: do NOT use axis equal here
    axis(ax,'tight');
    pbaspect(ax,[1 1 0.6]);   % controls box shape without making it vertical

    %lighting
    lightangle(ax,90,80);
    lighting(ax,'gouraud');
    material(ax,'dull');
    camlight(ax,'headlight');
end

%one shared colorbar for the tiled layout
cb = colorbar;
cb.Layout.Tile = 'east';
sgtitle("Solution profiles: 2D Bratu equation" ,'FontSize', 15);

theme(figure(1), "light"); 

%% plot bifurcation diagram
figure(3);
plotbra('p',3,1,'cl','k','lw',2)
xlabel('$\lambda$', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('$\|u\|_{\infty}$', 'Interpreter', 'latex', 'FontSize', 16);
grid on;
box on;
theme(figure(3), "light"); 
sgtitle("Bifurcation diagram of 2D Bratu equation" ,'FontSize', 15);