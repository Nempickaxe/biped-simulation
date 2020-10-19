function f = animatef(handles)
% Plays animation of the biped's movements.
% Parameters: 
% - handles: simulator handles structure
% Returns: 
% - f: data in cartesian coordinates
% Uses: cartesian.m
%
% Olli Haavisto, 2004

data = handles.data.state;

% reset axes
axes(handles.animation_axes);
cla;
hold on;

robotheight = sum(handles.robot.l);
set(handles.animation_axes, 'YLim', [-0.1111, 1.1111]*robotheight);
set(handles.animation_axes, 'XLim', [0,1]*1.2222*robotheight);
v = axis;

% plot ground
plot(handles.groundp.ground(1,:), handles.groundp.ground(2,:), 'k', 'lineWidth', 1);

% transform data to cartesian coordinates
if isempty(handles.converteddata)
    coord = cartesian(data', [handles.robot.l, handles.robot.r]');
else
    coord = handles.converteddata;
end;

% plot initial position
h(1) = plot([coord(1), coord(3),...
        coord(5), coord(7)],...
    [coord(2), coord(4),...
        coord(6), coord(8)],...
    'b-','lineWidth', 3, 'Erasemode', 'normal');
h(2) = plot([coord(3), coord(9),...
        coord(11)],...
    [coord(4), coord(10),...
        coord(12)],...
    'b:','lineWidth', 3, 'Erasemode', 'normal');
hold off;

% set axes
set(handles.animation_axes, 'XLim', data(1,1)+[-0.5, 0.5]*(v(2)-v(1)));
v = axis;
maxtime = num2str(get(handles.animationslider, 'Max'), '%.2f');

%%%%%%%%%%%%%% set animation step size %%%%%%%%%%%%%%%%
% increase the step values if the animation is too slow 
if handles.slow==1
    step = 6;
elseif handles.slow==2
    step = 3;
else
    step = 1;
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% previous state
switch get(handles.animation_axes, 'UserData')
    case 0 % state was stopped
        i = 1;
        set(handles.animation_axes, 'UserData', 1);
        set(handles.T, 'StartDelay', handles.st*handles.slow*step);
    case 2 % state was paused
        i = round(get(handles.animationslider, 'Value')/handles.st)+1;
        set(handles.animation_axes, 'UserData', 1);
        set(handles.T, 'StartDelay', handles.st*handles.slow*step);
        % start timer
        start(handles.T);    
    case 3 % slider has been moved
        i = round(get(handles.animationslider, 'Value')/handles.st)+1;
end;

% begin the animation
while (get(handles.animation_axes, 'UserData')==1 |...
        get(handles.animation_axes, 'UserData')==3)
  
    % animation is running
    if get(handles.animation_axes, 'UserData')==1
        i=i+step;
        % stop?
        if i>=size(data, 1)
            set(handles.animation_axes, 'UserData', 0);
            i=size(data, 1);    
		end;    
        % update time and slider
        set(handles.animationtime, 'String',...
            [num2str((i-1)*handles.st, '%.2f'), '/', maxtime]);
		set(handles.animationslider, 'Value', (i-1)*handles.st);
    end;
        
    % slider has been moved
    if get(handles.animation_axes, 'UserData')==3
        % pause the simulation
        set(handles.animation_axes, 'UserData', 2);    
    end;
	
	% set figure properties
    set(h(1), 'XData', [coord(1,i), coord(3,i),...
            coord(5,i), coord(7,i)],...
        'YData', [coord(2,i), coord(4,i),...
            coord(6,i), coord(8,i)]);
    set(h(2), 'XData', [coord(3,i), coord(9,i),...
            coord(11,i)],...
        'YData', [coord(4,i), coord(10,i),...
            coord(12,i)]);
    
	set(handles.animation_axes, 'XLim',...
        data(i,1)-data(1,1)+[v(1), v(2)]);
     
    % update figure
    drawnow;

%     %%%%%%%%%%%%%%% grab images for a movie %%%%%%%%%%%%%%%
%     F = getframe(gca,[155, 20, 120, 370]);
%     [X,Map] = frame2im(F);
%     [X2, Map] = rgb2ind(X);
%     imwrite(X2, Map, ['anim\anim', num2str((i-1)*handles.st, '%.2f'), '.gif'], 'gif');
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   

    % delay
    if get(handles.animation_axes, 'UserData')==1
        % wait for timer
        wait(handles.T);
        % start timer
        start(handles.T);
    end;
end;
% return cartesian coordinates
f = coord;