time = out.tout;
A = out.motor.signals(1).values;
B = out.motor.signals(2).values;
C = out.motor.signals(3).values;

plot(time * 1000, [A, B, C], 'linewidth', 2);
legend('režim A', 'režim B', 'režim C', 'location', 'east');
xlabel('Čas t [ms]');
ylabel('Rychlost motoru \omega [rad/s]');
title({'Časové průběhy rychlosti DC motoru v závislosti na režimu spínání','pro fixní střídu 30 %, spínací frekvenci 25.3 kHz a peak-to-peak napětí 14.4 V'});