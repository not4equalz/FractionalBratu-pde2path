function p=bratu1D_init(p,lx,nx, T, A, k, lamstart)


%standard setup
p=stanparam(p); dir=sprintf('%s',inputname(1)); p=setfn(p,dir); screenlayout(p);

%problem size
p.nc.neq = 1;       
p.nc.nq  = 0;        

p.sw.sfem = -1;
p.fuha.sG    = @bratu1D_sG;
p.fuha.sGjac = @bratu1D_sGjac;
p.fuha.setops = @bratu1D_setops;

p.fuha.outfu = @(p,u) max(abs(u(1:p.np)));
p.plot.bpcmp = 1;

h = 2*lx/nx;
p.pdeo = stanpdeo1D(lx,h);

p.np = p.pdeo.grid.nPoints;
p.nu = p.np*p.nc.neq;

p.nc.ilam = 1;       
par  = [lamstart; T];        

%initial guess 
u0 = 0:(p.np -1);
u0 = A*sin(pi*k*u0*h);
u0([1 p.np]) = 0;

p.u = [u0'; par];

p = setfemops(p);

% continuation parameters
p.sol.xi = 1/p.np;
p.nc.nsteps = 50;
p.sol.ds = 0.05;
p.nc.dsmax = 0.06;
p.nc.dlammax = 0.05;
p.nc.lammin = 0.01;
p.nc.lammax = 25;

% solve initial point
[p.u,p.sol.res,p.sol.iter] = nloop(p,p.u);

% plot initial solution
p.plot.pmod = 100;
p.plot.bpm   = 100;
plotsol(p,1,1,p.plot.pstyle);
