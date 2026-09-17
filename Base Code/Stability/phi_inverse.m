
%% helper function    
function multiI = phi_inverse(m, d, N)
%phi_inverse for the ordering

%initialize return
multiI = zeros(d, 1);

%loop over k
for k=1:d
    multiI(k) = mod(floor((m-1)/N^(k-1)) , N) + 1;
end
end
