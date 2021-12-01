u = @(t) 0; % Define your input function
F = @(t, x) A*x; % Define your system function
x0 = [1;1]; % Initial conditions
%−−− STABLE CHOICE OF h −−−%
h1 = 0.01; % Define your integration step
tspan1 = [0 10]; % Define your simulation time
[t_rk4_1, x_rk4_1] = my_rk4(F,tspan1, x0, h1);
[t_ode45_1, x_ode45_1] = ode45(F,tspan1, x0, h1);
%−−− UNSTABLE CHOICE OF h −−−%
h2 = 0.5; % Define your integration step
tspan2 = [0 10]; % Define your simulation time
[t_rk4_2, x_rk4_2] = my_rk4(F,tspan2, x0, h2);
[t_ode45_2, x_ode45_2] = ode45(F,tspan2, x0, h2);
% COMPARISON PLOTS
figure(1)
subplot(211)
plot(t_ode45_1, x_ode45_1, t_rk4_1, x_rk4_1);
legend('ode45', 'my_rk4')
subplot(212)
plot(t_ode45_2, x_ode45_2, t_rk4_2, x_rk4_2);
legend('ode45', 'my_rk4')
% Maximum 'h' for stable integration: h = ?
% (insert just the value or (better yet) a code performing the analytical evaluation.)

