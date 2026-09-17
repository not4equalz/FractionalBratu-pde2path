%lamc against alpha where lamc is the first critical parameter where a fold occurs
close all; keep pphome;

alpha = 0.05:0.05:1;
alpha3D = [0.1, 0.3, 0.5, 0.7, 0.9, 1];
%all measured parameters
lamc_1D = [0.4080927248, 0.4551385210, 0.5085488612, 0.5687702372, 0.6364731625, 0.7125979379, 0.7980136400, 0.8939221496, 1.0014525667 ,1.1221198856, 1.2575284891, 1.4093136192, 1.5795457412, 1.7704151763, 1.9845960335, 2.2246256895, 2.4937668399, 2.7957886841, 3.1342071978, 3.5139830782];
lamc_2D = [0.4189510770, 0.4815905156, 0.5549430025, 0.6409719357, 0.7412629696, 0.8573314258, 0.9932234704, 1.1504322891, 1.3333701047, 1.5459877866, 1.7922237014, 2.0790968490, 2.4118271835, 2.7975925775, 3.2463310489, 3.7669350166, 4.3718393610, 5.0714344495, 5.8891311884, 6.8102717395];
lamc_3D = [0.4964596861, 0.9490555853, 1.8431499244, 3.6275400650, 7.1285260108, 9.9607340396];
%estimates
lamc_1D_est =lamc_1D(end).*(pi^2).^(alpha-1);
lamc_2D_est =lamc_2D(end).*(2*pi^2).^(alpha-1);
lamc_3D_est =lamc_3D(end).*(3*pi^2).^(alpha3D-1);

%smooth estimates
alphasmooth = 0:0.001:1;
lamc_1D_sm =lamc_1D(end).*(pi^2).^(alphasmooth-1);
lamc_2D_sm =lamc_2D(end).*(2*pi^2).^(alphasmooth-1);
lamc_3D_sm =lamc_3D(end).*(3*pi^2).^(alphasmooth-1);


%% plot
figure(3);clf(3);
theme(figure(3), "light");

% 1D
plot(alpha, lamc_1D, 'ro', 'LineStyle', 'none');
hold on;
plot(alphasmooth, lamc_1D_sm, 'r:', 'LineWidth', 1.5);

% 2D
plot(alpha, lamc_2D, 'go', 'LineStyle', 'none');
plot(alphasmooth, lamc_2D_sm, 'g:', 'LineWidth', 1.5);

% 3D
plot(alpha3D, lamc_3D, 'bo', 'LineStyle', 'none');
plot(alphasmooth, lamc_3D_sm, 'b:', 'LineWidth', 1.5);

box on;
grid on;
xlabel('$\alpha$', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('$\lambda_c$', 'Interpreter', 'latex', 'FontSize', 16);
title('Critical Parameter against Fractional Order', 'Interpreter','latex', 'FontSize', 16);
legend({'1D Numerical', '1D Estimate', ...
        '2D Numerical', '2D Estimate', ...
        '3D Numerical', '3D Estimate'}, ...
        'Interpreter', 'latex', ...
        'FontSize', 12, ...
        'Location', 'northwest');
% Maximum absolute errors
err_1D = max(abs(lamc_1D - lamc_1D_est));
err_2D = max(abs(lamc_2D - lamc_2D_est));
err_3D = max(abs(lamc_3D - lamc_3D_est));

fprintf('Maximum absolute error 1D: %.6f\n', err_1D);
fprintf('Maximum absolute error 2D: %.6f\n', err_2D);
fprintf('Maximum absolute error 3D: %.6f\n', err_3D);