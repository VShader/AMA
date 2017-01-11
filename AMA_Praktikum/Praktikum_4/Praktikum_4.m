%siehe orbitode
%which orbitode


% dlgs = @(y,t)[y(3); y(4); 2.*y(4)+y(1)-myS.*(y(1)+my)./r13 -my.*(y(1)-myS)./r23; -2.*y(3)+y(2)-myS.*(y(2)+my)./r13 -my.*(y(2)-myS)./r23];
% my=5.82./1; myS=1-my;
% r13 = @(y,my)root
clear all; close all; clc


   
Startkoordinaten = [1.2, 0];
Startgeschwindigkeit = [0.000000000000000, -1.049357509830320];
Zeitintervall=[0, 10];
StartSchrittweite=0.015625;
epsabs=1e-010;
Event=2;
eps_Abbruch=0.0005;
Anzahl_akzeptierter_Werte=1018;
Stop_Zeit=6.192072806807441;
Endkoordinaten = [1.199999986725755 0.000101294111974];
Endgeschwindigkeit= [0.000177653523296 -1.049357483596100];
End_Kontroll_Norm = 0.0002045;

[ X, Y, FS ] = RKF_v( @f, Zeitintervall, [Startkoordinaten, Startgeschwindigkeit]', StartSchrittweite, epsabs, Event, eps_Abbruch )

y0 = [1.2; 0; 0; -1.04935750983031990726];

figure(1)
plot(Y(:,1),Y(:,2));grid on;
figure(2)
subplot(2,1,1);plot(X,sqrt((Endkoordinaten(1)-Y(:,1)).^2+(Endkoordinaten(2)-Y(:,2)).^2)); grid on;
subplot(2,1,2);plot(X(1:end-1),diff(X)); grid on;
% figure(3)
% subplot(2,1,1);plot(X,Y(:,1),X,Y(:,2));grid on;
% subplot(2,1,2);plot(X,Y(:,3),X,Y(:,4));
% figure(4)
% plot(X, FS); grid on;
function dydt = f(t,y)
      % Derivative function -- mu and mustar shared with the outer function.
      mu = 1 / 82.45;
      mustar = 1 - mu;
      r13 = ((y(1) + mu)^2 + y(2)^2) ^ 1.5;
      r23 = ((y(1) - mustar)^2 + y(2)^2) ^ 1.5;
      dydt = [ y(3)
         y(4)
         2*y(4) + y(1) - mustar*((y(1)+mu)/r13) - mu*((y(1)-mustar)/r23)
         -2*y(3) + y(2) - mustar*(y(2)/r13) - mu*(y(2)/r23) ];
end