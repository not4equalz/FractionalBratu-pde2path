function p=bratu1Df_init(p,R,nx,laminit,d, alpha)
% Radially symmetric Bratu problem on a d-dimensional ball of radius R:
% -u_rr -(d-1)/r*u_r = lambda*exp(u),  0<r<R,
% u_r(0)=0 and u(R)=0.

%standard setup
p=stanparam(p); screenlayout(p);

%problem size
p.nc.neq = 1;
p.nc.nq  = 0;
p.d = d;              % spatial dimension of the original ball
p.R = R;              % ball radius

%function handlers
p.sw.sfem = -1;
p.fuha.sG     = @bratu1Df_sG;
p.fuha.sGjac  = @bratu1Df_sGjac;
p.fuha.spjac  = @bratu1Df_spjac;
p.fuha.setops = @bratu_setops_rad;
p.fuha.ufu = @stopufu;

% output for bifurcation diagram
p.fuha.outfu = @(p,u) max(abs(u(1:p.np)));
p.plot.bpcmp = 1;

% Create a 1D radial mesh on r in [0,R]. stanpdeo1D creates [-R/2,R/2],
% so shift its coordinates by R/2.
h = R/nx;
p.pdeo = stanpdeo1D(R/2,h);
p.pdeo.grid.p = p.pdeo.grid.p + R/2;

p.np = p.pdeo.grid.nPoints;
p.nu = p.np*p.nc.neq;

%parameters
p.nc.ilam = 1;
par = laminit;
p.sw.bifcheck = 2;

% Radially symmetric initial guess: u_r(0)=0 and u(R)=0
r = p.pdeo.grid.p(1,:)';
u0 = cos(pi*r/(2*R));
p.u = [u0; par];




% assemble radial FEM operators
p = bratu_setops_rad(p);


%create frac laplace matrix
p.mat.Kalpha = FractionalLaplacian(p.mat.K, p.mat.M, p.np, h, alpha);


% continuation parameters
p.sol.xi = 1/p.np;
p.nc.nsteps = 50;
p.sol.ds = 0.01;
p.nc.dsmax = 0.01;
p.nc.dlammax = 0.05;
p.nc.lammin =0.0;
p.nc.imax = 30;

% solve initial point
[p.u,p.sol.res,p.sol.iter] = nloop(p,p.u);

% plot initial radial solution
plotsol(p,1,1,p.plot.pstyle);
p.plot.pmod = 100;
p.file.smod = 1;
end
