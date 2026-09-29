function p=bratuf_init(p,lx,nx, laminit, d, M, k1, k2, k3, A, alpha)
% 1D initialization function for bratu with dirichlet u=0 at endpoints
%domain x in [-lx, lx], grid size h = 2lx/nx

%standard setup
p=stanparam(p); screenlayout(p);

%problem size
p.nc.neq = 1;        %number of PDE components (neq = Number of equations)
p.nc.nq  = 0;        %no auxiliary equations

%function handlers
p.sw.sfem = -1;                 %Allows for manual FEM matrix inclusion
%set function handlers

p.fuha.sG    = @bratuf_sG;     % G(u,lam)
p.fuha.sGjac = @bratuf_sGjac;  % dG/du jacobian
p.fuha.spjac = @bratuf_spjac;  % dG/dlam vector

% output for bifurcation diagram
p.fuha.outfu = @(p,u) max(abs(u(1:p.np))); %functional of u on y axis (max norm)
p.plot.bpcmp = 1; % bifurcation point colormap

% Create symmetric mesh
h = 2*lx/nx;


switch d
    case 1
        p.fuha.setops = @bratu1D_setops;
        p.pdeo = stanpdeo1D(lx,h);
        %initial guess
        x = 0:h:1;
        u0 = A*sin(pi*k1*x');
    case 2
        p.fuha.setops = @bratu2D_setops;
        p.pdeo = stanpdeo2D(lx,lx,h);
        %initial guess
        xy = p.pdeo.grid.p;
        x = xy(1,:)';
        y = xy(2,:)';
        u0 = A*cos(pi*k1*(x+1/2)).*cos(pi*k2*(y+1/2));
        
    case 3
        p.fuha.setops = @bratu3D_setops;
        p.pdeo = stanpdeo3D(lx,lx,lx,h);
        %initial guess
        xyz = p.pdeo.grid.p;
        x = xyz(1,:)';
        y = xyz(2,:)';
        z = xyz(3,:)';

        u0 = A*cos(pi*k1*x).*cos(pi*k2*y).*cos(pi*k3*z);

    otherwise
        error('Invalid dimension specified. Please use d = 1, 2, or 3.');
end



% p.np is number of points N^d = (nx+1)^d
p.np = p.pdeo.grid.nPoints;
p.nu = p.np*p.nc.neq; % total number of nodes

%parameters: store as last entries of p.u
p.nc.ilam = 1;       % first and only bifurcation parameter
par  = laminit;      % Initial value of lambda
p.sw.bifcheck = 2;   % turn on fold detection


% append parameters to vector
p.u = [u0; par ; M];

%assemble FEM operators and apply Dirichlet penalty
p = setfemops(p);

% continuation parameters 

p.sol.xi = 1/p.np;   % xi from the xi inner product
p.nc.nsteps = 50;    % maximum number of continuation points if not specified else
p.sol.ds = 0.01;     % initial ds value
p.nc.dsmax = 0.02;   % maximum ds value, decrease for smoother curve
p.nc.dlammax = 0.05; % maximum displacement in lambda
p.nc.lammin = 0.001; % minimal value of lambda
p.nc.lammax = 10; % maximal value of lambda

%create frac laplace matrix
p.mat.Kalpha = FractionalLaplacian(p.mat.K, p.mat.M, p.np, h, alpha);

p.nc.imax = 50;
p.nc.tol  = 1e-8;

[p.u,p.sol.res,p.sol.iter] = nloop(p,p.u);

% plot initial solution
plotsol(p,1,1,p.plot.pstyle);

p.plot.pmod = 100; %plot solution u every 100 cont steps.
p.file.smod = 1;   %save every point in a .mat file

fprintf('res = %g, iter = %d\n',p.sol.res,p.sol.iter);