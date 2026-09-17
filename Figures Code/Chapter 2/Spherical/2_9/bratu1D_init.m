function p=bratu1D_init(p,R,nx,laminit,d)
% Radially symmetric Bratu problem on a d-dimensional ball of radius R:
% -u_rr -(d-1)/r*u_r = lambda*exp(u),  0<r<R,
% u_r(0)=0 and u(R)=0.

%standard setup
p=stanparam(p); dir=sprintf('%s',inputname(1)); p=setfn(p,dir); screenlayout(p);

%problem size
p.nc.neq = 1;
p.nc.nq  = 0;
p.d = d;              % spatial dimension of the original ball
p.R = R;              % ball radius

%function handlers
p.sw.sfem = -1;
p.fuha.sG     = @bratu1D_sG;
p.fuha.sGjac  = @bratu1D_sGjac;
p.fuha.spjac  = @bratu1D_spjac;
p.fuha.setops = @bratu_setops_rad;

% output for bifurcation diagram
p.fuha.outfu = @(p,u) max(abs(u(1:p.np)));
p.plot.bpcmp = 1;


% Initially construct uniform parameter mesh s in [0,1]
h = 1/nx;
p.pdeo = stanpdeo1D(0.5,h);

% Shift from [-0.5,0.5] to [0,1]
s = p.pdeo.grid.p + 0.5;

% Nonuniform radial mesh:
% coarse near r=0 and fine near r=R
switch d
    case {1,2,3}
        q = 1.0;     % uniform mesh

    case 8
        q = 0.7;     % moderately graded mesh

    case 10
        q = 0.5;     % strongly graded mesh
end
p.pdeo.grid.p = R*s.^q;

p.np = p.pdeo.grid.nPoints;
p.nu = p.np*p.nc.neq;

%parameters
p.nc.ilam = 1;
par = laminit;
p.sw.bifcheck = 2;

% Radially symmetric initial guess: u_r(0)=0 and u(R)=0
r = p.pdeo.grid.p(1,:)';
u0 = laminit/(2*d) .* (R^2-r.^2);
p.u = [u0; par];

%assemble radial FEM operators
p = setfemops(p);

% continuation parameters
p.sol.xi = 1/p.np;
p.nc.nsteps = 50;
p.sol.ds = 0.01;
p.nc.dsmax = 0.01;
p.nc.dlammax = 0.05;
p.nc.lammin =0.01;
p.nc.imax = 30;

% solve initial point
[p.u,p.sol.res,p.sol.iter] = nloop(p,p.u);

% plot initial radial solution
plotsol(p,1,1,p.plot.pstyle);
p.plot.pmod = 100;
p.file.smod = 1;
end
