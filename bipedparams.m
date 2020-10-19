% Parameters for the Biped model block
%
% Olli Haavisto, 2004

% sample time
st = 0.005;

% robot link lengths (m)
l0 = 0.8; % torso
l1 = 0.5; % thigh
l2 = 0.5; % shank
% center of mass distances (m)
r0 = l0/2; % torso (from hip)
r1 = l1/2; % thigh (from hip)
r2 = l2/2; % shank (from knee)
% link masses (kg)
m0 = 5; % torso
m1 = 2; % thigh
m2 = 1; % shank
% link inertias (kgm^2)
J0 = 1/12*m0*l0^2;
J1 = 1/12*m1*l1^2;
J2 = 1/12*m2*l2^2;

% fill in the structure
robot.l = [l0, l1, l2];
robot.r = [r0, r1, r2];
robot.m = [m0, m1, m2];
robot.J = [J0, J1, J2];

clear l0 l1 l2 r0 r1 r2 m0 m1 m2 J0 J1 J2

% acceleration of gravity (m/s^2)
g = 9.81;

% initial state
x00 = 0;        % (m)
y00 = 1.3749;   % (m)
a0  = 0.04;  % (rad)
bl0 = -0.15+0.04;  % (rad)
br0 = 0.1075+0.04;   % (rad)
cl0 = 0.2096-0.04;   % (rad)
cr0 = 0.2016-0.04;   % (rad)

initstate.coordinates = [x00, y00, a0, bl0, br0, cl0, cr0];

% initial speeds
px00 = 0.1;  % (m/s)
py00 = -0.05; % (m/s)
pa0  = -0.6; % (rad/s)
pbl0 = -0.6; % (rad/s)
pbr0 = -1; % (rad/s)
pcl0 = 0.6;  % (rad/s)
pcr0 = 0;  % (rad/s)

initstate.speeds = [px00, py00, pa0, pbl0, pbr0, pcl0, pcr0];

clear x0 y0 a0 bl0 br0 cl0 cr0 px0 py0 pa0 pbl0 pbr0 pcl0 pcr0

% ground force calculation initial state
initstate.gcstate = [0,1,0,1];

load initstate %!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

% ground shape
% - row 1: x-coordinates
% - row 2: y-coordinates
groundp.ground = [-5:0.1:1000];
groundp.ground = [groundp.ground;0.01*sin(40000*groundp.ground)];

% ground parameters
% - normal direction
groundp.ky = 10000; % elastic constant
groundp.by = 500; % damping ratio
% - tangential direction
groundp.kx = 10000; % elastic constant
groundp.bx = 500; % damping ratio
% friction coefficients
groundp.muk = 0.6; % kinetic
groundp.mus = 1.2; % static

% knee stopper parameters
knees.kk = 1000; % elastic constant
knees.bk = 100; % damping ratio

% maximum and minimum knee angles (rad)
knees.max = 160*pi/180;
knees.min = 0;