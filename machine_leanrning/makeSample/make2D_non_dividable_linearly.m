clear all;
close all;

K=4;
data_bitmap = imread('datamap2.bmp');

min_x = -10;
max_x = 10;
min_y = -10;
max_y = 10;

[ny nx ncolor] = size(data_bitmap);

class1 = [255 255 255];
class2 = [255 0 0];
class3 = [0 255 0];
class4 = [0 0 255];

x_grid = linspace(min_x,max_x,nx);
y_grid = linspace(min_x,max_x,ny);

N_training = 1000;
N_test = 400;

training_data = zeros(3,N_training);
for i=1:N_training
    id = 0;
    while 1
        x_idx = randi(nx);
        y_idx = randi(ny);
        data_read = reshape(data_bitmap(y_idx,x_idx,:),size(class1));
        test = sum((data_read==class1));
        if test == 3
            id = 1;
            break;
        end
        test = sum((data_read==class2));
        if test == 3
            id = 2;
            break;
        end
        test = sum((data_read==class3));
        if test == 3
            id = 3;
            break;
        end
        test = sum((data_read==class4));
        if test == 3
            id = 4;
            break;
        end
    end
    training_data(:,i) = [x_grid(x_idx) y_grid(y_idx) id]';
end

test_data = zeros(3,N_test);
for i=1:N_test
    id = 0;
    while 1
        x_idx = randi(nx);
        y_idx = randi(ny);
        data_read = reshape(data_bitmap(y_idx,x_idx,:),size(class1));
        test = sum((data_read==class1));
        if test == 3
            id = 1;
            break;
        end
        test = sum((data_read==class2));
        if test == 3
            id = 2;
            break;
        end
        test = sum((data_read==class3));
        if test == 3
            id = 3;
            break;
        end
        test = sum((data_read==class4));
        if test == 3
            id = 4;
            break;
        end
    end
    test_data(:,i) = [x_grid(x_idx) y_grid(y_idx) id]';
end


training_data = training_data';
test_data = test_data';

x1 = training_data(training_data(:,3)==1,:);
x2 = training_data(training_data(:,3)==2,:);
x3 = training_data(training_data(:,3)==3,:);
x4 = training_data(training_data(:,3)==4,:);
x1_t = test_data(test_data(:,3)==1,:);
x2_t = test_data(test_data(:,3)==2,:);
x3_t = test_data(test_data(:,3)==3,:);
x4_t = test_data(test_data(:,3)==4,:);

figure();
subplot(1,2,1);
plot(x1(:,1),x1(:,2),'b.');hold on;
plot(x2(:,1),x2(:,2),'r.')
plot(x3(:,1),x3(:,2),'k.')
plot(x4(:,1),x4(:,2),'m.')
subplot(1,2,2);
plot(x1_t(:,1),x1_t(:,2),'b.');hold on;
plot(x2_t(:,1),x2_t(:,2),'r.')
plot(x3_t(:,1),x3_t(:,2),'k.')
plot(x4_t(:,1),x4_t(:,2),'m.')


training_data = [x1;x2;x3;x4];
test_data = [x1_t;x2_t;x3_t; x4_t];

training_data = training_data';
test_data = test_data';
fprintf('training data\n');
dataSummary(training_data)
fprintf('test data\n');
dataSummary(test_data)
save('data3.mat','training_data','test_data','K')