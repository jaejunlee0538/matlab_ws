clear all;
close all;
%% load data
load('different_size_gaussian_samples.mat');
D = size(data,1);
N = size(data,2);
K = size(data,3);

%% k-means clustering
unlabeled_data = reshape(data, D, N*K);
result = KmeansClustering(unlabeled_data, K, 0);

%% report and plot
if D==3 || D==2
    cmap = hsv(K);
    figure();
    
    for i = 1:1:K
        if D == 2
            % ground truth data
            subplot(1,2,1);
            plot(data(1,:,i),data(2,:,i),'.','markersize',5, 'Color', cmap(i,:)); hold on;
            
            % k-means result
            subplot(1,2,2);
            idx = (result==i);
            mu_estimated = mean(unlabeled_data(:, idx)');
            sigma_estimated = cov(unlabeled_data(:, idx)');
            plot(unlabeled_data(1,idx),unlabeled_data(2,idx),'.','markersize',5, 'Color', cmap(i,:)); hold on;
        else
            % ground truth data
            subplot(1,2,1);
            plot3(data(1,:,i),data(2,:,i),data(3,:,i),'.','markersize',5, 'Color', cmap(i,:)); hold on;
            
            % k-means result
            subplot(1,2,2);
            idx = (result==i);
            plot(unlabeled_data(1,idx),unlabeled_data(2,idx),unlabeled_data(3,idx),'.','markersize',5, 'Color', cmap(i,:)); hold on;
        end
        sprintf('%d cluster : ', i)
        disp(mu(:,i))
        disp(sigma(:,:,i))
        disp(mu_estimated)
        disp(sigma_estimated)
    end
    
    subplot(1,2,1);
    title('ground truth','fontsize',20);

    subplot(1,2,2);
    title('hard k-means clustering','fontsize',20);
    
    set(gcf, 'color','w')
    
end

