%% Plot NYS cities based on distance matrix
% Load data
load('nycity.mat');

%% squaring
d2=D.^2
%% double centering
n=size(D,1)
J=eye(n)-(1/n)*ones(n)
G=-1/2*J*d2*J
%% SVD
[U,S,V]=svd(G)
P=S(1:2,1:2)
V=V(:,1:2)
C=V*P
%% Plot
scatter(C(:,1),C(:,2))
text(C(:,1),C(:,2),c)
print('cities.png','-dpng')
