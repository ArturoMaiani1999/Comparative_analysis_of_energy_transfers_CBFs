clear;
clc;

syms q1 q2 q3 dq1 dq2 dq3 ddq1 ddq2 ddq3 a1 a2 a3 a4 a5 a6 real
disp('the given robot inertia matrix')
% M=[a1+2*a2*q2+a3*q2^2+2*a4*q2*sin(q3)+a5*(sin(q3))^2 ,0, 0;
%     0, a3, a4*cos(q3);
%     0, a4*cos(q3), a6];


% Trigonometric functions
c2 = cos(q2); c23 = cos(q2 + q3); c3 = cos(q3);

% Elements of the inertia matrix
a11 = 4 + 3*c2 + c3 + c23;
a12 = 5/3 + (3/2)*c2 + c3 + (1/2)*c23;
a13 = 1/3 + (1/2)*(c3 + c23);
a22 = 5/3 + c3;
a23 = 1/3 + (1/2)*c3;
a33 = 1/3;

% Inertia matrix
M = [a11, a12, a13;
             a12, a22, a23;
             a13, a23, a33]
diff(M,q1)
diff(M,q2)
diff(M,q3)
% M = [a1+2*a2*q2+a3*q2^2+2*a4*q2*sin(q3)+a5*(sin(q3))^2, 0, 0;
%             0, a3, a4*cos(q3);
%             0, a4*cos(q3), a6];
disp('Christoffel matrices')
q=[q1;q2;q3];
M1=M(:,1);
C1=(1/2)*(jacobian(M1,q)+jacobian(M1,q)'-diff(M,q1))
M2=M(:,2);
C2=(1/2)*(jacobian(M2,q)+jacobian(M2,q)'-diff(M,q2))
M3=M(:,3);
C3=(1/2)*(jacobian(M3,q)+jacobian(M3,q)'-diff(M,q3))
disp('robot centrifugal and Coriolis terms')
dq=[dq1;dq2;dq3];
c1=dq'*C1*dq;
c2=dq'*C2*dq;
c3=dq'*C3*dq;
c=[c1;c2;c3];
disp('time derivative of the inertia matrix')

dM=diff(M,q1)*dq1+diff(M,q2)*dq2+diff(M,q3)*dq3

disp('skew-symmetric factorization of velocity terms')
S1=dq'*C1;
S2=dq'*C2;
S3=dq'*C3;
S=[S1;S2;S3]
disp('check skew-symmetry of N=dM-2*S')
N=simplify(dM-2*S)
N_plus_NT=simplify(N+N')