% Define numerical values for the parameters
xc = 2.5;
yc = 2;
r = 1;
gamma = 2;
alpha = 20;

m1 = 1;
m2 = 1;
m3 = 1;

l1 = 1;
l2 = 1;
l3 = 1;


% Compute the partial derivatives of h with respect to q
dh_dq = sym(zeros(1, 3));
syms q1 q2 q3 real

x_ee_sym = l1 * cos(q1) + l2 * cos(q1 + q2) + l3 * cos(q1 + q2 + q3);
y_ee_sym = l1 * sin(q1) + l2 * sin(q1 + q2) + l3 * sin(q1 + q2 + q3);

h_sym = (xc - x_ee_sym)^2 + (yc - y_ee_sym)^2 - r^2;



dh_dq(1) = diff(h_sym, q1);
dh_dq(2) = diff(h_sym, q2);
dh_dq(3) = diff(h_sym, q3);


syms xc yc real
% Substitute the values of q into the symbolic derivatives
hessian_sym = hessian(h_sym,[q1,q2,q3])
pretty(hessian_sym)



h_sym = (xc - x_ee_sym)^2 + (yc - y_ee_sym)^2 - r^2;

hessian_cart = hessian(h_sym,[xc,yc]);
jacob_ = jacobian([x_ee_sym; y_ee_sym],[q1,q2,q3])

hass_joint = jacob_' * hessian_cart *  jacob_

hass_joint - hessian_sym