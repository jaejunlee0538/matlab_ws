figure();
cmap = jet(12);
dof = 4;
N_sample = 10000000;

chi_square = zeros(N_sample, 1);
for i =1:1:dof
    x = normrnd(0, 1.0, N_sample, 1);
    chi_square = chi_square + x.*x;
end

[N, X] = hist(chi_square, 300);
N = N / N_sample;

subplot(1,2,1);
plot(X , N, 'r','linewidth',2); 
title(strcat('\chi^2 distribution : dof-',num2str(dof)),'fontsize',15)
grid on;

N_cum = cumsum(N);
subplot(1,2,2);
plot(X , N_cum, 'r','linewidth',2); 
title(strcat('cumulative \chi^2 distribution : dof-',num2str(dof)),'fontsize',15)
grid on;



