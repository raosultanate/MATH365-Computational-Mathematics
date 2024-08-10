clear;
clf;
clc;

%Equations that will be used to find p, h, k, r:
    %p = h^2 + k^2 - r^2
    %2hx + 2ky - p = x^2 + y^2

fid = fopen('circintdata.m', 'r');
m = 3;
%this is the amount of points being used, change as needed
fmt = '%f %f';
p = fscanf(fid, fmt, [m, inf]);

x = p(:, 1);
y = p(:, 2);

slope_arr = slope(x, y, m);

if slope_arr == 1
    %Calculate b:
    b = x.^2 + y.^2;
    
    %Calculate A:
    h_co = 2*x;
    k_co = 2*y;
    p_co = -1;
    ones_matrix = ones(m, 3);
        A1 = ones_matrix(:,1) .* h_co;
        A2 = ones_matrix(:,2) .* k_co;
        A3 = ones_matrix(:,3) .* p_co;
    A = [A1 A2 A3];

    %Calculate z:
    z = A\b;
    
    %Calculate r:
    h = z(1,1);
    k = z(2,1);
    p = z(3,1);
    r = sqrt(h^2 + k^2 - p);
    
    %Plotting
    axis('equal');
    xlabel('x-axis');
    ylabel('y-axis');
    title('Circle Interpolation');
        hold on;
    plot(x,y, 'g*');
        hold on;
    plot(h, k, 'rd');
        hold on;
    theta = linspace(0, 2*pi, 500);
    x_circ = r* cos(theta) + h;
    y_circ = r* sin(theta) + k;
    plot(x_circ, y_circ, 'm')
        hold on;
    legend('Points', 'Center', 'Circle Interpolation');

else
 fprintf('All data points lie on the same Line, please use a different set of data points.\n');
end

%output as 0 if slope is the same else 1 if slope is different
function slope_checker = slope(x, y, m)
% this array will be initialized and filled up as we iterate through our
% loop.
slp_arr = [];
for i = 1:m
    if i ~= m
        x2 = x(i + 1);
        x1 = x(i);
        y2 = y(i + 1);
        y1 = y(i);
        slp = (x2 - x1) / (y2 - y1);
        slp_arr(end + 1) = slp;
    end
end

slp_arr_size = size(slp_arr);
slp_arr_size = slp_arr_size(1, 2);

% after slope has been built.
for j = 1:slp_arr_size
    if j ~= slp_arr_size
        if slp_arr(j) ~= slp_arr(j + 1)
            slope_checker = 1;
            break;
        else
            slope_checker = 0;
        end
    end
end
end