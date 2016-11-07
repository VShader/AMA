function [x,Y]=RK4_Schritt(dgl_fkt, x0,y0,h)
% 1 Schritt mit dem Runge-Kutta(klassisch)-Verfahren zur Lsg einer gew. DGL (AWA)
% Eingabe
% dgl_fkt : Differentialgleichung als Funktion f(x,y)
% x0 : Startpunkt
% y0 : Anfangswert
% h : Schrittweite, mit der gerechnet werden soll
% Ausgabe:
% x : x0+h
% Y : Näherungslösung an der Stelle x
% Aufrufbeispiel:
% dgl=@(x,y) -2*x*y^2;
% [x,Y]=RK4_Schritt(dgl,0,1,0.25);
%---------------------------------------------------------------

x = x0 + h;
k1 = h*dgl_fkt(x0, y0);
k2 = h*dgl_fkt(x0+0.5*h, y0+0.5*k1);
k3 = h*dgl_fkt(x0+0.5*h, y0+0.5*k2);
k4 = h*dgl_fkt(x0+h, y0+k3);
Y = y0 + (k1+2*k2+2*k3+k4)/6;

end

