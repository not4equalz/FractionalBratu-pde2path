function [stabs, lams, us] = folderstability(folder)
%converts a branch folder into 3 arrays:
%stabs contains 1s and 0s if stable or not
% lams contains the lambda values of those particular solutions
% us contains the max(abs(u)) of those solutions.

files = dir(fullfile(folder, 'pt*.mat'));
%sort files
matNumbers = zeros(length(files),1);
for k = 1:length(files)
    matNumbers(k) = sscanf(files(k).name,'pt%d.mat');
end
[~,order] = sort(matNumbers);
files = files(order);


stabs = zeros(length(files), 1);
lams = zeros(length(files),1);
us = zeros(length(files),1);

for k = 1:length(files)
    f = load(fullfile(folder, files(k).name));
    p = f.p;
    stabs(k) = stability(p);

    % Parameter lambda
    par = p.u(p.nu+1:end);
    lams(k) = par(1);

    % Infinity norm of the solution
    u = p.u(1:p.nu);
    us(k) = max(abs(u));
    
    
% print progress percentage
pct = (k/length(files))*100;
fprintf('Progress: %3.0f%%\n', pct);

end

end