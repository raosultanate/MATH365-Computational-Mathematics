clear;
clc;
clf;

fid = fopen('BezierData.m', 'r');
%curves_num = str2num(fgetl(fid));
curves_num = 2;
total_Data_Expected = curves_num * 4 * 2;

fmt = '%f';
masterData = fscanf(fid, fmt);
% List contains matrices of x and y datapoints.
masterData_Size = size(masterData);
masterData_Size = masterData_Size(1, 1);

if masterData_Size == total_Data_Expected
 
    list = {};
    tempMatrix = [];
    for i = 1:masterData_Size
     
        if mod(i, 4) == 0
            tempMatrix(end + 1) = masterData(i);
            list(end + 1) = {tempMatrix};
            tempMatrix = [];
        else
            tempMatrix(end + 1) = masterData(i);
        end
     
    end
 
    listSize = masterData_Size / 4;
    t_deltas = 101;
    t_vals = linspace(0, 1, t_deltas);
 
    func = @(matrix, t) (matrix(1, 1) .* (1 - t) ^ 3) + (3 .* matrix(1, 2) .* t .* (1 - t) ^ 2) + (3 * matrix(1, 3) .* t ^ 2 .* (1 - t)) + (matrix(1, 4) .* t ^ 3);
 
    x_vals = [];
    y_vals = [];
 
    for i = 1:listSize
        for j = t_vals
            if mod(i, 2) == 0
                % Even part of the list.
                y_vals(end + 1) = func(list{i}, j);
            else
                % Odd part of the list.
                x_vals(end + 1) = func(list{i}, j);
            end
        end
    end
 
    x_vals = x_vals';
    y_vals = y_vals';
 
    axis('equal');
    xlabel('x-axis');
    ylabel('y-axis');
    title('Bezier Curves');
    hold on;
    plot(x_vals, y_vals);
 
else
    fprintf("Invalid values in the file. Please read the homework description.\n");
end