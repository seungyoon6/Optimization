%% Range Setting
min(1,2)
max(5,6)

%% Bisection Search to 
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
z=1:1:count;
subplot(2, 1, 1);
plot(z,xlist(z))
fprintf('Root of Output is %d\n',xlist(count));
end

%% Bisection Search to Maximize
function y1 = max(xl,xr)
xlist1 = zeros(20,1);
count1 = 0;
while xr - xl > 10^(-5) %accuracy 10^-5
    count1 = count1 + 1;
    xm1 = 0.5 * (xl + xr)
    
    if (xm1^1.7-1.7^xm1) < 0
        xr = xm1;
    else 
        xl = xm1;
    end
    
    xlist1(count1) = xm1;
end
z1=1:1:count1;
subplot(2, 1, 2);
plot(z1,xlist1(z1))
fprintf('%d\n',xm1);
fprintf('Root of Output is %d\n',xlist1(count1));
end