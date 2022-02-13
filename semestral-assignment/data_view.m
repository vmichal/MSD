%% Load
time = out.tout;
%figure;

set_pump_load = out.simout_setpoints.signals.values(:, 3);
set_voltage = out.simout_setpoints.signals.values(:, 4);
set_V1 = out.simout_setpoints.signals.values(:, 1) * 100;
set_V2 = out.simout_setpoints.signals.values(:, 2);
pump_load = out.simout_states.signals.values(:, 4) * 100;
N1_level = out.simout_heights.signals.values(:, 1) * 100;
N2_level = out.simout_heights.signals.values(:, 2) * 100;
N3_level = out.simout_heights.signals.values(:, 3) * 100;

p1 = N1_level * rho * g/100;
p2 = N2_level * rho * g/100;
p3 = N3_level * rho * g/100;

R1 = out.simout_resistances.signals.values(:, 1);
R2 = out.simout_resistances.signals.values(:, 2);
R3 = out.simout_resistances.signals.values(:, 3);
p14_delta = out.simout_resistances.signals.values(:, 4);
  
%% Normal plot
plot(time,[set_pump_load set_V1 set_V2 pump_load N1_level N2_level N3_level], 'linewidth',1);
hold on;
plot(time,[R1/8 R2/3 R3], 'linestyle','--', 'linewidth', 2);
legend('Set Pump Load [0-100%]', 'Set V1 \{0,1\}','Set V2 [0-100%]','Actual Pump Load [0-100%]', ...
    'Left tank (N1) Water Level [cm]','Right tank (N2) Water Level [cm]','Lower Tank (N3) Water Level [cm]', ...
    'V2 position [0-100%]','V1 moving [-]','V1 open \{0,1\}')
axis([0 max(time) -10 120])
title('MOJE')
xlabel('Čas [s]');

%% Comparison
plot(time,[pump_load N1_level N2_level N3_level],'linestyle','--', 'linewidth',1);
hold on;
legend('Actual Pump Load [0-100%]', ...
    'Left tank (N1) Water Level [cm]','Right tank (N2) Water Level [cm]','Lower Tank (N3) Water Level [cm]')
axis([0 max(time) -10 120])
title(['Comparison of most important water plant signals'])
