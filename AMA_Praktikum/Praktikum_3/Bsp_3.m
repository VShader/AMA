clear all; close all; clc
format long;

dgl = @(x,y)-2*x.*y.^2; y0=1;  ab=[0,1];
exakt = @(x)1./(1+x.^2);
x0 = ab(1);
h = 0.1;
[xh,Yh] = RK4_Schritt(dgl,x0,y0,h)
[xh1, Yh1] = RK4_Schritt(dgl, x0, y0, h/2)
[xh2, Yh2] = RK4_Schritt(dgl, xh1, Yh1, h/2)
D=(Yh2-Yh)/15;