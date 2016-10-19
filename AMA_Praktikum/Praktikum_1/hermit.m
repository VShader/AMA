function pp = hermit( x, y, y1 )
%hermit
x=x(:);y=y(:);y1=y1(:);
h=diff(x);
alpha = diff(y)./h;
beta1 = (alpha - y1(1:end-1))./h;
beta2 = (y1(2:end) - alpha)./h;
gamma = (beta2 - beta1)./h;

c = beta1 - h.*gamma;

pp = mkpp(x, [gamma, c, y1(1:end-1), y(1:end-1)]);

end

