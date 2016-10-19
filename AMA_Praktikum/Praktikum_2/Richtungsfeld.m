function fignr = Richtungsfeld(xx,Nx,yy,Ny,L,dgl_f)
% Richtungsfeld für gew. Differentialgleichung erzeugen
% Eingabe:
% xx = [x_l,x_r] = x-Intervall; 2-Vektor
% Nx = Anzahl Punkte in x-Richtung; Integer
% yy = [y_u,y_o] = y-Intervall; 2-Vektor
% Ny = Anzahl Punkte in y-Richtung; Integer
% L = Länge der Richtungspfeile;
% dgl_f = Function handle für die Funktion f(x,y) der Dgl.
% Ausgabe:
% fignr = Nummer der erzeugten Figur
%______________________________________________________
% Aufrufbeispiel:
% fnr = Richtungsfeld([0,1],11,[0.5,2],11,0.08,@(x,y) -2*x*y^2)
xx = xx(:);
yy = yy(:);
y1 = dgl_f;

txt = func2str(dgl_f);
txt = replace(txt,'@(x,y)','y''=');
txt = erase(txt,'.');
txt = erase(txt,'*');


dx = @(L,y1)0.5*L./sqrt(1+y1.^2);
ys = @(y,m,dx)y+m.*dx.*[-1,1]';
xs = @(x,dx)ys(x,1,dx);

fignr = figure;


x = linspace(xx(1), xx(2), Nx);
for y = linspace(yy(1), yy(2), Ny);
    plot(x,y, 'ob')
    hold on;
    m = y1(x,y);
    delta = dx(L,m);
    plot(xs(x,delta),ys(y,m,delta), 'b');
end
hold off;
title(txt);
end