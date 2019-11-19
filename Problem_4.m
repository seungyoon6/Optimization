%% Range Setting
min(1,2)
max(5,6)

%% Bisection Search to Minimize
function y = min(xl,xr)
xlist = zeros(20,1);
count = 0;
while xr - xl > 10^(-5) %accuracy 10^-5
    count = count + 1;
    xm = 0.5 * (xl + xr)
    
    if (xm^1.7-1.7^xm) < 0
        xl = xm;
    else 
        xr = xm;
    end
    
    xlist(count) = xm;
end
fprintf('%d\n',xm);
fprintf('Root of Output is %d\n',xlist(count));
end

%% Bisection Search to Maximize
function y = max(xl,xr)
xlist = zeros(20,1);
count = 0;
while xr - xl > 10^(-5) %accuracy 10^-5
    count = count + 1;
    xm = 0.5 * (xl + xr)
    
    if (xm^1.7-1.7^xm) < 0
        xr = xm;
    else 
        xl = xm;
    end
    
    xlist(count) = xm;
end
fprintf('%d\n',xm);
fprintf('Root of Output is %d\n',xlist(count));
end