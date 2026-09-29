%script for K=2 even truncation
%THIS CODE YIELDS NO RESULTS, NO CONVERGENCE
addpath("Trunc1D\", "Trunc1Df\")

%params
alpha = [0.5, 0.7, 0.9];
lx=1;
nx=100;
laminit =0.01;
K=3;
A=1;
d=1;

%run simulations

    %create directory structure
if ~exist('K3','dir')
    mkdir('K3');
end


%% classical DONE
for i=1:2

p=[];
k = 1+(i-1)*2;
if k==1
p=bratu_init(p,0.5*lx,nx, laminit, d, K, k, 1, 1, 0);
else
p=bratu_init(p,0.5*lx,nx, laminit+0.46, d, K, k, 1, 1, 15+25*(k-1)/2);
end

branchname = fullfile(sprintf('K3/p/p%d', i));
p = setfn(p,branchname);
p = cont(p, 1000);
close all;

end


%% fractional


for i=1:length(alpha)
    q=[];
    
    q= bratuf_init(p,0.5*lx,nx, laminit, d, K, 1, 1, 1,0, alpha(i));
    
    bp1 = fullfile('K3', sprintf('q%d',i));
    branchname = fullfile(bp1);
    q = setfn(q,branchname);
    q = cont(q, 600);
    close all;
    
end


%% plot
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
    
    bp1 = fullfile('K3', sprintf('q%d', i));
    branchname = fullfile(bp1);
       
    plotbra(branchname, 3,1,'cl', cols(i,:));
    
    
   
    
end

% classical curve
for i=1:2
    branchname = fullfile(sprintf('K3/p/p%d', i));
    plotbra(branchname, 3,1,'cl', 'r');
end
ylim([0,25]);
xlabel('$\lambda$', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('$\|u\|_{\infty}$', 'Interpreter', 'latex', 'FontSize', 16);
title('1D Fractional Bifurcation Diagram for different values of $\alpha$', 'Interpreter','latex', 'FontSize', 16);
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