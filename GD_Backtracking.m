c = 1;
alpha = 0.5;
beta = 0.5;
t = 1;
x = transpose([0 0]);
x1list = zeros(100,1);
x2list = zeros(100,1);
count = 0;
tol = 10^-5;

while norm(grad(x))> tol && count < 1000
    count = count + 1;
    f = object(x); %Current Object Value
    g = grad(x);   %Gradient Value
    
    % Backtracking Line Search
    alpha = backtracking(f,x,alpha,beta,t,g);
    xnew = x - alpha*g;
    x1list(count) = x(1);
    x2list(count) = x(2);
    x = xnew;
end

plot(x1list(1:count),x2list(1:count),'-o');


fprintf('Root of Output is %d %d\n',x1list(count),x2list(count));
fprintf('Optimal Value is %d\n',object(x));

%Object Function
function f = object(x)
f = exp(1-x(1)-x(2))+exp(x(1)+x(2)-1)+x(1)^2+x(1)*x(2)+x(2)^2+2*x(1)-3*x(2);
end

%Object Gradient
function g = grad(x)
g = [-exp(-x(1)-x(2)+1)+exp(x(1)+x(2)-1)+2*x(1)+x(2)+2
    -exp(-x(1)-x(2)+1)+exp(x(1)+x(2)-1)+x(1)+2*x(2)-3];
end

%Backtracking
function new_alpha = backtracking(f,x,alpha,beta,t,g)
    
    y = x-t*g;
    yf = exp(1-y(1)-y(2))+exp(y(1)+y(2)-1)+y(1)^2+y(1)*y(2)+y(2)^2+2*y(1)-3*y(2);
    while yf > f - alpha*t*(norm(g)^2)
        t = beta * t;
        y = x-t*g;
        yf = exp(1-y(1)-y(2))+exp(y(1)+y(2)-1)+y(1)^2+y(1)*y(2)+y(2)^2+2*y(1)-3*y(2);
    end
    new_alpha = t;
end
