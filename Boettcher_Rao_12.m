clear;
clf;
clc;

%f = @(x) 1-abs(2*x-1);
    %string fixed at end points and at maximum height at midpoint
f = @(x) sin(2*pi*x);
g = @(x) 0;
N = 200; 
dt = 0.004;
tsteps = 800;
c = 1;
    %properties of string
A = 0;
B = 0;
bounds = [0 1 -1 1];
    %dimensions of window
    
dx = 1/N;
x = linspace(0,1,N+1);
t = linspace(0,tsteps*dt,tsteps+1);
v = 0.005
mu1 = c * dt^2 / (dx^2);
mu2 = 1/(1+v)

%ICs
for i = 1:N+1
    u(1,i) = f(x(i));
    u(2,i) = u(1,i) + g(x(i))*dt;
end

plot(x,u(1,:));
axis(bounds);
ttext = 't = 0';
text(0.1, 0.8, ttext);
xlabel('x');
ylabel('u');
M(1) = getframe();

plot(x,u(2,:));
axis(bounds);
ttext = strcat('t = ', num2str(t(2)));
text(0.1, 0.8, ttext);
xlabel('x');
ylabel('u');
M(2) = getframe();

for m = 2:tsteps
    m
    u(m+1,1) = A;
    u(m+1,N+1) = B;
    for j = 2:N
       u(m+1,j) = (-u(m-1,j) + 2*u(m,j) + mu1*(u(m,j+1)+u(m,j-1)-2*u(m,j))+v*u(m-1,j))*mu2;
    end
    plot(x,u(m+1,:));
    axis(bounds);
    ttext = strcat('t = ', num2str(t(m+1)));
    text(0.1, 0.8, ttext);
    xlabel('x');
    ylabel('u');
    M(m+1) = getframe();
end
%Need stab to be > 0 for stability
stab = dx / sqrt(c) - dt;

close all;

figure(1);
contourf(x,t,u);
colorbar;
xlabel('x');
ylabel('t');

figure(2);
axis(bounds);
xlabel('x');
ylabel('u');
movie(M);
