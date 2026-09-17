function [p,cstop] = stopufu(p,brdat,ds)

    [p,cstop] = stanufu(p,brdat,ds);

    fnout = max(abs(p.u(1:p.np)));

    if fnout > 12
        cstop = 1;
        fprintf('Stopping: ||u||_inf = %.4f > 12\n',fnout);
    end
end