%limit alpha = 0 with lambertw

%critical is 1/e
lambda = 0:0.0001:1/exp(1);

lowbranch=zeros(1, length(lambda));
highbranch=zeros(1, length(lambda));
for i=1:length(lambda)
    lowbranch(i) = -lambertw(0, -lambda(i));
    highbranch(i) = -lambertw(-1, -lambda(i));
end
figure(3);clf(3);
theme(figure(3), "light");

plot(lambda, lowbranch, "Color",'k');
hold on;

plot(lambda, highbranch,"Color",'k');
box on;
grid on;
xlabel('$\lambda$', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('$\|u\|_{\infty}$', 'Interpreter', 'latex', 'FontSize', 16);
sgtitle('Limiting Bifurcation Diagram for $\alpha \rightarrow 0$', 'Interpreter', 'latex', 'FontSize', 16);