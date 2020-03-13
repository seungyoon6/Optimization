clc; clear;

%% Data Processing
ed = readtable('ionosphere.dat');
%Convert label as numeric
for i = 1:351
        if (ionos.Var35(i) == "g")
           ionos.Var35{i} = double(1);
        else
           ionos.Var35{i} = double(0);
        end
end
ionos.Var35 = cell2mat(ionos.Var35);
ionos = ionos{:,:};

%Matrix transform to intercept variable
A = ones(351,1);
changed_ionos = [A ionos];

%Split data set
train_set = changed_ionos(1:250,:);
test_set = changed_ionos(251:351,:);

X_train = train_set(:,1:35);
Y_train = train_set(:,36);
X_test = test_set(:,1:35);
Y_test = test_set(:,36);

%%
%(a) Parameter of the binary logistic regression

%%%%%%%%%%%%%%%%%%%%%%%% CVX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
cvx_begin
cvx_solver mosek;
    variable B(35)
    maximize (transpose(Y_train)*log(exp(X_train*B)./
    (1+exp(X_train*B)))+(1-transpose(Y_train))*log(1./(1+exp(X_train*B))))
cvx_end
fprintf("Logistic Regression Solution\n");
fprintf("Intersection is : %d\n",B(1,1));
fprintf("Rest parameters are:\n");
fprintf("%d\n",B(2:35,1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Prediction
Y_prediction = exp(X_test*B)./(1+exp(X_test*B));
for i = 1:101
        if (Y_prediction(i) >= 0.5)
            Y_prediction(i) = 1;
        else
            Y_prediction(i) = 0;
        end
end
%Error rate
Error_rate = mean(Y_prediction ~= Y_test);
fprintf("Error rate is %d.\n\n\n",Error_rate);



%%
%(b) Parameter of the svm
%%%%%%%%%%%%%%%%%%%%%%CVX%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lambda = 1e-3;
clc;
cvx_begin
    variables w(35) b;
    minimize 1/250 * sum(max(1.-Y_train.*(X_train*w-b),0))+lambda/2*power(2,norm(w));
cvx_end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Prediction of SVM
Y_prediction_SVM = sign(X_test*w-b);

%Error rate
Error_rate = mean(Y_prediction_SVM ~= Y_test);
fprintf("Error rate of SVM is %d.\n\n\n",Error_rate);

%%
%(c)
%%%%%%%%%%%%%%%%%%%%%%CVX%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lambda = 1e-3;
clc;
cvx_begin
    variables a1(1,250);
    maximize sum(a1) - (1/2*Y_train.*transpose(a)*exp(-0.1*norm())
cvx_end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Prediction of SVM
Y_prediction_SVM = sign(X_test*w-b);

%Error rate
Error_rate = mean(Y_prediction_SVM ~= Y_test);
fprintf("Error rate of SVM is %d.\n\n\n",Error_rate);


Y_train.*transpose(a)*3