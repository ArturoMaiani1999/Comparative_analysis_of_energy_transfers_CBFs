clear;
clc;

syms q1 q2 dq1 dq2 ddq1 ddq2 real
disp('the given robot inertia matrix')
% M=[a1+2*a2*q2+a3*q2^2+2*a4*q2*sin(q3)+a5*(sin(q3))^2 ,0, 0;
%     0, a3, a4*cos(q3);
%     0, a4*cos(q3), a6];


% Trigonometric functions

c2 = cos(q2); 

% Elements of the inertia matrix
I1 = 1;
I2 = 1;
m1 = 1;
m2 = 1;
l1 = 1;
l2 = 1;
d1 = l1/2;
d2 = l2/2;

a1 = I1 + m1 * d1^2 + I2 + m2 * d2^2 + m2*l1^2 ;
a2 = m2 * l1 * d2 ;
a3 = I2 + m2 * d2^2;
% syms a1 a2 a3 real
m11 = a1 + 2 * a2 * c2;
m12 = a3 + a2 * c2;
m22 = a3;


% Inertia matrix
M = [m11, m12;
     m12, m22]
diff(M,q1)
diff(M,q2)

disp('Christoffel matrices')
q=[q1;q2];
M1=M(:,1);
C1=(1/2)*(jacobian(M1,q)+jacobian(M1,q)'-diff(M,q1))
M2=M(:,2);
C2=(1/2)*(jacobian(M2,q)+jacobian(M2,q)'-diff(M,q2))


disp('robot centrifugal and Coriolis terms')
dq=[dq1;dq2];
c1=dq'*C1*dq;
c2=dq'*C2*dq;

c=[c1;c2]
pretty(c)
disp('time derivative of the inertia matrix')

dM=diff(M,q1)*dq1+diff(M,q2)*dq2

disp('skew-symmetric factorization of velocity terms')
S1=dq'*C1;
S2=dq'*C2;

S=[S1;S2]
disp('check skew-symmetry of N=dM-2*S')
N=simplify(dM-2*S)
N_plus_NT=simplify(N+N')



function [cbf_control, psi_nominal, psi_safety, computed_H_dot, cbf, cbf_dot_nominal,cbf_dot_safety]= CBF(y, M, h, dh_dq, u_des, alpha, gamma, damp)
    
    q = reshape(y(1:3),[3,1]);
    dq = reshape(y(4:6),[3,1]);
    dh_dq = reshape(dh_dq,[1,3]);

    M_inv = inv(M);


    KE = 0.5 * dq' * M * dq;
    cbf = alpha * h - KE;

    cbf_dot_nominal = dq' * (alpha .* dh_dq'- u_des);
    psi_nominal = cbf_dot_nominal + gamma .* cbf;
    if psi_nominal<0
        lg_h = -dq';
        cbf_control =  -lg_h' /(lg_h * lg_h')  .* psi_nominal;
    else
        cbf_control = zeros(3,1);
    end
    cbf_dot_safety =  dq' * (alpha .* dh_dq'- u_des- cbf_control);
    psi_safety = cbf_dot_safety + gamma .* cbf;

    computed_H_dot = dq' * cbf_control - dq' * damp * dq;
end