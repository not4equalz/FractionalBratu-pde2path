function [p,cstop] = stopufu(p,brdat,ds)

    [p,cstop] = stanufu(p,brdat,ds);

    fnout = max(abs(p.u(1:p.np)));

    if fnout > 15
        cstop = 1;
        fprintf('Stopping: ||u||_inf = %.4f > 15\n',fnout);
    end
end