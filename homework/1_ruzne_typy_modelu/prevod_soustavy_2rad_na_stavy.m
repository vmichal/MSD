M = eye(3);
D = [20 -1 -1; -1 2 -1; -1 -1 11] /10;
K = [4 -2 0; -2 4 -2; 0 -2 22];
B = [0;1;0]

A_new = [zeros(3), eye(3); -M\K, -M\D]