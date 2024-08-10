clear;
clf;
clc;

% u(x,t) = t + x^2
c = 0.5;
n = 20;
tsteps = 200;
dt = 0.2;
g = @(x) x.^2; % IC function
a = 0; % initial x
b = 1; % end x
% keeps temp of wire 0 at end points
A = @(t) t; % alpha used when x = a
B = @(t) t + 1; % beta used when x = b, 
dx = (b-a)/n;
x = linspace(a, b, n+1);
q = c*dt/(2*(dx)^2); % rho
t = [0:dt:dt*tsteps];

% diagonal elements of matrix
aa = ones(n-1,1)*(1+2*q); % ones gives matrix with n-1 rows and 1 column
%super diagonal 
bb = ones(n-2, 1)*-q;
%subdiagonal
cc = bb;

% IC
u = g(x);

% time marching
for m = 1:tsteps
    u(m+1, 1) = A(t(m+1));
    u(m+1, n+1) = B(t(m+1));
    
    r = q*u(m,3:n+1) +(1-2*q)*u(m,2:n)+q*u(m,1:n-1);
    r(1) = r(1)+q*A(t(m+1));
    r(n-1) = r(n-1)+q*B(t(m+1));
    v = tridfun(n-1, aa, bb, cc, r');
    u(m+1, 2:n) = v';
end
contourf(x,t,u);
colorbar;
xlabel('x');
ylabel('t');
% stability check
stab = (dx)^2/(2*c)-dt;
	
%Our origianl tridiagonal solver did not work for this problem so we redid
%it
function u = tridfun(n, a, b, c, k)
for i = 1:n-1
    m = c(i) / a(i);
    %c(i + 1) = c(i + 1) - a(i) * m;
        %we realized that the c values were not needed
    a(i + 1) = a(i + 1) - m * b(i);
    k(i + 1) = k(i + 1) - m * k(i);
end
for i = n-1 : -1:1
    m = b(i) / a(i + 1);
    k(i) = k(i) - m * k(i + 1);
end
% Building u matrix
u = (k ./ a);
    for j = 1:n
        if a(j) == 0
            u = fprintf('The matrix is not tridiagonal. \nThe value of the factor c(i)/a(i+1) is infinity. \n');
            break
        elseif j == n
            u;
        end
    end
end