function f = cartesian(q, rdim)
% f = cartesian(q, rdim)
%
% Returns cartesian coordinates of the robot link ends.
% Parameters:
% - q: generalized coordinates
% - rdim: robot dimensions ([l0, l1, l2, r0, r1, r2]')
% Returns:
% - f: cartesian coordinates of the link ends
%
% Olli Haavisto, 2004

% head
xh = q(1,:)+(rdim(1)-rdim(4))*sin(q(3,:));
yh = q(2,:)+(rdim(1)-rdim(4))*cos(q(3,:));

% hip
xj = q(1,:) - rdim(4)*sin(q(3,:));
yj = q(2,:) - rdim(4)*cos(q(3,:));

% knees
xlj = xj - rdim(2)*sin(q(3,:)-q(4,:));
ylj = yj - rdim(2)*cos(q(3,:)-q(4,:));
xrj = xj - rdim(2)*sin(q(3,:)-q(5,:));
yrj = yj - rdim(2)*cos(q(3,:)-q(5,:));

% leg tips
xlg = xlj - rdim(3)*sin(q(3,:)-q(4,:)+q(6,:));
ylg = ylj - rdim(3)*cos(q(3,:)-q(4,:)+q(6,:));
xrg = xrj - rdim(3)*sin(q(3,:)-q(5,:)+q(7,:));
yrg = yrj - rdim(3)*cos(q(3,:)-q(5,:)+q(7,:));

f = [xh', yh', xj', yj', xlj', ylj', xlg', ylg', xrj', yrj', xrg', yrg']';