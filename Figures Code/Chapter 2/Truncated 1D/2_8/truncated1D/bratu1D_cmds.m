function Time = bratu1D_cmds(T, nx)
%% Bratu 1D model (Dirichlet u=0 at both ends)

 %Homogeneous solution branch
tic;
close all force; keep pphome T nx;
if mod(T,2)==1
%For odd truncation need multiple branches with different wave number   
p=[]; p=bratu1D_init(p,0.5,nx, T, 0.01, 1, 0.01);   % lx=0.5, nx=200 intervals
p=cont(p,300);
close all force; keep pphome T nx ;

q1=[]; q1 = bratu1D_init(q1, 0.5, nx, T, 40, 3, 0.51);
q1 = cont(q1, 800);
close all force; keep pphome T nx;

q2=[]; q2 = bratu1D_init(q2, 0.5, nx, T, 65, 5, 0.51);
q2 = cont(q2, 1500);
close all force; keep pphome T nx;

q3=[]; q3 = bratu1D_init(q3, 0.5, nx, T, 90, 7, 0.51);
q3 = cont(q3, 1500);
close all force; keep pphome T nx;

q4=[]; q4 = bratu1D_init(q4, 0.5, nx, T, 115, 9, 0.51);
q4 = cont(q4, 2000);
close all force; keep pphome T nx;

q5=[]; q5 = bratu1D_init(q5, 0.5, nx, T, 140, 11, 0.51);
q5 = cont(q5, 2500);
close all force; keep pphome T nx;

q6=[]; q6= bratu1D_init(q6, 0.5, nx, T, 165, 13, 0.51);
q6 = cont(q6, 2500);
close all force; keep pphome T nx; 
else
w=[]; w=bratu1D_init(w,0.5,nx, T, 0.01, 1, 0.51);   % lx=0.5, nx=200 intervals
w=cont(w,300);
close all force; keep pphome T nx;
end
Time=toc;
end
