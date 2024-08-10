clear;
clc;
clf;

p = @(t) t^2;
q = @(t) t;
r = @(t) 4*t^2 + 3*t;
t0 = 0;
tend = 10;
n = 500;
y0 = [3 2]';

f = @(t,y) [y(:,2)
            r(t) - p(t)*y(:,2) - q(t)*y(:,1)]';

dt = (tend - t0)/n;
t = [t0 : dt : tend];
y(1,:) = y0;

for i = 1:n
    k1 = f(t(i), y(i, :));
    k2 = f((t(i) + dt/2), (y(i, :) + ((dt/2)*k1)));
    k3 = f((t(i) + dt/2), (y(i, :) + ((dt/2)*k2)));
    k4 = f(t(i) + dt, y(i, :) + (dt * k3));
    y(i + 1, :)= y(i, :) + ((dt/6)*(k1+(2*k2)+(2*k3)+k4));
end

xlabel('t');
ylabel('y');
title('Vectorized RK4 Method Approximate Solution');
hold on;
plot(t,y(:,1), 'bo');
