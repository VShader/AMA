Aufgabe_3

%a)
A+A
%A.+A   Matrix Addition ist immer Elementweise
%A+B    Falsche Dimensionen
B+B
%B.+B   Matrix Addition ist immer Elementweise
C+C
%C.+C   Matrix Addition ist immer Elementweise

%b)
A.*A

%c)
%A.*B   Falsche Dimensionen

%d)
AB = A*B
BA = B*A
AC = A*C
CB = C*B
CC = C*C

%e)
%A^2    Falsche Dimensionen
%B^2    Falsche Dimensionen
for index = 1:10
    figure(index)
    spy(C^index)
end