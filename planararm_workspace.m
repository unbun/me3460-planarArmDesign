% This script runs forward kinematics and some trigonometry to
% determine what certain joint angles look like and how they
% can be used to plan for the robotic arm to pick the objects
% and maneuver the obstacles

clear
a1 = 80;
a2 = 55;
a3 = 20;
aE = 10;

% objects that need to be picked up
obj1 = [52.5, 5, 5]; % centerX, centerY, radius(for drawing)
obj2 = [82.5, 5, 5]; % centerX, centerY, radius(for drawing)

% intermediate positions for the final trajectories
inter1 = [52.5, 30, 5]; % centerX, centerY, radius(for drawing)
inter2 = [82.5, 25, 5]; % centerX, centerY, radius(for drawing)

% Select the target position that we will be searching for,
% and any valid angles that the end effector can be at in z-direction.
targetPosition = inter2;
endEffectorAngles = 265:1:275; %270 is vertically down


tolerance = 0.1; % how close to the center we want the rigidBody of the end effector to be

figure; hold on;

% prevents link 1 from hitting the first obstacle
v1dMin = ceil(rad2deg(atan2(15,30)));

for v1d = v1dMin:tolerance:90
    for v2d = -155:tolerance:-90
        for targetDeg = endEffectorAngles

            v3d = targetDeg - v1d - v2d;
            
            v1 = deg2rad(v1d);
            v2 = deg2rad(v2d);
            v3 = deg2rad(v3d);
            
            % Transformation Matrices
            A01 = [cos(v1), -sin(v1), 0, a1*cos(v1); sin(v1), cos(v1), 0, a1*sin(v1); 0, 0, 1, 0; 0,0,0,1];
            A12 = [cos(v2), -sin(v2), 0, a2*cos(v2); sin(v2), cos(v2), 0, a2*sin(v2); 0, 0, 1, 0; 0,0,0,1];
            A23 = [cos(v3), -sin(v3), 0, a3*cos(v3); sin(v3), cos(v3), 0, a3*sin(v3); 0, 0, 1, 0; 0,0,0,1];
            A3E = [1, 0, 0, aE; 0, 1, 0, 0; 0, 0, 1, 0; 0,0,0,1];
            
            A02 = A01 * A12;
            A03 = A02 * A23;
            A0E = A03 * A3E;
            
            S = A0E(1:2,4);
            R = A03(1:2,4);
            P = A02(1:2,4);
            Q = A01(1:2,4);
            
            doPlot = 0;
            if inCircle(S(1), S(2), targetPosition(1), targetPosition(2), tolerance) == 1
                fprintf("Reached target position (%0.1f): (%0.2f, %0.2f, %0.2f)\n", targetDeg, v1d, v2d, v3d)
                doPlot = 1;
            end
            
            if doPlot
                dim = [.4 .5 .3 .3];
                % str = sprintf("q = [%0.2f, %0.2f, %0.2f]' facing %0.2f", v1d, v2d, v3d, targetDeg);
                % annotation('textbox',dim,'String',str,'FitBoxToText','on');
                
                line([0,Q(1)],[0,Q(2)], 'Color', '#7E2F8E')
                % plot(Q(1),Q(2),'*', 'Color', '#7E2F8E')
                
                line([Q(1),P(1)],[Q(2),P(2)], 'Color', '#0072BD')
                % plot(P(1),P(2),'*', 'Color', '#0072BD')
                
                line([P(1),R(1)],[P(2),R(2)], 'Color', '#77AC30')
                % plot(R(1),R(2),'*', 'Color', '#77AC30')
                
                line([R(1),S(1)],[R(2),S(2)], 'Color', '#4DBEEE')
                plot(S(1),S(2),'o', 'Color', '#4DBEEE')
            end
        end
    end
end


% plot obstacles
line([30, 45], [0,0], 'Color', 'k', 'LineWidth', 2.0)
line([30, 30], [0,15], 'Color', 'k',  'LineWidth', 2.0)
line([45, 45], [0,15], 'Color', 'k',  'LineWidth', 2.0)
line([30, 45], [15,15], 'Color', 'k',  'LineWidth', 2.0)

line([60, 75], [0,0], 'Color', 'k',  'LineWidth', 2.0)
line([60, 60], [0,15], 'Color', 'k',  'LineWidth', 2.0)
line([75, 75], [0,15], 'Color', 'k',  'LineWidth', 2.0)
line([60, 75], [15,15], 'Color', 'k',  'LineWidth', 2.0)

line([90, 105], [0,0], 'Color', 'k',  'LineWidth', 2.0)
line([90, 90], [0,15], 'Color', 'k',  'LineWidth', 2.0)
line([105, 105], [0,15], 'Color', 'k',  'LineWidth', 2.0)
line([90, 105], [15,15], 'Color', 'k',  'LineWidth', 2.0)

%plot Object Locations
circleDraw(obj1(1), obj1(2), obj1(3));
circleDraw(obj2(1), obj2(2), obj2(3));

function h = circleDraw(x,y,r)
hold on
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h = plot(xunit, yunit, 'Color', '#D95319', 'LineWidth', 2.0);
hold off
end