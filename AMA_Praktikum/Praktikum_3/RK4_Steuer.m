function [X,Y,FS,rc] = RK4_Steuer(dgl, ab, y0, h0, hmin, epsi)
% RungeKutta(klassisch)-Verfahren zur Lösung AWA
% mit Schrittweitensteuerung.
% Eingabe :
% dgl : Differentialgleichung als Funktion f(x,y)
% ab : 2-Vektor; Lösungsintervall [? ? ,? ??? ]
% y0 : Anfangswert
% h0 : Betrag der Anfangsschrittweite, mit der gerechnet werden soll
% hmin : Betrag der minimal erlaubten Schrittweite; falls hmin unterschritten
%        wird, wird h=hmin und rc=3 gesetzt, aber weitergerechnet!
% epsi : Genauigkeitsschranke für abs. Fehler (relativ zur Schrittw. 1)

% Hinweis: Sei Interv=[a,b].
% Ist a < b, so wird "von links nach rechts" gerechnet.
% Ist a > b, so wird "von rechts nach links" gerechnet.
% h0 kann positiv oder negativ sein, interessant ist nur
% der Betrag von h0. Das Vorzeichen der tatsächlich benutzten
% Schrittweite hängt von der Richtung der Berechnung ab!

% Ausgabe:
% X : Spalten-Vektor der x-Stellen, an denen die Lsg. berechnet wurde
% Y : Spalten-Vektor der zugehörigen Lösungswerte
% FS : Spalten-Vektor der zugehörigen Fehlerschätzungen
% rc : Return-Code;
% = 0, alles OK
% = 1, epsi <= 0
% = 2, hmin <= eps (MATLAB Konstante; Maschinengenauigkeit)
% = 3, Betrag der Schrittweite hätte kleiner hmin gewählt werden müssen,
%   wurde aber auf hmin begrenzt !
% Aufrufbeispiel:
% dgl=@(x,y) -2*x*y^2;
% [X,Y,FS,rc]=RK4_Steuer(dgl,[0,2],1,0.25,1e-5);
%---------------------------------------------------------------

FS = 0;
h = h0;
x = ab(1);
y = y0;
X = x;
Y = y;

rc = 0;
if epsi <= 0
    rc = 1;
    return;
end
if hmin <= eps
    rc = 2;
    return;
end


v = sign(diff(ab));
while v*(x - ab(2)) < 0
    h = min(h, abs(ab(2) - x));
    [xh,Yh] = RK4_Schritt(dgl,x,y,v*h);
    [xh1, Yh1] = RK4_Schritt(dgl, x, y, v*h/2);
    [xh2, Yh2] = RK4_Schritt(dgl, xh1, Yh1, v*h/2);
    D=(Yh2-Yh)/15;
    
    if abs(D) < abs(h) * epsi
        % akzeptieren
        x=x+v*h;
        y=Yh2+D;
        FS=[FS;D];
        Y=[Y;y];
        X=[X;x];
        if abs(D)< abs(h) * epsi/50
            h = 2*h;
        end
    else
        % NICHT akzeptieren
        h = h/2;
        if h < hmin
            h = hmin;
            rc = 3;
        end
    end
end
end