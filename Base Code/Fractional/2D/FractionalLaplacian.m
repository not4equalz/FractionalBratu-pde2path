% Based on Listing A.1 in:
%
% N. Ehstand, C. Kuehn, and C. Soresina,
% "Numerical continuation for fractional PDEs:
% sharp teeth and bloated snakes",
% Communications in Nonlinear Science and Numerical Simulation,
% Vol. 98, 105762, 2021.
%
% DOI: 10.1016/j.cnsns.2021.105762
%
% The original work is licensed under the
% Creative Commons Attribution 4.0 International License (CC BY 4.0).
%
% I modified the code to include a progress bar.


function Ks = FractionalLaplacian(K,M,np,h,s)
% Ks discretization of the fractional operator
% K,M standard stiffness and mass matrices
% np number of mesh points
% h meshsize
% s fractional order

% parameters
k = -1/log(h);
Np = ceil(pi^2/(4*(1-s)*k^2));
Nm = ceil(pi^2/(4*s*k^2));
coeff = -k*sin(s*pi)/pi;

% fractional Laplacian
Ks = zeros(np,np);

% progress bar
progress = 0;
wb = waitbar(0,'Constructing fractional Laplacian...');
cleanupObj = onCleanup(@() closeWaitbar(wb));
q = parallel.pool.DataQueue;
afterEach(q,@updateWaitbar);

parfor i = 1:np
    t = zeros(np,1);
    t(i,1) = 1; % test vector
    col = zeros(np,1);

    % compute the Balakrishnan sum
    z = K*t;

    for l = -Nm:Np
        alpha = exp(k*l);
        A = alpha*M + K;
        v = lsqminnorm(A,z);
        col = col + exp(s*k*l)*v;
    end

    col = coeff*col;

    % set the i-th column of Ks
    Ks(:,i) = col;

    % update progress bar
    send(q,1);
end

    function updateWaitbar(~)
        progress = progress + 1;
        if isvalid(wb)
            waitbar(progress/np,wb, ...
                sprintf('Constructing fractional Laplacian: %d%%', ...
                round(100*progress/np)));
        end
    end

end

function closeWaitbar(wb)
if isvalid(wb)
    close(wb);
end
end
