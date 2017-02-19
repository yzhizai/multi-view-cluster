function X = simulated_data(Gauss_sigma)
theta = linspace(0, pi, 20);
phi = linspace(0, 2*pi, 25);

[Theta, Phi] = meshgrid(theta, phi);

R1 = 40;
R2 = 100;


% class 1
P_cls1_x = R1*sin(Theta).*cos(Phi);
P_cls1_y = R1*sin(Theta).*sin(Phi);
P_cls1_z = R1*cos(Theta);

P_cls1_x = normrnd(P_cls1_x(:), Gauss_sigma);
P_cls1_y = normrnd(P_cls1_y(:), Gauss_sigma);
P_cls1_z = normrnd(P_cls1_z(:), Gauss_sigma);
P_cls1 = [P_cls1_x, P_cls1_y, P_cls1_z];
% class 2
P_cls2_x = R2*sin(Theta).*cos(Phi);
P_cls2_y = R2*sin(Theta).*sin(Phi);
P_cls2_z = R2*cos(Theta);

P_cls2_x = normrnd(P_cls2_x(:), Gauss_sigma);
P_cls2_y = normrnd(P_cls2_y(:), Gauss_sigma);
P_cls2_z = normrnd(P_cls2_z(:), Gauss_sigma);
P_cls2 = [P_cls2_x, P_cls2_y, P_cls2_z];

% scatter plot with function `scatter3`
% scatter3(P_cls1(:, 1), P_cls1(:, 2), P_cls1(:, 3));
% hold on
% scatter3(P_cls2(:, 1), P_cls2(:, 2), P_cls2(:, 3), '*');

X = [P_cls1; P_cls2];