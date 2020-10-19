% Parameters for the PD control block
%
% Olli Haavisto, 2004

load sref2

% initial reference
%ref = [0.03, 0.2638, 0.1928, 0.09125]';
ref = [0.04, 0.3261, 0.0314, 0.2199]';%[0.02, 0.3261, 0.0314, 0.2199]';

% robot link lengths
l0 = robot.l(1); % torso
l1 = robot.l(2); % thigh
l2 = robot.l(3); % shank
% mass center locations
r0 = robot.r(1); % torso (from hip)
r1 = robot.r(2); % thigh (from hip)
r2 = robot.r(3); % shank (from knee)

% sample time
st = 0.005;

% thighs
Pb1=80;%60     % both legs on the ground
Pb2=90;%70     % one leg on the ground
Pb3=Pb2; 
Pb4=2.5;    % neither of the legs on the ground
% knees
Pc1=60;%40     % both legs on the ground
Pc2=60;%30     % only this leg on the ground
Pc3=60;%15     % only the other leg on the ground
Pc4=2.55;   % neither of the legs on the ground
% torso
Ph1=80;%40
Ph2=80;%40
Ph3=Ph2;
Ph4=2.5;

P=[Pb1, Pb2, Pb3, Pb4;      % db
    Pc1, Pc2, Pc3, Pc4;     % cl
    Pc1, Pc3, Pc2, Pc4;     % cr
    Ph1, Ph2, Ph3, Ph4];    % head

clear Pb1 Pb2 Pb3 Pb4 Pc1 Pc2 Pc3 Pc4 Ph1 Ph2 Ph3 Ph4

% thighs
Db1=3;%1      % both legs on the ground
Db2=9;%6      % one leg on the ground
Db3=Db2;  
Db4=0.25;   % neither of the legs on the ground
% knees
Dc1=3;%0.5    % both legs on the ground
Dc2=3;%2      % only this leg on the ground
Dc3=1;%0.1    % only the other leg on the ground
Dc4=0.05;   % neither of the legs on the ground
% torso
Dh1=8;%2
Dh2=8.1;%2
Dh3=Dh2;
Dh4=0.4;

D=[Db1, Db2, Db3, Db4;      % db
    Dc1, Dc2, Dc3, Dc4;     % cl
    Dc1, Dc3, Dc2, Dc4;     % cr
    Dh1, Dh2, Dh3, Dh4];    % head

clear Db1 Db2 Db3 Db4 Dc1 Dc2 Dc3 Dc4 Dh1 Dh2 Dh3 Dh4