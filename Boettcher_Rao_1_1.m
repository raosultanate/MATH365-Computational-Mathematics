clear;

fid = fopen('hw1dat.m', 'r');
fid2 = fopen('hw1out.m', 'w');

a = fscanf(fid, '%d');
n = length(a);

sum = 0;
for i = 1:n;
    sum = sum + a(i, 1);
end

xyz = sum/n;
fprintf(fid2, 'The average is %d\n', xyz);

fclose(fid);
fclose(fid2);
