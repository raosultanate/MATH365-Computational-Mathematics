clear;
clc;
clf;

f = @(x) exp(x) - cos(x);
fp = @(x) exp(x) + sin(x);
n = 20; %number of points
a = 0; 
ex = fp(a); %exact

for i = 1:n
    h(i) = 0.5 - i*0.01;
    
    A = 1/(12*h(i));
    B = -2/(3*h(i));
    C = 0;
    D = 2/(3*h(i));
    E = -1/(12*h(i));
 
    ap = A*f(a-2*h(i))+B*f(a-h(i))+C*f(a)+D*f(a+h(i))+E*f(a+2*h(i));

    error(i) = abs(ex - ap);
end

hold on;
title('Taylor Series Approximation');
xlabel('log(h)');
ylabel('log(error)');
plot(log(h), log(error), 'b-o');
legend('Taylor Series Approx','Location','northoutside');
%https://www.mathworks.com/help/matlab/ref/matlab.graphics.illustration.legend-properties.html

slope = (log(error(n))-log(error(1)))/(log(h(n))-log(h(1)))




