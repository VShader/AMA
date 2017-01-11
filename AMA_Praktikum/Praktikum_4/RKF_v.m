function [ X, Y, FS ] = RKF_v( dgl, Interv, y0, h0, epsabs, event, eps_Abbruch )
% RungeKuttaFehlberg-Verfahren zur Lösung eines DGLSystems
% 1. Ordnung mit Schrittweitensteuerung;
% Einbettungsformel vgl. Schwarz, Numerische Mathematik S. 389/390
% Eingabe:
% dgl : M-function, die die Differentialgleichung beschreibt
% Interv: Lösungsintervall
% y0 : Spaltenvektor;Anfangswerte, y(Interv(1))=y0;
% h0 : Anfangsschrittweite, mit der gerechnet werden soll
% epsabs: Genauigkeitsschranke für abs. Fehler
% event : > 0 => vorzeitiger Abbruch im k-ten Schritt,
% falls s <= eps_Abbruch
% = 1 : s=norm(Y(k,[3 4])-Y(k,[1 2]),2);    % \ s wird als
% s=min(s,abs(Y(k,3)));                      % > Kontrollnorm
% = 2 : s=norm(Y(k,:)-y0',2);               % / bezeichnet
% eps_Abbruch : siehe "event"
% Ausgabe:
% X : Spalten-Vektor der x-Stellen, an denen die Lsg. berechnet wurde
% Y : Matrix der zugehörigen Lösungswerte; Y(i,k)=k-te Komponente der Lsg.
% an der Stelle X(i)
% FS: Spalten-Vektor der zugehörigen Fehlerschätzungen
%---------------------------------------------------------------
% Implizite Annahme: Es wird "von links nach rechts" gerechnet; ansonsten
% müsste das Programm analog zu Aufgabe 3 erweitert werden.

% for i = Interv[1] : Interv[2]
%     k1=h*dgl(x, y0);
%     k2=h*dgl(x+2/9*h0, y0+2/9*k1);
%     k3=h*dgl(x+1/3*h0, y0+1/12*k1 + 1/4*k2);
%     k4=h*dgl(x+3/4*h0, y0+69/128*k1 - 243/128*k2 + 135/64*k3);
%     k5=h*dgl(x+h0, y0-17/12*k1 + 27/4*k2 - 27/5*k3 + 16/15*k4);
%     k6=h*dgl(x+5/6*h0, y0+65/432*k1 - 5/16*k2 + 13/16*k3 + 4/27*k4 + 5/144*k5);
%
%     y0 = y0+(47/450*k1 + 12/25*k3 + 32/225*k4 + 1/30*k5 + 6/25*k6);
%     D = 1/300*(-2*k1 + 9*k3 -64*k4 -15*k5 + 72*k6);
% end

%dgl=dgl(:);
FS = 0;
h = h0;
x = Interv(1);
y = y0;
X = x;
Y = y';

rc = 0;
if epsabs <= 0
    rc = 1;
    return;
end
% if hmin <= epsabs
%     rc = 2;
%     return;
% end


while Interv(2) - x > 0
    h = min(h, abs(Interv(2) - x));
    
    [xh, Yh, D] = RKF_Schritt(dgl,x,y,h);
    
    
    
    if norm(D, 2) <  epsabs
        % akzeptieren
        x=xh;
        y=Yh;disp(['size(Yh) = ',int2str(size(Yh))])
        FS=[FS;norm(D,2)];
        Y=[Y;Yh'];
        X=[X;xh];
        if event == 1
            s=norm(Yh([3 4])-Yh([1 2]),2);
            s=min(s,abs(Yh(3)));
        elseif event == 2
            s=norm(Yh(:)-y0',2);
        end
        if s <= eps_Abbruch
            return;
        end
        if norm(D, 2)< epsabs/2
            h = 1/0.875*h;
        end
    else
        % NICHT akzeptieren
        h = 0.875*h;
        %         if h < hmin
        %             h = hmin;
        %             rc = 3;
        %         end
    end
end


end


function [x,Y, D]=RKF_Schritt(dgls, x0, y0, h)
% 1 Schritt mit dem Runge-KuttaFehlberg-Verfahren zur Lsg eines DGLSystems (AWA)
% Eingabe
% dgl_fkt : Differentialgleichungssystem als Funktion f(x,y)
% x0 : Startpunkt
% y0 : Anfangswert
% h : Schrittweite, mit der gerechnet werden soll
% Ausgabe:
% x : x0+h
% Y : Zeilenvektor mit Näherungslösung an der Stelle x
% D : Zeilenvektor mit Fehlerschätzung
% Aufrufbeispiel:
% dgl=@(x,y) -2*x*y^2;
% [x,Y]=RKF_Schritt(dgl,0,1,0.25);
%---------------------------------------------------------------

x = x0 + h;
k1=h*dgls(x, y0);
disp(['size(k1) = ',int2str(size(k1))])
disp(['size(y0) = ',int2str(size(y0))])
k2=h*dgls(x+2/9*h, y0+2/9.*k1);
k3=h*dgls(x+1/3*h, y0+1/12.*k1 + 1/4.*k2);
k4=h*dgls(x+3/4*h, y0+69/128.*k1 - 243/128.*k2 + 135/64.*k3);
k5=h*dgls(x+h, y0-17/12.*k1 + 27/4.*k2 - 27/5.*k3 + 16/15.*k4);
k6=h*dgls(x+5/6*h, y0+65/432.*k1 - 5/16.*k2 + 13/16.*k3 + 4/27.*k4 + 5/144.*k5);
Y = y0+(47/450.*k1 + 12/25.*k3 + 32/225.*k4 + 1/30.*k5 + 6/25.*k6);
D = 1/300*(-2.*k1 + 9.*k3 -64.*k4 -15.*k5 + 72.*k6);

end

