%scans p2p directories to find file with largest lambda
%used to generate table 1
folder = 'p';   % folder containing pt*.mat files
files = dir(fullfile(folder, 'pt*.mat'));

lambda_max = -Inf;
max_file = '';

warning('off','all');

for i = 1:length(files)

    S = load(fullfile(folder, files(i).name), 'p');
    p = S.p;

    lambda = p.u(p.nu + 1);

    if lambda > lambda_max
        lambda_max = lambda;
        max_file = files(i).name;
    end
end

warning('on','all');

fprintf('Largest lambda = %.10f\n', lambda_max);
fprintf('Found in %s\n', max_file);