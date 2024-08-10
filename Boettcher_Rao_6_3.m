%n = 4 gives size of matrix
%a = diagonal
%b = super diagonal
%c = sub diagonal
%k = answer


function u = beethoven_mozart_6_3(n, a, b, c, k)
invalidMatrix = false;
matrixLoop = size(a);
matrixLoop = matrixLoop(1, 2) - 1;

for i = 1:matrixLoop
    m = (c(1, i) / a(1, i));
    if m == Inf
        invalidMatrix = true;
        break;
    else
        c(1, i) = c(1, i) - (m * a(1, i));
        a(1, i + 1) = a(1, i + 1) - (m * b(1, i));
        k(1, i + 1) = k (1, i + 1) - (m * k(1, i));
    end
end

uMatrix = [];
if invalidMatrix == true
    fprintf("Invalid Matrix! Please refer to the homework!\n");
    u = [];
    return;
else
    % Building u matrix
    u_martrixInteration = matrixLoop + 1;
    for j = u_martrixInteration: - 1:1
        if j == u_martrixInteration
            u_1 = k(1, j) / a(1, j);
            uMatrix(end + 1) = u_1;
        else
            x = u_martrixInteration - j;
            u_2 = (k(1, j) - (b(1, j) * uMatrix(1, x))) / a(1, j);
            uMatrix(end + 1) = u_2;
        end
    end
    u = flipud(uMatrix');
end
end