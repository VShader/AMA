%a)
a = [1, -28, 322, -1960, 6769, -13132, 13068, -5040];
b = [1, -21, 175, -735, 1624, -1764, 720];

hold on
fplot(@(x)polyval(a,x), [0.9, 7.1]);
plot(roots(a), 0, 'ro');
plot(roots(polyder(a)), polyval(a,roots(polyder(a))), 'bo');
grid on
title('p7(x)')
hold off

figure(2)
hold on
fplot(@(x)polyval(b,x), [0.9, 6.1]);
plot(roots(b), 0, 'ro');
plot(roots(polyder(b)), polyval(b,roots(polyder(b))), 'bo');
grid on
title('p6(x)')
hold off

%b)
figure(3)
hold on
c = a -[0, b];
fplot(@(x)polyval(c,x), [0.9, 8.1]);
plot(roots(c), 0, 'ro');
plot(roots(polyder(c)), polyval(c,roots(polyder(c))), 'bo');
grid on
title('p7(x) - p6(x)')
hold off