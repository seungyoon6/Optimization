cvx_begin
variables x1 x2 x3;
    maximize x1+2*x2
    subject to
    x1 <= 100;
    2*x2 <= 200;
    x1+x2<=150;
    [x1,x2]>=0;
    cvx_end
    [x1 x2]
    cvx_optval
    