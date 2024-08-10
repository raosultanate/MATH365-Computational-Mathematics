clear;
clf;
clc;

FID = fopen('lsdata.m', 'r');
line=fgetl(FID);
%this skips the first row of data since they represent n and m
% where n is degree and m is amount of data points
% m must be greater than n

n = str2num(line(1, 1));
m = str2num(line(1, 3));

if m > n
fnt = '%f %f';
A = fscanf(fid, fnt, [2, inf]);
A = A';

x_vals = A(:, 1);
y_vals = A(:, 2);

x_pow = @(t) (x_vals.^t);

matX = ones(n+1);
x = [];
b = [];
M = [];

%for b matrix
for i= 0:n
    b(end +1) = sum(x_pow(i) .* A(:, 2));
end
b = b';

%for M matrix
for i = 0:2*n
    x(end +1) = sum(x_pow(i));
end
for i = 1:(n+1)
    for j = i+n
        matrix = x(1, i:j) .* matX(1, 1:(n+1));
        M = [M; matrix];
    end
end

%Now that M and b for Ma=b, it is time to find a:
a = M\b

%Plot the points
scatter(x_vals, y_vals, 'bo'); 
hold on

%Now it is time to create the polynomial of best fit
flip = flipud(a);
X = x_vals(1):0.01:x_vals(end);
p = polyval(flip, X);
plot(X, p, 'r-');
legend('Points', 'Line of Best Fit');
axis('equal');

else
    fprintf('Please enter a value of "m" greater than "n".\n')
end



