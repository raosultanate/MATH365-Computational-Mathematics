clear;
clc;
clf;

%Data Points
x_matrix = [1, 2, 3, 4, 6, 10];
y_matrix = 1./x_matrix;
n = length(x_matrix) - 1;

h = hBuilder(x_matrix);
[A, A_super, A_sub] = A_Mat_Builder(h);
k = k_builder(y_matrix, h);
u = beethoven_mozart_6_3(n, A, A_super, A_sub, k);
p = c_to_p(u);
b = b_builder(y_matrix, h, p);
d = d_builder(p, h);

% helps build s
for i = 1:n
    xVals = linspace(x_matrix(i), x_matrix(i+1), 100);
    xVals_Length = length(xVals);
    s = y_matrix(i) + b(i)*(xVals-x_matrix(i)) + p(i)*(xVals-x_matrix(i)).^2 + d(i)*(xVals-x_matrix(i)).^3;
    
    xlabel('x values');
    ylabel('y values');
    title('Natural Cubic Spline');
    hold on;
    plot(xVals, s, 'b');
    plot(x_matrix, y_matrix, 'o'); %points
    legend('Interpolation', 'Data Points');
end

% helps us build h matrix
function return_h = hBuilder(xMat)
xMatSize = length(xMat);
h_temp = [];
for i = 1:xMatSize
    if i ~= xMatSize
        h_temp(end + 1) = xMat(i + 1) - xMat(i);
    end
end
return_h = h_temp;
end

% helps us build A matrix
function [A_diag, A_superDiag, A_subDiag] = A_Mat_Builder(h_process)
h_MatSize = length(h_process);
A_diag_temp = [];
A_super_temp = [];
for i = 1:h_MatSize
    if i ~= h_MatSize
        A_diag_temp (end + 1) = 2 * (h_process(i + 1) + h_process(i));
    end
end
A_diag = A_diag_temp;
for i = 1:h_MatSize - 2
    A_super_temp(end + 1) = h_process(i + 1);
end
A_superDiag = A_super_temp;
A_subDiag = A_super_temp;
end

% helps us build k matrix
function kMat = k_builder(yMat, hMat)
k_temp = [];
hMatSize = length(hMat);
for i = 1:hMatSize - 1
    if i ~= hMatSize
        partA = (yMat(i + 2) - yMat(i + 1)) / hMat(i + 1);
        partB = (yMat(i + 1) - yMat(i)) / hMat(i);
        partC = 3 * (partA - partB);
        k_temp(end + 1) = partC;
    end
end
kMat = k_temp;
end

function pMat = c_to_p(cMat)
p_temp = [];
p_temp(1, 1) = 0;
cMatSize = length(cMat);
% copy everything to p_temp
for i = 1:cMatSize
    p_temp(end + 1) = cMat(i);
end
p_temp(end + 1) = 0;
pMat = p_temp';
end

% helps us build b
function bMat = b_builder(yMat, hMat, pMat)
b_temp = [];
hMatSize = length(hMat);
for i = 1:hMatSize
        partA = (yMat(i + 1) - yMat(i)) / hMat(i);
        partB = ((2 * pMat(i)) + pMat(i + 1));
        partC = (- 1 * hMat(i) / 3);
        b_temp(end + 1) = partA + (partB * partC);
end
bMat = b_temp;
end

% helps us build d
function dMat = d_builder(pMat, hMat)
d_temp = [];
hMatSize = length(hMat);
for i = 1:hMatSize
        partA = (pMat(i + 1) - pMat(i));
        partB = (3 * hMat(i));
        d_temp(end + 1) = (partA / partB);
end
dMat = d_temp;
end

function u = beethoven_mozart_6_3(n, a, b, c, k)
invalidMatrix = false;
matrixLoop = size(a);
matrixLoop = matrixLoop(1, 2) - 1;

for i = 1:matrixLoop
    m = (c(1, i) / a(1, i));
    if m == Inf
        invalidMatrix = true;
        break;
    else
        c(1, i) = c(1, i) - (m * a(1, i));
        a(1, i + 1) = a(1, i + 1) - (m * b(1, i));
        k(1, i + 1) = k (1, i + 1) - (m * k(1, i));
    end
end

uMatrix = [];
if invalidMatrix == true
    fprintf("Invalid Matrix! Please refer to the homework!\n");
    u = [];
    return;
else
    % Building u matrix
    u_martrixInteration = matrixLoop + 1;
    for j = u_martrixInteration: - 1:1
        if j == u_martrixInteration
            u_1 = k(1, j) / a(1, j);
            uMatrix(end + 1) = u_1;
        else
            x = u_martrixInteration - j;
            u_2 = (k(1, j) - (b(1, j) * uMatrix(1, x))) / a(1, j);
            uMatrix(end + 1) = u_2;
        end
    end
    u = flipud(uMatrix');
end
end
