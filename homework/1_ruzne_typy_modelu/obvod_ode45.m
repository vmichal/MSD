n = 8;
L = 15e-4;
C = 1e-6;
R = 100;
u_0 = 1;

E = zeros(n);
E(1,1) = C;
E(2,2) = L;

A = ...
[0 0 1 0, 0 0 0 0;
 0 0 0 1, 0 0 0 0;
 0 0 0 0,-1 0 0 0;
 0 0 0 0, 0 1 0 -1;
 1 0 0 0, -1 0 1 0;
 0 0 0 0, 0 0 -1 R;
 1 0 0 -1, 0 0 0 0;
 0 1 1 0, 0 -1 0 0
]

B = [0;0;1;0;0;0;0;0]

initial_cond = zeros(n, 1);

odefun = @(time, states) A*states + B*u_0;
options = odeset('Mass', E);

[time, states] = ode15s(odefun, [0 0.0012], initial_cond, options);

u_C = states(:,1); i_L = states(:,2);

plot(time * 1000, [u_C, i_L], 'LineWidth', 2);
title('Časový průběh obvodových veličin');
xlabel('Čas [ms]');
ylabel('Hodnota veličiny');
legend({'u_C [V]', 'i_L [A]'})


%% Rozdělení matic E, A, B na podmatice
E11 = E(1:2, 1:2)
E12 = E(1:2, 3:8)
E21 = E(3:8, 1:2)
E22 = E(3:8, 3:8)

A11 = A(1:2, 1:2)
A12 = A(1:2, 3:8)
A21 = A(3:8, 1:2)
A22 = A(3:8, 3:8)

B11 = B(1:2, 1)
B21 = B(3:8, 1)


A_new = E11 \ (A11 - A12*(A22\A21))
B_new = E11 \ (B11 - A12*(A22\B21))


