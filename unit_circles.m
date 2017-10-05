%% Euclidean
fimplicit(@(x,y) x.^2+y.^2-1)
grid on
%% Manhattan
fimplicit(@(x,y) abs(x)+abs(y)-1)
grid on
%% Supremum
fimplicit(@(x,y) max(x,y)-1, [-2 2 -2 2])
grid on
%% Lp 2/3
fimplicit(@(x,y) (abs(x).^(2./3)+abs(y).^(2./3)).^(3/2)-1)
grid on
%% Mahalanobis
S=[2 .5; .5 1]
C=inv(S)
fimplicit(@(x,y) sqrt([x y]*C*[x y]')-1)
grid on
    
