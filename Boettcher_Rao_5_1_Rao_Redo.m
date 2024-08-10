clear;
clf;
clc;

fid = fopen('polyinfile.m', 'r');
x_Line = fgetl(fid);
y_Line = fgetl(fid);

capture_n = '';
while true
    thisline = fgetl(fid);
    if ~ isempty(thisline)
        capture_n = thisline;
        break;
    end
    if ~ ischar(thisline)
        break;
    end
end

    n = str2num(capture_n);
    x_matrix = str2num(x_Line);
    y_matrix = str2num(y_Line);
 
    x_matrix = x_matrix';
    y_matrix = y_matrix';
 
    superMatrix = [x_matrix, y_matrix];
 
    matrixSize = size(x_matrix);
    matrixSize = matrixSize(1, 1);
 
    % x1 and x2 is; for range
    x1 = superMatrix(1, 1);
    x2 = superMatrix(matrixSize, 1);
 
    x_dataPoints = superMatrix(:, 1);
    y_dataPoints = superMatrix(:, 2);
 
    all_x_vals = linspace(x1, x2, n);
 
    point = [];
    for k = 1:n
        p = 0;
        for l = 1:matrixSize
            p = p + (y_dataPoints(l) * L_Eval(l, all_x_vals(k), x_dataPoints, matrixSize));
        end
        point(end + 1) = p;
    end
 
    axis equal;
    title('Lagrange Polynomial Interpolation');
    xlabel('x-axis');
    ylabel('y-axis');
    plot(x_dataPoints, y_dataPoints, 'g*');
    hold on;
    plot(all_x_vals, point);
    hold on;
    legend('Points', 'Lagrang Polynomial');

function L_output = L_Eval(i, x, x_dataP, mSize)
p = 1;
for j = 1:mSize
    if j ~= i
        p = p * ((x - x_dataP(j)) / (x_dataP(i) - x_dataP(j)));
    end
end
L_output = p;
end

