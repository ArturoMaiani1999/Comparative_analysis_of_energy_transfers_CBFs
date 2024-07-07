% Step 1: Define the symbolic variables
syms q1 q2 q3 q1_dot q2_dot q3_dot real
q = [q1; q2; q3];
q_dot = [q1_dot; q2_dot; q3_dot];

m = 1;
L = 1;

% Trigonometric functions
c2 = cos(q(2)); c3 = cos(q(3)); c23 = cos(q(2) + q(3));

% Elements of the inertia matrix
a11 = 4 + 3*c2 + c3 + c23;
a12 = 5/3 + (3/2)*c2 + c3 + (1/2)*c23;
a13 = 1/3 + (1/2)*(c3 + c23);
a22 = 5/3 + c3;
a23 = 1/3 + (1/2)*c3;
a33 = 1/3;

% Inertia matrix
M = m*L^2 * [a11, a12, a13;
             a12, a22, a23;
             a13, a23, a33];

% Step 2: Compute the time derivative of M
M_dot = sym(zeros(3,3));
for i = 1:3
    for j = 1:3
        M_dot(i,j) = diff(M(i,j), q1) * q1_dot + diff(M(i,j), q2) * q2_dot + diff(M(i,j), q3) * q3_dot;
    end
end

% Step 3: Compute the Christoffel symbols
% Initialize the Christoffel symbols
Gamma = sym(zeros(3,3,3));

for k = 1:3
    for j = 1:3
        for i = 1:3
            % Compute the Christoffel symbol Gamma^k_ij
            Gamma(k,i,j) = 0.5 * (diff(M(k,j), q(i)) + diff(M(k,i), q(j)) - diff(M(i,j), q(k)));
        end
    end
end

% Assemble the Coriolis matrix C(q, q_dot)
C = sym(zeros(3,3));
for k = 1:3
    for j = 1:3
        C(k,j) = 0;
        for i = 1:3
            C(k,j) = C(k,j) + Gamma(k,i,j) * q_dot(i);
        end
    end
end

% Step 4: Calculate the matrix 2 * M_dot - C
Matrix_to_check = M_dot - 2 * C;

% Step 5: Check if the matrix is skew symmetric
is_skew_symmetric = simplify(Matrix_to_check + transpose(Matrix_to_check)) == 0;

% Display the results
disp('The Coriolis matrix C(q, q_dot) is:');
disp(C);

disp('The matrix 2 * M_dot - C is:');
disp(Matrix_to_check);

disp('Is 2 * M_dot - C skew symmetric?');
disp(is_skew_symmetric);

% Check the skew-symmetry for specific values of q and q_dot
is_skew_symmetric_numeric = double(subs(Matrix_to_check, [q1, q2, q3, q1_dot, q2_dot, q3_dot], [0.6, 0.5, -0.3, -0.1, 2.1, -3.3]));
disp('Is 2 * M_dot - C skew symmetric for the specific values?');
disp(is_skew_symmetric_numeric);



