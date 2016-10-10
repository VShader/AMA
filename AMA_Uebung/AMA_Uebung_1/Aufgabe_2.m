%a)
X = linspace(-4, 4, 1025);

%b)
fAn = @(x)x.^3+2*x.^2;
fIn = inline('x.^3+2*x.^2');
YAn = fAn(X);
YIn = fIn(X);

%c)
plot(X, YAn)
title('Anonymous function')
xlabel('x-Achse')
ylabel('y-Achse')
figure(2)
plot(X, YIn)
title('Inline function')
xlabel('x-Achse')
ylabel('y-Achse')

%d)
figure(3)
fn = @(x,n)x.^n;
for index = 1:5
    fplot(@(x)fn(x, index), [-1, 1]);
    hold on
end
title('For Loop')
xlabel('x-Achse')
ylabel('y-Achse')
hold off