clear;
clc;
clf;

f = @(t, y) t-y;
t0 = 0;
y0 = 1;
n = 10;
tend = 0.5;
dt =(tend -t0)/n;

t = [t0:dt:tend];
y(1) = y0;

for i = 1:n
    k1 = f(t(i), y(i));
    k2 = f((t(i) + dt/2), (y(i) + ((dt/2)*k1)));
    k3 = f((t(i) + dt/2), (y(i) + ((dt/2)*k2)));
    k4 = f(t(i) + dt, y(i) + (dt * k3));
    y(i + 1)= y(i) + ((dt/6)*(k1+(2*k2)+(2*k3)+k4));
end

hold on;
plot(t, y, 'bo');
xlabel('t');
ylabel('y');
title('RK4 Method');