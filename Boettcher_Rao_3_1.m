clear;
clc;

% preparation function
f = @(x) x^2 - 2;

%intervals
a = 1;
b = 2;

% Tolerance 
e = 0.00001;

% Iteration
n = ceil(log2((b-a)/e));
% This gaurentees that n iterations will give a value of accuracy within
% the desired tolerance

if f(a)*f(b) < 0
% continue with the program as both the points falls on the opposite side.

for i = 1:n
    c = (a+b)/2;
    if i == n
        fprintf("The solution is %.4f.\n", c);
        break;   
    end
    % selecting interval
    if f(a)*f(c) < 0
        b = c;
    elseif f(b)*f(c) < 0
        a = c;
    end
end
else 
    fprintf("No roots between given intervals.\n");
end
