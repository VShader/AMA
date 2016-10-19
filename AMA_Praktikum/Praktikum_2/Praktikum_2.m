clear all; close all; clc;
% f = @(x,y)-2*x*y^2;
% fstring = func2str(f);
% txt = ['y''=', fstring(7:end)];

g = @(x,yP1,yP,xP)yP1+yP.*(x-xP);

y1 = @(x,y)x+y;
y2 = @(x,y)x-y;
y3 = @(x,y)-2*x.*y.^2;
         

figure(Richtungsfeld([0,1],17,[0,1],17,0.1,y1));
figure(Richtungsfeld([0,2],17,[-1,1],17,0.1,y2));
figure(Richtungsfeld([0,1],21,[0.5,2],11,0.1,y3));
figure(Richtungsfeld([0,-1],21,[0.5,2],11,0.1,y3));