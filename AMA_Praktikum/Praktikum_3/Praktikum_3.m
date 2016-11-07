clear all; close all; clc;
dgl1 = @(x,y) -2*x*y^2;
dgl2 = @(x,y) -x^2/y-y/x;


plotRK4(dgl1, [0, 2], 1, 0.5, 1.0e-10, 1.0e-7)
plotRK4(dgl1, [0, -2], 1, 0.5, 1.0e-10, 1.0e-7)
plotRK4(dgl2, [0.5, 0.9], 1, 0.4, 0.004, 1.0e-6)
plotRK4(dgl2, [0.9, 0.5], 0.180205643846340, 0.4, 0.004, 1.0e-6)

function plotRK4(dgl_fkt, ab, y0, h0, hmin, epsi)

functionString = erase(func2str(dgl_fkt), '@(x,y)');
startValueStr = ['y(', num2str(ab(1)), ')=', num2str(y0, 14)];
ex = dsolve(['Dy=',functionString], startValueStr, 'x')
exakt = matlabFunction(ex);

tic;
[X,Y,FS,rc] = RK4_Steuer(dgl_fkt, ab, y0, h0, hmin, epsi);
rZeit = toc;
hmini = min(diff(X));
hmaxi = max(diff(X));

figure()
subplot(2,2,1);
hold on;
plot(X,FS, 'b','Marker','o');
plot(X, exakt(X)-Y, 'r', 'Marker', '*'); title('Fehler');
grid on; legend('Fehlerschätzung', 'Exakter Fehler')
subplot(2,2,2);
stem(X(1:end-1), diff(X), 'Marker', 'none'); title('Schrittweiten'); grid on;
subplot(2,2,3);
hold on;
plot(X, exakt(X), 'r')
plot(X, Y, 'b');
grid on; legend('Exakte Lsg.', 'Näherungslsg.')
title('Exakte und RK-Lösung');
subplot(2,2,4)
hold on;
plot([0,1],[0,8], 'LineStyle','none'); axis off;
text(0,8,['Dgl.: Dy=',functionString]);
text(0,7,['AB : ', startValueStr]);
text(0,6,['[a,b] = [', num2str(ab(1)), ', ', num2str(ab(2)), ']; hmin = ', num2str(hmin)]);
text(0,5,['rc = ', num2str(rc)]);
text(0,4,['epsi = ', num2str(epsi)]);
text(0,3,['hmini/maxi = [', num2str(hmini), ', ', num2str(hmaxi),']']);
text(0,2,['Anzahl Werte = ', num2str(length(X))]);
text(0,1,['Rzeit = ',num2str(rZeit), ' sec']);
text(0,0,['Exakt: y(x) = ', erase(func2str(exakt), '@(x)')]);
end