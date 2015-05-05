function [ result ] = KmeansClustering( unlabeledData, K , showProgress)
%------------------------------ INPUT ------------------------------
% unlabeledData : unlabeled dataset to be clustered
%                 D X N
% K             : Number of Clusters
% showProgress  : plot how clusters change in every loops.
%                 1 : yes      0 : no
%------------------------------ OUTPUT ------------------------------
% result        : Labels array. Labels are assgined arbitrarily. 
%                 1 x N
% 
% leejaejun, Koreatech, Korea Republic, 2014.12.09
% jaejun0201@gmail.com

[dim N] = size(unlabeledData);
fig_handle = [];
cnt = 1;
fig_name = 'K-means Clustering Progress';
%% initialize centers of K clusters.
centers = unlabeledData(:,randi(N,1,K));

% assign each data to closest center.
distances = getEuclideanDistances(unlabeledData, centers);
[minDist result] = min(distances,[],2);

% calculate K means with newly assigned clusters and replace centers of clusters with K means.
for i=1:1:K
    centers(:,i) = mean(unlabeledData(:,result==i),2);
end
last_result = result;

% plotting.
if K==4 && dim==2 && showProgress==1
    figure('name',sprintf('K-means Clustering Progress : %d',cnt));
    plotClusters(unlabeledData,result);
    for j=1:1:50000000
    end
end

%% continue until result has no change.
while 1
    cnt = cnt +1;
    % assign each data to closest center.
    distances = getEuclideanDistances(unlabeledData, centers);
    [minDist result] = min(distances,[],2);
    
    % plotting.
    if K==4 && dim==2 && showProgress==1
        figure('name',sprintf('K-means Clustering Progress : %d',cnt));
        plotClusters(unlabeledData,result);
        for j=1:1:50000000
        end
    end
    
    if result==last_result
        result = result';
        break;
    end
    % calculate K means with newly assigned clusters and replace centers of clusters with K means.
    for i=1:1:K
        centers(:,i) = mean(unlabeledData(:,result==i),2);
    end
    last_result = result;
end

end

function dist = getEuclideanDistances(x1,x2)
% calculate every distances from each point in x1 to every points in x2.
%------------------------------ INPUT ------------------------------
% x1     : D X N1
% x2     : D X N2
%          
%------------------------------ OUTPUT ------------------------------
% dist   : Distances from each point in x1 to every points in x2.
%          N1 X N2

[dim N1] = size(x1);
N2 = size(x2,2);
dist = zeros(N1,N2);
for i=1:1:N1
    dx = x2 - repmat(x1(:,i),1,N2);
    dist(i,:) = sqrt(sum(dx.*dx,1));
end
end