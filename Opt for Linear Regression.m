clc; clear;

%% (a)
data = readtable('prostate.dat');
normalized_data = data;

for i = 2:10
    normalized_data(:,i) = normalize(data(:,i));
    fprintf("mean of %d column is %d.\n",i,mean(normalized_data{:,i},1));
    fprintf("variance of %d column is %d.\n\n",i,var(normalized_data{:,i},1));
end
%% (b)
X_dataset = normalized_data(1:97,2:9);
X_dataset = X_dataset{:,:};
A = ones(97,1);
X_dataset = [A X_dataset];
X_train = X_dataset(1:67,1:9);
X_test = X_dataset(68:97,1:9);

Y_train = normalized_data(1:67,1);
Y_test = normalized_data(68:97,1);
Y_train = Y_train{:,:};
Y_test = Y_test{:,:};

%%%%%%%%%%%%%%%%%%%%%%%% CVX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
cvx_begin quiet
cvx_solver mosek;

    variable B(9)
    minimize (norm(Y_train - X_train*B))
cvx_end
fprintf("Intersection is : %d\n",B(1,1));
fprintf("Rest parameters are:\n");
fprintf("%d\n",B(2:9,1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% (c)

%Prediction vector
Y_predict = X_test*B;
fprintf("Predicted values are:\n");
fprintf("%d\n",Y_predict);
%MSE(Mean Square Error)
MSE = mean((Y_test-Y_predict).^2);
fprintf("MSE is %d.\n",MSE);



