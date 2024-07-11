% Define numerical values for the parameters

% r = 1;


l1 = 1;
l2 = 1;
l3 = 1;


% Compute the partial derivatives of h with respect to q
dh_dq = sym(zeros(1, 2));
syms q1 q2 xc yc r real

x_ee_sym = l1 * cos(q1) + l2 * cos(q1 + q2);
y_ee_sym = l1 * sin(q1) + l2 * sin(q1 + q2);

h_sym = (xc - x_ee_sym)^2 + (yc - y_ee_sym)^2 - r^2;



dh_dq(1) = diff(h_sym, q1);
dh_dq(2) = diff(h_sym, q2);


dh_dq

% Substitute the values of q into the symbolic derivatives
hessian_sym = hessian(h_sym,[q1,q2])
pretty(hessian_sym)

