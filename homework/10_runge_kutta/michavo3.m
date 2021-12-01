u = @(t) sin(t); % Define your input function
F = @(t, x) -x/10 + u(t); % Define your system function
% Since the system has order one and its time constant is tau = 10 s
% assume that a stable step is at most 1 s, while unstable is
% above 10 s, say 30 s.
x0 = [0;0]; % Initial conditions
%−−− STABLE CHOICE OF h −−−%
h1 = 1; % Define your integration step
tspan1 = [0 10]; % Define your simulation time
[t_rk4_1, x_rk4_1] = my_rk4(F,tspan1, x0, h1);
[t_ode45_1, x_ode45_1] = ode45(F,tspan1, x0, h1);
%−−− UNSTABLE CHOICE OF h −−−%
h2 =28; % Define your integration step
tspan2 = [0 10000]; % Define your simulation time
[t_rk4_2, x_rk4_2] = my_rk4(F,tspan2, x0, h2);
[t_ode45_2, x_ode45_2] = ode45(F,tspan2, x0, h2);
% COMPARISON PLOTS
figure(1)
subplot(211)
plot(t_ode45_1, x_ode45_1, t_rk4_1, x_rk4_1);
legend('ode45', 'my\_rk4')
title('stable')
subplot(212)
plot(t_ode45_2, x_ode45_2, t_rk4_2, x_rk4_2);
legend('ode45', 'my\_rk4')
title('unstable')
% Maximum 'h' for stable integration: h = ?
% (insert just the value or (better yet) a code performing the analytical evaluation.)

function [t, x] = my_rk4(F,tspan, x0, h)
% Matrix implementation of RK4 method.
% F: Function to be solved, callable as F(time, state)
% tspan: [start_time, end_time]
% x0: initial conditions: column vector
% h: integration step
% t: column vector: times of integration
% x: matrix with state_count rows and step_count cols: approximate solution of the F at times t

%constants used in Runge-Kutta method (Butcher's table)
a = [0 0 0 0;
    1/2 0 0 0;
    0 1/2 0 0;
    0 0 1 0];

c = [0;1/2;1/2;1];
b = [1/6; 1/3; 1/3; 1/6];

n = length(x0);
% timestamps between bounds given in tspan with step h
t = (tspan(1) : h : tspan(2)) .';
x = zeros(n, length(t)); %solution, for now empty
x(:,1) = x0; %we have been given initial conditions

for step = 1:length(t)-1
    k = zeros(n,4);
    
    for k_index = 1 : 4
        k(:,k_index) = F(t(step) + h * c(k_index), x(:,step) + h * k * a(k_index,:).');
    end
    
    x(:,step + 1) = x(:,step) + h * k * b;
end
end