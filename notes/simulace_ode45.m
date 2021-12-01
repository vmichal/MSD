%% Numerická simulace kyvadla

% fi dot dot + g/l sin(fi) = 0, zavedu další stav omega

%stav model:
% fi dot = omega
% omega dot = - g/l sin(fi)

g = 9.81; % tíhové zrychlení
l = 1; %délka závěsu
kyvadlo = @(t, stav) [stav(2); -g/l * sin(stav(1))]; % anonymní funkce

t_start = 0; t_end = 5; % čas simulace
fi_0 = pi/2; omega_0 = 0; %počáteční podmínky

[time, states] = ode45(kyvadlo, [t_start t_end], [fi_0, omega_0]);
plot(time, states)
legend({'úhel', 'rychlost'})

% Funkce initial se nedá použít, protože ta bere pouze lineární systém.