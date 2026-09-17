% This is a copy of Listing A.1 in:
% Numerical continuation for fractional PDEs:
% sharp teeth and bloated snakes
%
% by
%
% Noémie Ehstand
% Christian Kuehn
% Cinzia Soresina

function Ks = FractionalLaplacian_FAST(K,M,np,h,s)
% Ks discretization of the fractional operator
% K,M standard stiffness and mass matrices
% np number of mesh points
% h mesh size
% s fractional order

% parameters
k = -1/log(h);

Np = ceil(pi^2/(4*(1-s)*k^2));
Nm = ceil(pi^2/(4*s*k^2));

coeff = -k*sin(s*pi)/pi;

% fractional Laplacian
Ks = zeros(np,np);

% number of quadrature terms
nSteps = Np + Nm + 1;

% progress bar
wb = waitbar(0,...
    'Constructing fractional Laplacian...');

cleanupObj = onCleanup(@() closeWaitbar(wb));

% Balakrishnan sum
%
% For a fixed l, the matrix
%
% A = alpha*M + K
%
% is identical for every column.
% Therefore, factorize A only once and solve
% simultaneously for all right-hand sides K.

for j = 1:nSteps

    l = -Nm + j - 1;

    alpha = exp(k*l);

    A = alpha*M + K;

    % Factorize A only once
    dA = decomposition(A,'lu');

    % Equivalent to solving
    %
    % A*v_i = K*e_i
    %
    % for every column simultaneously
    V = dA\K;

    % Add current quadrature contribution
    Ks = Ks + exp(s*k*l)*V;

    % update progress bar
    if isvalid(wb)

        progress = j/nSteps;

        waitbar(progress,wb,...
            sprintf(...
            'Constructing fractional Laplacian: %d%%',...
            round(100*progress)));

    end

end

% multiply by the Balakrishnan coefficient
Ks = coeff*Ks;

end


function closeWaitbar(wb)

if isvalid(wb)

    close(wb);

end

end