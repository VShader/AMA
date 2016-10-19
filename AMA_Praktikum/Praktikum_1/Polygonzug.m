function pp = Polygonzug( x,y )
%pp-Form eines Polygonzugs durch die Punkte (x(i),y(i))

y=y(:);
x=x(:);
d=diff(y) ./ diff(x);
Keoffs=[d,y(1:end-1)];
pp=mkpp(x,Keoffs);
end

