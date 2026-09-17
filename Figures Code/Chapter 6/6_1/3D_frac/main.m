close all; keep pphome;
addpath("3Df\","3Dc\");
%compare bifurcation diagrams

alpha = [0.5, 0.7, 0.9];
%generate bifurcation diagrams for all alpha
lx=1;   % [0,1]
nx=20; %h
laminit = 0;
parentdir = 'alpruns';
if ~exist(parentdir,'dir')
    mkdir(parentdir);
end

%% cont loop

for i=1:length(alpha)
    p=[];
    
    p = bratu3Df_init(p, 0.5*lx,nx,laminit, alpha(i));

    % give every continuation its own branch folder
    branchname = fullfile(parentdir,sprintf('p%d',i));
    p = setfn(p,branchname);
    

    p = cont(p, 3000);
    clear p
end

%%cont classical
branchname = fullfile(parentdir,sprintf('q'));
q=[];
q=bratu3D_init(q,0.5*lx,nx,laminit);
q= setfn(q,branchname);
q = cont(q, 3000);
%% plot TOP LEFT
% calculate phi_1
lx=1;
nx=20;
laminit=0;
h = lx/nx;
p=[];
p = bratu3D_init(p, 0.5*lx, nx, laminit);
close all;
xy = p.pdeo.grid.p;
x = xy(1,:)';
y = xy(2,:)';
z = xy(3,:)';
phi1 = cos(pi*x).*cos(pi*y).*cos(pi*z);
phi1 = phi1/norm(phi1);
%becomes cosine due to x=y=[-0.5,0.5]
%instead of [0,1]
[~,M,~] = p.pdeo.fem.assema(p.pdeo.grid,0,1,0);



branchname = fullfile(parentdir,sprintf('q'));
lightBlue = [0.35, 0.65, 0.90];
darkBlue  = [0.00, 0.10, 0.45];
figure(3);clf(3);
theme(figure(3), "light"); 
set(gcf,'Position',[100 100 1400 900]);
subplot(2,2,1);
hold on;
grid on;
box on;
for i= 1:length(alpha)

    
   
    t = (alpha(i) - min(alpha)) / (max(alpha) - min(alpha));
    cols(i,:) = (1-t)*lightBlue + t*darkBlue;
    name = fullfile(parentdir,sprintf('p%d',i));
    plotbra(name, 3,1,'cl', cols(i,:));
end

% classical curve
plotbra(branchname, 3,1,'cl', 'r');
ylim([0,12]);
xlabel('$\lambda$', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('$\|u\|_{\infty}$', 'Interpreter', 'latex', 'FontSize', 16);
title('3D Fractional Bifurcation Diagram for different values of $\alpha$', 'Interpreter','latex', 'FontSize', 16);
% create normal dummy legend entries
h_frac  = plot(nan, nan, 'Color', lightBlue, 'LineWidth', 2);
h_class = plot(nan, nan, 'r', 'LineWidth', 2);

lgd = legend([h_frac, h_class], ...
    {'Fractional', 'Classical'}, ...
    'Location', 'best');

drawnow;

% hide the original fractional sample by making it white
h_frac.Color = [1 1 1];

% gradient colors
nGrad = 50;

darkBlue = [0.00 0.20 0.60];

grad = [ ...
    linspace(lightBlue(1), darkBlue(1), nGrad)', ...
    linspace(lightBlue(2), darkBlue(2), nGrad)', ...
    linspace(lightBlue(3), darkBlue(3), nGrad)' ];

% get legend position in normalized figure coordinates
lgd.Units = 'normalized';
pos = lgd.Position;

% create transparent axes over legend
axGrad = axes('Position', pos, ...
              'Color', 'none', ...
              'XLim', [0 1], ...
              'YLim', [0 1], ...
              'Visible', 'off');

hold(axGrad, 'on');

% approximate location of first legend line
x1 = 0.04;
x2 = 0.32;
y  = 0.72;

% draw gradient line
x = linspace(x1, x2, nGrad+1);

for k = 1:nGrad
    plot(axGrad, x(k:k+1), [y y], ...
        'Color', grad(k,:), ...
        'LineWidth', 2);
end

% keep overlay above main axes
uistack(axGrad, 'top');


% plot BOTTOM LEFT AND TOP RIGHT
subplot(2,2,3);
hold on;
grid on;
box on;




% calculate D1

files = dir(fullfile(branchname,'pt*.mat'));

% Sort pt files numerically
ptNumbers = zeros(length(files),1);

for k = 1:length(files)
    ptNumbers(k) = sscanf(files(k).name,'pt%d.mat');
end

[~,order] = sort(ptNumbers);
files = files(order);
D1= [];
uinft =[];
lams=[];
for i = 1:length(files)

    fname = fullfile(branchname,files(i).name);
    S = load(fname);
    p = S.p;

    u = p.u(1:p.nu);

    denom = (u' * M * u) * (phi1' * M * phi1);

    if denom > 1e-10
        D1 = [D1, (u' * M * phi1)^2 / denom];
        uinft = [uinft max(abs(u))]; 
        lams = [lams p.u(end)];
    end

end

%now with D1, lams and uinft we can plot top right and bottom left
%use p2p sim
const = (3*pi^2).^(alpha -1);
for i=1:length(alpha)
    hold on;
    plot(const(i).*lams, uinft, 'Color', cols(i,:));
end
plot(lams, uinft, 'Color','r');
ylim([0,12]);
xlim([0,10.1]);
xlabel('$\lambda$', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('$\|u\|_{\infty}$', 'Interpreter', 'latex', 'FontSize', 16);
title('Approximated Bifurcation Diagrams for different values of $\alpha$', 'Interpreter','latex', 'FontSize', 16);
% create normal dummy legend entries
h_frac  = plot(nan, nan, 'Color', lightBlue, 'LineWidth', 2);
h_class = plot(nan, nan, 'r', 'LineWidth', 2);

lgd = legend([h_frac, h_class], ...
    {'Fractional Estimate', 'Classical'}, ...
    'Location', 'best');

drawnow;

% hide the original fractional sample by making it white
h_frac.Color = [1 1 1];

% gradient colors
nGrad = 50;

darkBlue = [0.00 0.20 0.60];

grad = [ ...
    linspace(lightBlue(1), darkBlue(1), nGrad)', ...
    linspace(lightBlue(2), darkBlue(2), nGrad)', ...
    linspace(lightBlue(3), darkBlue(3), nGrad)' ];

% get legend position in normalized figure coordinates
lgd.Units = 'normalized';
pos = lgd.Position;

% create transparent axes over legend
axGrad = axes('Position', pos, ...
              'Color', 'none', ...
              'XLim', [0 1], ...
              'YLim', [0 1], ...
              'Visible', 'off');

hold(axGrad, 'on');

% approximate location of first legend line
x1 = 0.04;
x2 = 0.32;
y  = 0.72;

% draw gradient line
x = linspace(x1, x2, nGrad+1);

for k = 1:nGrad
    plot(axGrad, x(k:k+1), [y y], ...
        'Color', grad(k,:), ...
        'LineWidth', 2);
end

% keep overlay above main axes
uistack(axGrad, 'top');


% top right
subplot(2,2,2);
grid on;
plot(uinft, D1, "color", 'r');
xlabel('$\|u\|_{\infty}$', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('$D_1$', 'Interpreter', 'latex', 'FontSize', 16);
title('$D_1$ for all Solutions on the Classical 3D Bifurcation Curve', 'Interpreter','latex', 'FontSize', 16);
xlim([0,12]);

% bottom right
subplot(2,2,4);
hold on;
grid on;
box on;

for j = 1:length(alpha)

    % again sorting the pt files
    branchname_frac = fullfile(parentdir,sprintf('p%d',j));
    files = dir(fullfile(branchname_frac,'pt*.mat'));

    ptNumbers = zeros(length(files),1);

    for k = 1:length(files)
        ptNumbers(k) = sscanf(files(k).name,'pt%d.mat');
    end

    [~,order] = sort(ptNumbers);
    files = files(order);

    % want to store the bifurcation data
    uinf_p2p = [];
    lam_p2p  = [];

    % extract fractional PDE2PATH data
    for k = 1:length(files)

        fname = fullfile(branchname_frac,files(k).name);
        S = load(fname);
        p = S.p;

        u = p.u(1:p.nu);

        uinf_p2p(end+1) = max(abs(u));
        lam_p2p(end+1)  = p.u(end);
    end


    % calculate approximation from classical PDE2PATH branch
    scaling = (2*pi^2)^(alpha(j)-1);

    % interpolate classical lambda at same ||u||_inf values
    lam_class = interp1(uinft, lams, uinf_p2p, 'pchip', NaN);

    lam_approx = scaling .* lam_class;


    % normalized by numerical critical lambda
    lam_c = max(lam_p2p);

    err = abs(lam_p2p - lam_approx) ./ lam_c;

    % remove points outside interpolation range
    valid = ~isnan(err);

    % plot as percentage
    plot(uinf_p2p(valid), 100*err(valid), ...
        'Color', cols(j,:), ...
        'LineWidth', 1.5);
end

xlim([0,12]);

xlabel('$\|u\|_{\infty}$', ...
    'Interpreter','latex', 'FontSize',16);

ylabel('Error$\ [\%]$', ...
    'Interpreter','latex', 'FontSize',16);

title('Error of the First-Mode Approximation', ...
    'Interpreter','latex', 'FontSize',16);

%% D1 crit

% Index of maximum D1
[D1_max, idx_D1] = max(D1);

% Index of fold (= maximum lamsbda)
[lams_fold, idx_fold] = max(lams);

fprintf('\n--- D1 maximum vs fold ---\n');

fprintf('Maximum D1:\n');
fprintf('  D1        = %.12f\n', D1_max);
fprintf('  lamsbda    = %.12f\n', lams(idx_D1));
fprintf('  ||u||_inf = %.12f\n', uinft(idx_D1));
fprintf('  point     = %d\n', idx_D1);

fprintf('\nFold:\n');
fprintf('  D1        = %.12f\n', D1(idx_fold));
fprintf('  lamsbda    = %.12f\n', lams_fold);
fprintf('  ||u||_inf = %.12f\n', uinft(idx_fold));
fprintf('  point     = %d\n', idx_fold);

fprintf('\nDifference:\n');
fprintf('  point difference   = %d\n', idx_D1 - idx_fold);
fprintf('  lamsbda difference  = %.4e\n', abs(lams(idx_D1) - lams_fold));
fprintf('  D1 difference      = %.4e\n', abs(D1_max - D1(idx_fold)));

if idx_D1 == idx_fold
    fprintf('\nMaximum D1 occurs at the same saved point as the fold.\n');
else
    fprintf('\nMaximum D1 does NOT occur at the same saved point as the fold.\n');
end