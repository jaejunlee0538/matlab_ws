function [] = plotClusters(data, label)
hold off
plot(data(1,label==1),data(2,label==1),'r.');hold on;
plot(data(1,label==2),data(2,label==2),'b.');
plot(data(1,label==3),data(2,label==3),'k.');
plot(data(1,label==4),data(2,label==4),'m.');
drawnow;
end