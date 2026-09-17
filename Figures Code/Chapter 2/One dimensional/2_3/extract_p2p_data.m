function [lam,umax] = extract_p2p_data()
folder = 'p';
files = dir(fullfile(folder,'pt*.mat'));

lam = zeros(length(files),1);
umax = zeros(length(files),1);

for k = 1:length(files)
    S = load(fullfile(folder,files(k).name));
    p = S.p;

    lam(k)  = p.u(p.nu+1);              % lambda
    u       = p.u(1:p.nu);              
    umax(k) = max(abs(u));              % max norm
end

% sort (important!)
[lam, idx] = sort(lam);
umax = umax(idx);

end