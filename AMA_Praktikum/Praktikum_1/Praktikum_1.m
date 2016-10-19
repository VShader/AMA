clear all; close all; clc;
x=1:6;
y=[1,1,1,3,3,3];
y1=zeros(size(y));
xx=linspace(1,6,1025);

for index = 1:5
    switch(index)
        case 1
            txt = 'Not-a-knot-Spline';
            pp = spline(x,y);
        case 2
            txt = 'Vollst. Spline';
            pp = spline(x,[0, y, 0]);
        case 3
            txt = 'Polygonzug';
            pp = Polygonzug(x,y);
        case 4
            txt = 'Pchip';
            pp = pchip(x,y);
        case 5
            txt = 'Hermit';
            pp = hermit(x,y,y1);
    end;
    
    sp=@(x)ppval(pp,x);
    subplot(3,5,index); plot(x,y,'*r', xx, sp(xx)); grid on;
    title(txt)
    pp1=ppder(pp);
    pp2=ppder(pp1);
    sp1=@(x)ppval(pp1,x);
    sp2=@(x)ppval(pp2,x);
    subplot(3,5,index + 5); plot(xx, sp1(xx)); grid on;
    title(['1.Abl. ', txt])
    subplot(3,5,index + 2*5); plot(xx, sp2(xx)); grid on;
    title(['2.Abl. ', txt])

end