
g = 9.81;
v_T = 55;

% stav(1) .. pozice (vyska), stav(2) ... rychlost
odr = @(cas, stav) [stav(2); g*(stav(2)^2 / v_T^2 -1)];

poc_podm = [300; 0];
time_span = [0 10];
[time, states] = ode45(odr, time_span, poc_podm);
a = (states(:,2) / v_T).^2 - 1;
%plot(time, [states(:,1)'; states(:,2)'; a' * g]);
plot(time, [states(:,1)'; states(:,2)'],'LineWidth',2);
xlabel('Čas [s]');
ylabel('Hodnota veličiny');
%legend('výška [m]', 'rychlost [m/s]', 'zrychlení [m/s^2]')
legend('výška [m]', 'rychlost [m/s]')
title('Simulace pádu parašutisty s uvážením odporu vzduchu');
