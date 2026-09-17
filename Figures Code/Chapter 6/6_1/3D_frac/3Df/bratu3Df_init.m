function p=bratu3Df_init(p,lx,nx, laminit, alpha)
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
p.fuha.sG    = @bratu3Df_sG;     % G(u,lam)
p.fuha.sGjac = @bratu3Df_sGjac;  % dG/du jacobian
p.fuha.spjac = @bratu3Df_spjac;  % dG/dlam vector
p.fuha.setops = @bratu3Df_setops;% construct FEM matrices K and M

% output for bifurcation diagram
p.fuha.outfu = @(p,u) max(abs(u(1:p.np))); %functional of u on y axis (max norm)
p.fuha.ufu = @stopufu;

p.plot.bpcmp = 1; % bifurcation point colormap

% Create symmetric mesh
h = 2*lx/nx;
p.pdeo = stanpdeo3D(lx,lx,lx,h);

% p.np is number of points N^d = (nx+1)^d
p.np = p.pdeo.grid.nPoints;
p.nu = p.np*p.nc.neq; % total number of nodes

%parameters: store as last entries of p.u
p.nc.ilam = 1;       % first and only bifurcation parameter
par  = laminit;      % Initial value of lambda
p.sw.bifcheck = 2;   % turn on fold detection

% initial guess in 3D: u0(x,y) = sin(pi*x)*sin(pi*y)*sin(pi*z)

xyz = p.pdeo.grid.p;
x = xyz(1,:)';
y = xyz(2,:)';
z = xyz(3,:)';

u0 = sin(pi*x).*sin(pi*y).*sin(pi*z);
% append parameters to vector
p.u = [u0; par];

%assemble FEM operators and apply Dirichlet penalty
p = setfemops(p);

% continuation parameters 

p.sol.xi = 1/p.np;   % xi from the xi inner product
p.nc.nsteps = 50;    % maximum number of continuation points if not specified else
p.sol.ds = 0.01;     % initial ds value
p.nc.dsmax = 0.05;   % maximum ds value, decrease for smoother curve
p.nc.dlammax = 0.05; % maximum displacement in lambda
p.nc.lammin = laminit - 0.1; % minimal value of lambda

%create frac laplace matrix
%p.mat.Kalpha = FractionalLaplacian(p.mat.K, p.mat.M, p.np, h, alpha);
p.mat.Kalpha = FractionalLaplacian_FAST(p.mat.K, p.mat.M, p.np, h, alpha);

%norm(p.mat.Kalpha - p.mat.Kalpha2)

% solve initial point
[p.u,p.sol.res,p.sol.iter] = nloop(p,p.u);

% plot initial solution
plotsol(p,1,1,p.plot.pstyle);

p.plot.pmod = 100; %plot solution u every 100 cont steps.
p.file.smod = 1;   %save every point in a .mat file

