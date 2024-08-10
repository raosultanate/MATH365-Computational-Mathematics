clear; 
clc;
clf;

p = @(t) t^2;
q = @(t) t;
r = @(t) 4*t^2 + 3*t;
n = 10;
a1 = 1;
b1 = 2;
A = 5;
B = 7;
h = (b1 - a1)/n;
t = [a1 : h : b1];

%for a,b,c,d values
for i = 1:n-1
    b(i) = 1 + (p(t(i+1))*h)/2;
    a(i) = -2 + h^2 * q(t(i+1));
    c(i) = 1 - (p(t(i+1))*h)/2;
    d(i) = h^2 * r(t(i+1));
end
d(1) = d(1)- c(1)*A;
d(n-1) = d(n-1) - b(n-1)*B;

u = beethoven_mozart_6_3(n-1, a, b(1:n-2), c(2:n-1), d);

u = [A u' B];
xlabel('t');
ylabel('y');
title('RK4 Approximate BVP Solution');
hold on;
plot(t,u, 'bo');


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