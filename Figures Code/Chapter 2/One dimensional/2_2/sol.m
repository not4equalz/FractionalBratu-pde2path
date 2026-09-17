close all;

%1. select lambda
%2. Find zeros theta using Newton Raphson
%3. Then plot solutions u(x)

lambda = 2;

%theta initial guesses
theta = linspace(0,50, 500);


% Initialize array to store zeros
newTheta = zeros(size(theta));


%NR
tol=1e-4;
for i=1:1e5
    newTheta = theta - (theta-sqrt(2*lambda)*cosh(theta/4))./...
        (1-sqrt(lambda/8)*sinh(theta/4));
    if max(abs(newTheta - theta)) < tol
        break;
    end
    theta = newTheta;

 
end
%filter out unique theta values
theta_roots = newTheta(isfinite(newTheta));    
theta_roots = real(theta_roots);                
theta_roots = theta(theta_roots >= 0);           
theta_roots = round(theta_roots,10);             
theta_roots = unique(round(theta_roots,5));    

%plot solutions u(x)
x = linspace(0,1, 300);

u = zeros(2, 300);
for k = 1:min(2,numel(theta_roots))
    u(k,:) = -2*log( cosh((x - 1/2)*theta_roots(k)/2) ./ cosh(theta_roots(k)/4) );
end


%plot
figure(1);
theme(figure(1), "light"); 
plot(x, u(1,:), 'r',LineWidth=2);
hold on;
plot(x, u(2,:), 'b', LineWidth=2);

legend({'Lower Solution', 'Upper Solution'}, 'Location', 'best');
xlabel('x');
ylabel('u(x)');
sgtitle(sprintf('Solutions of 1D equation with \\lambda = %g', lambda), 'FontSize', 15);