c = 1;
alpha = 0.5;
beta = 0.5;
t = 1;
x = transpose([4 0 0]);
x1list = zeros(100,1);
x2list = zeros(100,1);
x3list = zeros(100,1);
count = 0;
tol = 10^-5;
p = [13/14 -2/14 -3/14; -2/14 10/14 -6/14; -3/14 -6/14 5/14];

while norm(p*grad(x))> tol && count < 100
    count = count + 1;
    f = object(x); %Current Object Value
    g = grad(x);   %Gradient Value
    d = direction(p,g);
    
    % Backtracking Line Search
    alpha = backtracking(f,x,alpha,beta,t,g,d);
    xnew = x + alpha*d;
    x1list(count) = x(1);
    x2list(count) = x(2);
    x3list(count) = x(3);
    x = xnew;
end


fprintf('Root of Output is %d %d %d\n',x1list(count),x2list(count),x3list(count));
fprintf('Optimal Value is %d\n',object(x));

function f = object(x)
f = exp(x(1)+x(2)+x(3))+x(1)^2+2*x(2)^2+3*x(3)^2-2*x(1)-7*x(2)-5*x(3);
end

function g = grad(x)
g = [exp(x(1)+x(2)+x(3))+2*x(1)-2
     exp(x(1)+x(2)+x(3))+4*x(2)-7
     exp(x(1)+x(2)+x(3))+6*x(3)-5];
end

function d = direction(p,g)
d = -p*g;
end

function new_alpha = backtracking(f,x,alpha,beta,t,g,d)
    
    y = x+t*d;
    yf = exp(y(1)+y(2)+y(3))+y(1)^2+2*y(2)^2+3*y(3)^2-2*y(1)-7*y(2)-5*y(3);
    while yf > (f + alpha*t*transpose(g)*d)
        t = beta * t;
        y = x+t*d;
        yf = exp(y(1)+y(2)+y(3))+y(1)^2+2*y(2)^2+3*y(3)^2-2*y(1)-7*y(2)-5*y(3);
    end
    new_alpha = t;
end
