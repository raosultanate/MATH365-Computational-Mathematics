clear;
clf

p = pi
theta_1 = linspace(0, (7*p)/6, 100);
theta_2 = linspace((7*p)/6, (11*p)/6, 100); 
theta_3 = linspace((11*p)/6, 2*p, 100);

r_1 = 1 + 2*sin(theta_1);
r_2 = 1 + 2*sin(theta_2);
r_3 = 1 + 2*sin(theta_3);

x_1 = r_1.*cos(theta_1);
y_1 = r_1.*sin(theta_1);
x_2 = r_2.*cos(theta_2);
y_2 = r_2.*sin(theta_2);
x_3 = r_3.*cos(theta_3);
y_3 = r_3.*sin(theta_3);

plot(x_1,y_1,'m');
hold('on');
plot(x_2,y_2, 'g');
hold('on');
plot(x_3,y_3, 'm');
axis('equal');
xlabel('x-axis');
ylabel('y-axis');
title('HW 1.2');