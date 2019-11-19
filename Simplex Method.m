function [cbar_N,x,obj] = Simplex(A,b,c,B)

[n1,n] = size(A);
[m1,m] = size(B);

% Non-basic
for i=1:n
    N1(1,i) = i;
end

idx = not(ismember(N1', B', 'rows'));
id = 1:size(N1, 2);
N = id(idx);

% A_B, A_N, c_B, and c_N for current basis B
% B and N contain the basic and nonbasic indices
A_B = A(:,B);
A_N = A(:,N);
c_B = c(B);
c_N = c(N);



% calculate basic solution of basis B
x = sym(zeros(n,1));
x_B = linsolve(A_B,b);
x(B) = x_B;
x_N = sym(zeros(n-m,1));
x(N) = x_N;

% calculate basic direction
d = -linsolve(A_B,A_N);
ybar = linsolve(A_B',c_B);

cbar_N = (c(N)' - ybar'*A(:,N)); % caculate reduced cost
[Q,J] = min(cbar_N);
obj = c'*x;

if cbar_N()>=0
    fprintf('It has optimal value.')
    return;
else
    fprintf('It does not have optimal value.\n')
% ratio test for nonbasic variable J. Note that the elements of d are not all negative.
ratios = -x_B ./ d(:,J);
[Q,I] = min(ratios);

% swap index I and index J
saveBi = B(I);
B(I) = N(J);
N(J) = saveBi;

fprintf('%i needs to enter and %i needs to exit.',B(I),N(J))
end

end

