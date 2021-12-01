close all;
[t, x] = back_euler(A, x0, tspan, h);
plot(t, x, 'linewidth',2);
hold on;
[t, x] = forward_euler(A, x0, tspan, h);
plot(t, x, 'linewidth',2);
[t, x] = ode45(@(t, x) A*x,tspan, x0');
xlabel('t');
plot(t, x, 'linewidth',2);
legend('BE x_1', 'BE x_2', 'FE x_1', 'FE x_2', 'ODE45 x_1', 'ODE45 x_2', 'location', 'Southwest');

% Je vidět, že FE "nadstřeluje" řešení, zatímco BE začne klesat.
% Systém je netlumený harmonický oscilátor, póly na imaginární ose.
% imaginární osu nemapuje FE na stabilní oblast, proto systém zesiluje a
% diverguje.
% Naopak BE dělá i z nestaiblních systémů stabilní, proto začne tlumit
% oscilace.
% Optimální mapování dělá třeba Tustinova metoda, která mapuje přímo levou
% polorovinu s na jednotkový kruh v rovině z.
% Metoda RK4 na jednotkovou kružnici mapuje "bramboru" z levé poloroviny s.
% Tato brambora kopíruje chvíli imaginární osu, takže pomalé oscilace budou
% stále stabilní. Pro příliš vysoké frekvence nezvládne RK4 spolehlivě
% diskretizovat, protože krok bude příliš dlouhý.