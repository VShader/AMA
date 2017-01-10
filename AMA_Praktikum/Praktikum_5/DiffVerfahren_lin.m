A=[1,2,0;4,5,6;0,8,9];

a=diag(A);
b=diag(A, -1); b=[0;b];
c=diag(A, 1); c=[c;0];

Thomas(a,b,c,[1,2,3])
Thomas_mod(a,b,c,[1,2,3])

function [X,Y]=DiffVerfahren_lin(p_fkt,g_fkt,q_fkt,ab,RB,N,Loeser)
% Differenzenverfahren zur Lösung des Randwertproblems
% y’’+p(x)y’+g(x)y=q(x), y(x0)=y0, y(xN)=yN.
% Eingabe:
%=========
% p_fkt, g_fkt, q_fkt : MATLAB-functions, die die Dgl. definieren
% ab : 2-Vektor; Lösungsintervall [x0,xN]
% RB : 2-Vektor; Randbedingungen [y0,yN]
% N : Integer; Anzahl der äquid. Stützstellen, inkl. x0 und xN.
% Loeser : Nr. des verwendeten Lösers für das tridiagonale Gleichungssystem
% = 1 ==> verwende spdiags(...) und „\“,
% = 2 ==> verwende Thomas-Algorithmus
% = 3 ==> verwende modifizierten Thomas-Algorithmus
% Ausgabe:
%=========
% X : N-Vektor; x-Stellen, für die Näherungswerte der Lösung berechnet wurden.
% Y : N-Vektor; zugehörige Näherungswerte an den Stellen X.
%---------------------------------------------------------------------------------

end

function x=Thomas(a,b,c,r)
n = length(a);
x= zeros(n,1);
for k=2:n
    b(k)=b(k)/a(k-1);
    a(k)=a(k)-b(k)*c(k-1);
end
% L=spdiags([b, ones(n,1), zeros(n,1)], [1, 0 , -1], n, n)';
% U=spdiags([zeros(n,1), a, c], [1, 0 , -1], n, n)';
% full(L*U)

 x(1)=r(1); 
 for k=2:n
     x(k)=r(k)-b(k)*x(k-1);
 end
 x=x(:); x(n)=x(n)/a(n);
 for k=n-1:-1:1
     x(k)=(x(k)-c(k)*x(k+1))/a(k);
 end
end

function x=Thomas_mod(a,b,c,r)
n = length(a);
x= zeros(n,1);
for k=2:n
    b(k)=b(k)/a(k-1);
    a(k)=a(k)-b(k)*c(k-1);
end
gamma=zeros(n, 1);
gamma(1)=1./a(1);
for k=2:n
    gamma(k)=1/(a(k)-b(k)*gamma(k-1)*c(k-1));
end
% L=spdiags([b, 1./gamma, zeros(n,1)], [1, 0 , -1], n, n)';
% D=spdiags([zeros(n,1), gamma, zeros(n,1)], [1, 0 , -1], n, n)';
% M=spdiags([zeros(n,1), 1./gamma, c], [1, 0 , -1], n, n)';
% full(L*D*M)

x(1)=r(1); 
 for k=2:n
     x(k)=gamma(k)*(r(k)-b(k)*x(k-1));
 end
 x=x(:); x(n)=x(n)/a(n);
 for k=n-1:-1:1
     x(k)=x(k)-gamma(k)*c(k)*x(k+1);
 end
end

%Messe 5 mal und 5 mal pro Messung aufrufen (hierfür die Rechenzeit durch 5
%dividieren)