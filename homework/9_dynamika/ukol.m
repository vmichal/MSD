
theta = sym('theta', [1 2]);
dtheta = sym('dtheta', [1 2]);
l = sym('l', [1 2]);
m = sym('m', [1 2]);
Ix = sym('Ix', [1 2]);
Iy = sym('Iy', [1 2]);
Iz = sym('Iz', [1 2]);
syms g
syms(theta)
syms(l)
syms(m)
syms(Ix)
syms(Iy)
syms(Iz)
 
R01 = [cos(theta1) 0 -sin(theta1);
    sin(theta1) 0 cos(theta1);
    0 -1 0];

R12 = [cos(theta2) -sin(theta1) 0; sin(theta2) cos(theta2) 0; 0 0 1];

R02 = R01 * R12;

Jrot1 = [0 0; 0 0 ; 1 0];
Jrot2 = [[0;0;1] [-sin(theta1); cos(theta1);0]];

I11 = diag([Ix1 Iy1 Iz1]);
I22 = diag([Ix2 Iy2 Iz2]);

Jtr1 = [sin(theta1)*l1/2 0; cos(theta1)*l1/2 0; 0 0];
Jtr2 = [
    -l1*sin(theta1)-l2/2*sin(theta1)*cos(theta2), -l2/2*cos(theta1)*sin(theta2);
    l1*cos(theta1)+l2/2*cos(theta1)*cos(theta2), -l2/2*sin(theta1)*sin(theta2);                                                            
    0, -l2/2*cos(theta2)
];

M = m1 * (Jtr1.')*Jtr1 + (Jrot1.') * R01 * I11 * (R01.') * Jrot1 + m2 * (Jtr2.')*Jtr2 + (Jrot2.') * R02 * I22 * (R02.') * Jrot2;
M11 = simplify(M(1,1));
M12 = simplify(M(1,2));
M21 = simplify(M(2,1));
M22 = simplify(M(2,2));

%Potenciální energie

V = -g*(m1 * l1/2*cos(theta1) + m2 * (l1*cos(theta1)+l2/2*cos(theta1)*cos(theta2)));

G1 = diff(V, theta1);
G2 = diff(V, theta2);

c = @(e,f,g) 1/2*(diff(M(g,e), theta(f)) + diff(M(g, f), theta(e)) + diff(M(e, f),theta(g)));
C = @(f, g) c(1,f,g) *dtheta(1) + c(2,f,g) *dtheta(2);

clipboard('copy', latex(simplify(C(2,1))))

