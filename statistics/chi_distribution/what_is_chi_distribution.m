figure();
cmap = jet(12);

for dof = 10:1:12
    N_sample = 500000;
    chi_square = zeros(N_sample, 1);
    for i =1:1:dof
        x = normrnd(0, 1.0, N_sample, 1);
        chi_square = chi_square + x.*x;
    end

    [N, X] = hist(chi_square, 200);
    N = N / N_sample;
    
    legend('-DynamicLegend');
    p_h = plot(X , N, 'Color', cmap(i,:),'linewidth',2, 'DisplayName',sprintf('%d dof', dof)); 
    hold on;
end
xlim([0 20]);
title('\chi^2 distribution','fontsize',15)
