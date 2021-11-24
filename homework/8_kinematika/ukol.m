syms l1 l2 t theta1(t) theta2(t) dtheta1(t) dtheta2(t)

T01 = dh_transform(theta1, 0, l1, -sym(pi)/2);
T12 = dh_transform(theta2, 0, l2, 0);
T02 = T01 * T12;

% relativní pozice těžišť
r_c1_1 = [-l1/2;0;0;1];
r_c2_2 = [-l2/2;0;0;1];

% absolutni pozice těžišť
r_c1_0 = T01 * r_c1_1;
r_c2_0 = T02 * r_c2_2;
% a počátků
r_1_0 = T01 * [0;0;0;1];
r_2_0 = T02 * [0;0;0;1];

% relativní úhlová rychlost
omega_12_1 = [0;0;dtheta2];
% absolutní
omega_01_0 = [0;0;dtheta1];
%omega_02_0 = omega_01_0 + R01 * omega_12_1;


