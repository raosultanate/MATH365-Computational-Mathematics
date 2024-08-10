clear;
clf;
clc;

f = @(x) x .^ 2 - 3;
a = 1;

b = 3;

% ten rectangles to approximate the area under the curve.

n = 10;

dx = (b - a) / n;

x = linspace(a, b, n + 1);

s = f(a) + f(b);

for i = 1:n - 1
    s = s + 2 * f(a + i * dx);
end

Integral_Eval = dx / 2 * (s);

% midpoints

mx = linspace(a + dx / 2, b - dx / 2, n);

xx = linspace(a, b, 100);

yy = f(xx);

hold on;

plot(xx, yy, 'b');

plot([a, b], [0, 0], 'g');

% Building rectangles.

for i = 1:n
 
    % top
 
    plot([x(i) x(i + 1)], [f(x(i)) f(x(i + 1))], 'g');
 
    % left
 
    plot([x(i) x(i)], [0 f(x(i))], 'r');
 
    % right
 
    if i == n
        plot([x(i + 1) x(i + 1)], [0 f(x(i + 1))], 'r')
    end
 title('Trapeziod Method');
end
