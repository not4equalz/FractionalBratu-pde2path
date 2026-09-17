close all;

%Given lambda Compare Theta with sqrt(2*lam)cosh(theta/4)
lambda = [1 3.51 10];

%theta space
theta = linspace(-5,15,300);


figure(1); clf;
theme(figure(1), "light"); % Sets theme to light

for i = 1:length(lambda)
    
    lam = lambda(i);
    %calculate cosh function
    coshval = sqrt(2 * lam) * cosh(theta / 4);

    subplot(1,3,i)
    %subplot
    plot(theta, theta, 'b');
    hold on;
    plot(theta, coshval, 'r', 'LineWidth', 2);

    xlabel('\theta', FontSize=15);
    ylabel('y', FontSize=15);
    title(sprintf('\\lambda = %g', lam), 'FontSize', 16);
    legend({'$\theta$', '$\sqrt{2\lambda}\cosh(\theta/4)$'}, ...
       'Interpreter','latex', 'Location','northwest', 'FontSize',12);

end

sgtitle('Intersections of functions of \theta', 'FontSize', 15);