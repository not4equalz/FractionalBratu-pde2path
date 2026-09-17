function p=bratu1D_init(p,lx,nx)
%1D initialization script for bratu with dirichlet u=0 at endpoints
%domain x in [-lx, lx], grid size h = 2lx/nx

%standard setup
p=stanparam(p); dir=sprintf('%s',inputname(1)); p=setfn(p,dir); screenlayout(p);

%problem size
p.nc.neq = 1;        %number of PDE components
p.nc.nq  = 0;        %no auxiliary equations

%switch to OOPDE (needed for 1D)
p.sw.sfem = -1;
p.fuha.sG    = @bratu1D_sG;
p.fuha.sGjac = @bratu1D_sGjac;
p.fuha.setops = @bratu1D_setops;

% output for bifurcation diagram
p.fuha.outfu = @(p,u) max(u(1:p.np));
p.plot.bpcmp = 1;

%1D domain and mesh (interval [-lx,lx])
h = 2*lx/nx;
p.pdeo = stanpdeo1D(lx,h);

p.np = p.pdeo.grid.nPoints;
p.nu = p.np*p.nc.neq;

%parameters: store as last entries of p.u
p.nc.ilam = 1;       % first parameter is "lambda"
par  = 0.01;         %lambda

%initial guess (respect Dirichlet u=0 at endpoints)
u0 = 0.1*ones(p.np,1);
u0([1 p.np]) = 0;

p.u = [u0; par];

%assemble FEM operators and apply Dirichlet penalty
p = setfemops(p);

% continuation parameters (copy of 2D demo defaults)
p.sol.xi = 1/p.np;
p.nc.nsteps = 50;
p.sol.ds = 0.05;
p.nc.dsmax = 1;
p.nc.dlammax = 0.05;
p.nc.lammin = 0.05;

% solve initial point
[p.u,p.sol.res,p.sol.iter] = nloop(p,p.u);

% plot initial solution
plotsol(p,1,1,p.plot.pstyle);
