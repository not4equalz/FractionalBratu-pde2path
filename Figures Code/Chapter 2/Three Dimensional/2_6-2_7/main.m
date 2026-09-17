close all; keep pphome;
addpath("3D\");
%3D plots -> Isosurface and Bifurcation diagram 


%% pde2path simulation
% ask user whether to run pde2path simulation (needed only once)
% change parameters inside 3D/bratu_cmds
answer = input('Run pde2path simulation and (re)generate data? [y/n]: ', 's');
if isempty(answer)
    answer = 'n';
end
answer = lower(answer(1));
if answer == 'y'
    bratu3D_cmds
end
close all;


%% Draw Bifurcation diagram
figure(1); clf;
plotbra('q',1,1,'cl','k'); xlabel('\lambda'); ylabel('max(u)');
xlabel('$\lambda$', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('$\|u\|_{\infty}$', 'Interpreter', 'latex', 'FontSize', 16);
ylim([0 18]);
grid on;
box on;
theme(figure(1), "light"); 
sgtitle("Bifurcation diagram of 3D Bratu equation" ,'FontSize', 15);

%% Draw iso-surfaces
% given lambda value between 0 and lam_c \approx 9.9
iso_val = 0.30;
lambda_target = 4.42;
%pde2path doesnt work on set values of lambda, 
% so try to find the closest one -> tol
tol = 0.011; 

%first need to find the .mat files where |lam-lam_target| < tol
folder = 'q';  
files = dir(fullfile(folder,'pt*.mat'));
fprintf('Searching for lambda ≈ %.6f (tol = %.6f)\n\n', lambda_target, tol);
matched_files = {};
umaxs=[];
for k = 1:length(files)

    fname = fullfile(folder,files(k).name);
    S = load(fname);
    p = S.p;

    u = p.u(1:p.nu);                 % solution
    lambda = p.u(p.nu + 1);          % parameter

    if abs(lambda - lambda_target) <= tol
        umax = max(abs(u));
        umaxs(end+1) = umax;
        fprintf('%s  ->  lambda = %.6f,  max|u| = %.6f  (MATCH)\n', ...
            files(k).name, lambda, umax);

        matched_files{end+1} = fname;   % store path
    end
end

% now need to draw the plots 

nplots = length(matched_files);
figure(2); clf;
theme(figure(2), "light");
set(gcf,'Position',[100 100 1400 450]);

% colors per subplot
colors = lines(nplots);

for k = 1:nplots
    S = load(fullfile(matched_files{k}));
    p = S.p;

    uN = p.u(1:p.nu);
    P = p.pdeo.grid.p;
    x = P(1,:)'; 
    y = P(2,:)'; 
    z = P(3,:)';

    % grid
    ng = 50;
    xv = linspace(min(x), max(x), ng);
    yv = linspace(min(y), max(y), ng);
    zv = linspace(min(z), max(z), ng);
    [X,Y,Z] = meshgrid(xv,yv,zv);

    % interpolation to regular grid
    F = scatteredInterpolant(x,y,z,uN,'natural','none');
    U = F(X,Y,Z);

    subplot(1,nplots,k)
    hold on

    %multiple iso-levels near iso_value
    iso_levels = [0.5 1 1.5] * iso_val;

    for j = 1:length(iso_levels)
        h = patch(isosurface(xv, yv, zv, U, iso_levels(j)));
        isonormals(xv, yv, zv, U, h);

        h.EdgeColor = 'none';
        h.FaceColor = colors(k,:);     
        h.FaceAlpha = 0.2 + 0.2*j;     
    end

    xlim([-0.5 0.5]);
    ylim([-0.5 0.5]);
    zlim([-0.5 0.5]);
    daspect([1 1 1]);
    view(3);
    camlight;
    lighting gouraud;

    xlabel('$x$', 'Interpreter', 'latex', 'FontSize', 16);
    ylabel('$y$', 'Interpreter', 'latex', 'FontSize', 16);
    zlabel('$z$', 'Interpreter', 'latex', 'FontSize', 16);

    lambda = p.u(p.nu+1);
    title(sprintf('$\\lambda = %.4f,\\ \\|u\\|_{\\infty}=%.4f$', lambda, umaxs(k)), ...
        'Interpreter', 'latex', 'FontSize', 14);

    fprintf('plot %d done\n', k);
end

sgtitle(sprintf('Iso-surfaces of 3D Bratu equation (c = %.4f)', iso_val), ...
    'FontSize', 15);