close all;
X = simulated_data(1);

Y =  kPCA(X, 2, 'gaussian', 27.5);
% eigVal = kPA(X, 49, 27);


% Y = kPA(X, 49, 10:2:30);