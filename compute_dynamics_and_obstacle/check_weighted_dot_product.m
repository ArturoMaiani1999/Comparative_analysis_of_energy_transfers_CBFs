clc;
clear;

% v = [1;-1];
% angle = 3.14/2 * 0.9;
% rot = [cos(angle), -sin(angle);
%     sin(angle), cos(angle)];
% 
% w = rot * v;
% 
% before_dot = v'*w
% 
% A = [3,0;
%     -1,2];
% 
% PD = A*A';
% 
% e = eig(PD)
% 
% after_dot = v'*A*w


% Define the vectors and matrix
u = [-10.7432, -7.0749, -3.5022];
v = [0.9665; 0.2049; -2.1787];
M = [
    1.4494  -3.2963   2.5248
   -3.2963   9.1991  -9.9917
    2.5248  -9.9917  18.0051
];

% Standard dot product
standard_dot_product = u * v;

% Weighted dot product
M_v = M * v;
weighted_dot_product = u * M_v;

% Display results
disp('Standard Dot Product:');
disp(standard_dot_product);
disp('Weighted Dot Product:');
disp(weighted_dot_product);
