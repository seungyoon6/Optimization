c = 1;
alpha = 0.5;
beta = 0.5;
t = 1;
x = transpose([0 0]);
x1list = zeros(100,1);
x2list = zeros(100,1);
count = 0;
tol = 10^-5;
al = 0;         %golden section
ar = 1;         %golden section
a1 = 0;         %golden section
a2 = 0;         %golden section

while norm(grad(x))> tol && count < 1000    %GD criteria
    count = count + 1;
    f = object(x);  %Current Object Value
    g = grad(x);    %Gradient Value
    
    % Exact Line Search (Golden search)
    alpha = exact(f,x,al,ar,g);

    xnew = x - alpha*g; %x(k+1)
    x1list(count) = x(1);
    x2list(count) = x(2);
    x = xnew;
end

plot(x1list(1:count),x2list(1:count),'-o');


fprintf('Root of Output is %d %d\n',x1list(count),x2list(count));
fprintf('Optimal Value is %d\n',object(x));

%f function
function f = object(x)
f = exp(1-x(1)-x(2))+exp(x(1)+x(2)-1)+x(1)^2+x(1)*x(2)+x(2)^2+2*x(1)-3*x(2);
end

%gredient of f
function g = grad(x)
g = [-exp(-x(1)-x(2)+1)+exp(x(1)+x(2)-1)+2*x(1)+x(2)+2
    -exp(-x(1)-x(2)+1)+exp(x(1)+x(2)-1)+x(1)+2*x(2)-3];
end

%golden section search
function new_alpha = exact(f,x,al,ar,g)

    phi = (3 - sqrt(5)) / 2;
    xlist = zeros(20,1);
    count = 0;
    
    while (ar - al) > 10^(-5)    
        count = count + 1;
        a1 = phi * ar + (1 - phi) * al; %al'
        a2 = phi * al + (1 - phi) * ar; %ar'
        y1 = x-a1*g;                    %new_x(a1)
        y2 = x-a2*g;                    %new_x(a2)
        fy1 = exp(1-y1(1)-y1(2))+exp(y1(1)+y1(2)-1)+y1(1)^2+y1(1)*y1(2)+y1(2)^2+2*y1(1)-3*y1(2); %new f(x+a1d)
        fy2 = exp(1-y2(1)-y2(2))+exp(y2(1)+y2(2)-1)+y2(1)^2+y2(1)*y2(2)+y2(2)^2+2*y2(1)-3*y2(2); %new f(x+a2d)
        
        if  fy1 < fy2                   %compare f(x+a1d) and f(x+a2d)
            ar = a2;  
        else
            al = a1;   
        end
        xlist(count) = (al + ar) / 2;
    end
    new_alpha = (al + ar) / 2;          %new alpha value
end
