%% Tank parameters

% area of each tank's base. Taken from the drawings in
% zadani/vodarna/documentace/technicke_vykresy
S1 = (230-15-15)*( 330-15-15)/1e6;
S2 = (230-15-15)*( 330-15-15)/1e6;
S3 = (430-15-15)*(1050-15-15)/1e6;

rho = 998; % water density, kg/m^3
g = 9.81; % gravitational acceleration, m/s^2

S = [S1 S2 S3];

C = S/rho/g; % modulus of compliance for each tank

C1 = C(1);
C2 = C(2);
C3 = C(3);

%initial_heights = [71.5792;0; 44.208]/100; % Extracted from datasets in the assignment


%% Pipe dimensions

% Assume that all pipes have the same radius (the assignment says so)
% According to zadani/vodarna/documentace/technicke_vykresy/01-leva-nadrz.pdf,
% pipes T1 and T2 have diameter 48 mm. Use this value for all pipes.
% According to the pump datasheet, it uses "G 1 " pipes.
% Based on
% https://teesing.com/en/library/publications/basics-of-thread/g-r-rp-thread-bssp-bspt,
% the diameter of G1's nut is 30.291 mm. Subtract one mm for pipe walls and use it as pipe diameter
pipe_diameter = 29e-3/2;
pipe_radius = pipe_diameter / 2;

% From zadani/vodarna/documentace/technicke_vykresy/komplet.pdf, we can
% estimate the lengths of pipes.
L2 = 680e-3; % Explicitly shown in the schematic
L1 = (1900+100 - 50 - 229)*1e-3; % the position of tank N1 base above the table minus height of the pump including its pedestal
L3 = (1900-580-250)*1e-3; % estimated: the position of tank N2 base above the table, minus the height of N3 minus 25 cm for the tank's cover.

max_pipe_volume = pipe_radius^2*pi*L1;

RT3 = pipe_resistance(L3, pipe_radius) *5;
RT2 = pipe_resistance(L2, pipe_radius) *2*2;
RT1 = pipe_resistance(L1, pipe_radius)*9;

%% Pump parameters
Pmax = 0.55e3; % Stated in the pump datasheet
five_tau = 2.4; %seconds to settle pump load, extracted from dataset 1
tau = five_tau/5;
I = 1/Pmax/tau; %To guarantee DC gain = 1
Rp = I / tau; % Such that tau = I/Rp

Uset_max = sqrt(Pmax * Rp); % Max voltage to set so that the power matches


% Extracted from dataset 1
%h1 = 61.2231e-2; h3 = 34.8e-2; p = 35e-2;% Dataset 3
h1 = 57.2231e-2; h3 = 35.2768e-2; p = 35e-2; % Dataset 1
G = (L1+h1-h3)*rho*g*I/p*1.08;

%% To reproduce dataset 1:
% set simulation time to 820 s
initial_heights = [0;0; 43.8798]/100;
event_times = [0 20 20.1 520 520.1 820];
pump_setpoints = [0 0 35 35 0 0];
v1_setpoints = [0 0 0 0 0 0];
v2_setpoints = [0 0 0 0 0 0];

%% To reproduce dataset 3:
% set simulation time to 710 s
initial_heights = [0;0; 43.971]/100;
event_times = [0 18.5 18.51 33.5 33.51 200 200.01 400 400.01 550 550.01 650 650.01 710];
pump_setpoints = [0 0 100 100 36 36 36 36 36 36 0 0 0 0];
v1_setpoints = [0 0 0 0 0 0 1 1 1 1 1 1 0 0];
v2_setpoints = [0 0 0 0 0 0 0 0 100 100 100 100 0 0];

%% To reproduce dataset 4:
initial_heights = [0;0; 44.1454]/100;
event_times = [0 18.6 18.61 44 44.01 298.6 298.61 449 449.01 548.5 548.51 800];
pump_setpoints = [0 0 100 100 36 36 36 36 0 0 0 0];
v1_setpoints = [1 1 1 1 1 1 1 1 1 1 0 0];
v2_setpoints = [0 0 0 0 0 0 100 100 100 100 0 0];

%% To reproduce dataset 5 (not good):
initial_heights = [0;0; 44.1454]/100;
event_times = [0  54.1 54.11 84 84.1 398 398.01 448.6 448.61 700];
pump_setpoints = [0 0 100 100 45 45 0 0 0 0];
v1_setpoints = [1 1 1 1 1 1 1 1 0 0];
v2_setpoints = [1 1 1 1 1 1 1 1 0 0]*100;

%% Verify that all vectors have the same length
[event_times;pump_setpoints; v1_setpoints; v2_setpoints];

initial_volumes = S' .* initial_heights;
initial_condition = [initial_volumes ; 0];

%% Function definitions

function R_T = pipe_resistance(length, radius)
    % Based on https://courses.lumenlearning.com/physics/chapter/12-4-viscosity-and-laminar-flow-poiseuilles-law/
    eta = 1.002e-3;
    R_T = 8 * eta * length / pi / radius^4;
end

