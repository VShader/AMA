%a)
%S = linspace(1, 7, 7)';
S = zeros(1, 7);
for index = 1:7
    S(index) = index;
end

%b)
M = zeros(7, 7);
for indexI = 1:7
    for indexJ = 1:7
        M(indexI, indexJ) = S(indexI).^indexJ;
    end
end

%c)
P = zeros(7, 7);
for indexI = 1:7
    for indexJ = 1:7
        P(indexJ, indexI) = S(indexI).^indexJ;
    end
end