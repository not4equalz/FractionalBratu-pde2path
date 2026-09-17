function p=bratu_init(p,lx,ly,nx) 
% initialization routine for "bratu" demo
% see manual or routine "stanparam" for explanations of settings
% standard settings, window arrangement, file names
p=stanparam(p); dir=sprintf('%s',inputname(1)); p=setfn(p,dir); screenlayout(p);

% PDE standard implementation
p.nc.neq=1;        % set number of equations for pde
p.fuha.G=@bratu_G;       % set functions f in pde
p.fuha.Gjac=@bratu_Gjac;   % set jacobian of f (not required if p.jsw=3)
p.nc.nq=0;         % number of auxiliary equations

%output plot function
p.fuha.outfu = @(p,u) max(u(1:p.np));
p.plot.bpcmp = 1;   

% domain and mesh
[p.mesh.geo, bc]=recdbc1(lx,ly, 1e6); p.fuha.bc=@(p,u) bc; p.fuha.bcjac=@(p,u) bc;
ny=round(nx*ly/lx);p=stanmesh(p,nx,ny); p=setbmesh(p); % p=setfemops(p);

% continuation settings
p.nc.ilam=1;       % set primary parameter index (here no other active parameters)

%settings used for solution profiles 
%p.sol.xi=1/p.np; p.nc.nsteps=50; p.nc.dsmax=1; p.nc.dlammax=0.05; 
%p.nc.lammin=0.05; p.sol.ds=0.05;

%settings used for bifurcation diagram
p.sol.xi = 1/p.np;   % xi from the xi inner product
p.nc.nsteps = 50;    % maximum number of continuation points if not specified else
p.sol.ds = 0.01;     % initial ds value
p.nc.dsmax = 0.03;   % maximum ds value, decrease for smoother curve
p.nc.dlammax = 0.05; % maximum displacement in lambda
p.nc.lammin = -0.00001; % minimal value of lambda

% initial point and parameters
p.u=0.1*ones(p.np,1);
par(1)=0.06;  % parameter 1 
p.u =[p.u; par'];

% newton step to get good initial point
[p.u,p.sol.res,p.sol.iter]=nloop(p,p.u); % correct initial guess 
fprintf('first residual=%g with %i iterations\n',p.sol.res,p.sol.iter); % and inform user 
plotsol(p,1,1,p.plot.pstyle); % plot this guess
p.plot.pmod = 100; %plot solution u every 100 cont steps.
p.file.smod = 1;   %save every point in a .mat file


