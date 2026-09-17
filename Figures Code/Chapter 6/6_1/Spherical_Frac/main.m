close all; keep pphome;
addpath("Sphericalf\");
addpath("Spherical\");
%compare bifurcation diagrams

alpha = 0.5:0.05:0.95;
%generate bifurcation diagrams for all alpha
R=1;   % [0,1]
nx=100; %dx
laminit = 0;
d=3;
parentdir = 'alpruns';
if ~exist(parentdir,'dir')
    mkdir(parentdir);
end

%% cont loop

for i=1:length(alpha)
    p=[];
    
    p = bratu1Df_init(p, R,nx,laminit, d,alpha(i));

    % give every continuation its own branch folder
    branchname = fullfile(parentdir,sprintf('p%d',i));
    p = setfn(p,branchname);
    

    p = cont(p, 2000);
    clear p
end

%% cont classical
branchname = fullfile(parentdir,sprintf('q'));
q=[];
q=bratu1D_init(q,R,nx,laminit, d);
q= setfn(q,branchname);
q = cont(q, 2000);
%% plot
branchname = fullfile(parentdir,sprintf('q'));
lightBlue = [0.35, 0.65, 0.90];
darkBlue  = [0.00, 0.10, 0.45];
figure(3);clf(3);
theme(figure(3), "light"); 
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
title('Fractional Bifurcation Diagrams for different values of $\alpha$ on Ball Domain with $d=3$', 'Interpreter','latex', 'FontSize', 16);
% create normal dummy legend entries
h_frac  = plot(nan, nan, 'Color', lightBlue, 'LineWidth', 2);
h_class = plot(nan, nan, 'r', 'LineWidth', 2);

lgd = legend([h_frac, h_class], ...
    {'fractional', 'classical'}, ...
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



