close all; keep pphome;
addpath("1Df\", "1D\");
%compare bifurcation diagrams

alpha = 0.5:0.05:0.95;
%generate bifurcation diagrams for all alpha
lx=1;   % [0,1]
nx=100; %h
laminit = 0;
p = cell(length(alpha),1);
%% cont loop

%frac
for i=1:length(alpha)
    p{i}=[];
    p{i} = bratu1D_init(p{i}, 0.5*lx,nx,laminit, alpha(i));

    % give every continuation its own branch folder
    branchname = sprintf('p%d', i);
    p{i} = setfn(p{i}, branchname);


    p{i} = cont(p{i}, 900);
end
clear p;
%classic
p=[];
p = bratu1Dc_init(p, 0.5*lx, nx, laminit);
p = cont(p,2000);
close all; keep pphome h;


%% PLOTS SECTION
figure(3); clf(3);
theme(figure(3), "light");
set(gcf,'Position',[100 100 1400 900]);

% plot TOP LEFT
lightBlue = [0.35, 0.65, 0.90];
darkBlue  = [0.00, 0.10, 0.45];
subplot(2,2,1);
hold on;
grid on;
box on;
for i= 1:length(alpha)

    
   
    t = (alpha(i) - min(alpha)) / (max(alpha) - min(alpha));
    cols(i,:) = (1-t)*lightBlue + t*darkBlue;
    name = sprintf('p%d', i);
    plotbra(name, 3,1,'cl', cols(i,:))
end

%exact classical curve
x= linspace(0, 12, 1000);
y=8*((asech(exp(-x/2))).^2).*exp(-x);
plot(y,x, 'Color', "r")
ylim([0,12]);
xlabel('$\lambda$', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('$\|u\|_{\infty}$', 'Interpreter', 'latex', 'FontSize', 16);
title('1D Fractional Bifurcation Diagram for different values of $\alpha$', 'Interpreter','latex', 'FontSize', 16);
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



% PLOT BOTTOM LEFT
subplot(2,2,3);
hold on;
grid on;
box on;

%exact classical curves
x= linspace(0, 12, 1000);
const = pi.^(2*(alpha -1));
y= 8*((asech(exp(-x/2))).^2).*exp(-x);
for i=1:10
    plot(const(i).*y, x, 'Color', cols(i,:))
end
plot(y,x, 'Color', "r")
ylim([0,12]);
xlim([0,3.52]);
xlabel('$\lambda$', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('$\|u\|_{\infty}$', 'Interpreter', 'latex', 'FontSize', 16);
title('Approximated Bifurcation Diagrams for different values of $\alpha$', 'Interpreter','latex', 'FontSize', 16);
% create normal dummy legend entries
h_frac  = plot(nan, nan, 'Color', lightBlue, 'LineWidth', 2);
h_class = plot(nan, nan, 'r', 'LineWidth', 2);

lgd = legend([h_frac, h_class], ...
    {'Fractional estimate', 'Classical'}, ...
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

% Top right
%calc phi1
h = lx/nx;
x = 0:h:1;
x = x';
phi1 = sin(pi*x);
phi1 = phi1 / norm(phi1);
phi1=phi1';

% calculate D1

files = dir(fullfile('p','pt*.mat'));

% Sort pt files numerically
ptNumbers = zeros(length(files),1);

for k = 1:length(files)
    ptNumbers(k) = sscanf(files(k).name,'pt%d.mat');
end

[~,order] = sort(ptNumbers);
files = files(order);
D1= [];
uinf =[];
lam=[];
for i = 1:length(files)

    fname = fullfile('p',files(i).name);
    S = load(fname);
    p = S.p;

    u = p.u(1:p.nu);

    denom = dot(u,u);

    if denom > 1e-10
        D1 = [D1 dot(u,phi1)^2 / denom];
        uinf = [uinf max(abs(u))];
        lam = [lam p.u(p.nu+1)];
    end

end
subplot(2,2,2);

grid on;
plot(uinf, D1, "color", 'r');
xlabel('$\|u\|_{\infty}$','Interpreter', 'latex', 'FontSize', 16);
ylabel('$D_1$', 'Interpreter', 'latex', 'FontSize', 16);
title('$D_1$ for all Solutions on the Classical 1D Bifurcation Curve', 'Interpreter','latex', 'FontSize', 16);
xlim([0,12]);
% BOTTOM RIGHT PLOT error calc
subplot(2,2,4);
hold on;
grid on;
box on;

for j = 1:length(alpha)
    %again sorting the pt files
    branchname = sprintf('p%d', j);
    files = dir(fullfile(branchname, 'pt*.mat'));
    ptNumbers = zeros(length(files),1);

    for k = 1:length(files)
        ptNumbers(k) = sscanf(files(k).name,'pt%d.mat');
    end

    [~,order] = sort(ptNumbers);
    files = files(order);

    %want to store the bifurcation data
    uinf_p2p = [];
    lam_p2p  = [];
    % extract data
    for k = 1:length(files)
        fname = fullfile(branchname, files(k).name);
        S = load(fname);
        p = S.p;
        u = p.u(1:p.nu);
        uinf_p2p(end+1) = max(abs(u));
        lam_p2p(end+1) = p.u(p.nu+1);
    end


    % calculate approximation
    lam_class = 8 * asech(exp(-uinf_p2p/2)).^2 .* exp(-uinf_p2p);
    scaling = pi^(2*(alpha(j)-1));
    lam_approx = scaling .* lam_class;


    % normalized by numerical critical lambda
    lam_c = max(lam_p2p);

    err = abs(lam_p2p - lam_approx) ./ lam_c;

    % plot as percentage
    plot(uinf_p2p, 100*err, ...
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

% Index of fold (= maximum lambda)
[lam_fold, idx_fold] = max(lam);

fprintf('\n--- D1 maximum vs fold ---\n');

fprintf('Maximum D1:\n');
fprintf('  D1        = %.12f\n', D1_max);
fprintf('  lambda    = %.12f\n', lam(idx_D1));
fprintf('  ||u||_inf = %.12f\n', uinf(idx_D1));
fprintf('  point     = %d\n', idx_D1);

fprintf('\nFold:\n');
fprintf('  D1        = %.12f\n', D1(idx_fold));
fprintf('  lambda    = %.12f\n', lam_fold);
fprintf('  ||u||_inf = %.12f\n', uinf(idx_fold));
fprintf('  point     = %d\n', idx_fold);

fprintf('\nDifference:\n');
fprintf('  point difference   = %d\n', idx_D1 - idx_fold);
fprintf('  lambda difference  = %.4e\n', abs(lam(idx_D1) - lam_fold));
fprintf('  D1 difference      = %.4e\n', abs(D1_max - D1(idx_fold)));

if idx_D1 == idx_fold
    fprintf('\nMaximum D1 occurs at the same saved point as the fold.\n');
else
    fprintf('\nMaximum D1 does NOT occur at the same saved point as the fold.\n');
end