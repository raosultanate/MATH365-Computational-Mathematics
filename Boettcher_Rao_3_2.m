% Newtons Method
clear;
clc;

% function
L = @(x,y)[(y^2)-(x^2)-3
            (x^2)+y-3];

% Jacobian Matrix
% Note: The Jacobian Matrix is the derivative of L
    % If L is changed, J needs to be changed accordingly
J = @(x,y)[-2*x 2*y
            2*x 1];
        

% initial values 
x0 = 1;
y0 = 1;
% initial matrix 
z0 = [x0
     y0];
 
% number of interation
N = 10;

% Tolerance
e = 0.00001;

for i = 1:N
    z1 = z0 - J(z0(1, 1), z0(2, 1))\L(z0(1, 1), z0(2, 1));
    z0 = z1;
    
     if norm(L(z0(1,1), z0(2,1)), Inf) < e
         fprintf('z0 = (%f, %f)\n)', z0(1,1), z0(2,1));
         break
     else
         fprintf("Convergence was not achieved.\n");
     end
    
end
