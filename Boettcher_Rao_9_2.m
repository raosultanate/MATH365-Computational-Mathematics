clear;
clc;
clf;

alpha = 2;
beta = 1.2;
gamma = 1;
delta = 0.9;

f = @(t,y) [alpha * y(1) - beta * y(1)*y(2)
            -gamma * y(2) + delta * y(1)*y(2)]';
        
t0 = 0;
tend = 10;
% R = 3 = y(1)
% F = 5 = y(2)
y0 = [3 5];
n = 500;

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

figure(1);
xlabel('Rabbit Population');
ylabel('Fox Population');
title('RK4 Method: Fox vs Rabbit Population');
hold on;
plot(y(:,1),y(:,2), 'bo');

figure(2);
hold on;
plot(t, y(:,1));
plot(t, y(:,2));
xlabel('t');
ylabel('Population');
title('RK4 Method: Population vs t');
legend('Rabbit','Fox');





