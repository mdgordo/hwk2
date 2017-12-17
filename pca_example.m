%% Create some random points and find principal components
%% Generate 1000 random points and rotation matrix (pi/4)
rng(3)
X=10.*rand(1000,1)
C=[X zeros(1000,1)]
R=[cos(pi/4) -sin(pi/4); sin(pi/4) cos(pi/4)]
%% Rotate points
for i=1:1000
    Q=C(i,:)
    T=R*Q'
    M(i,:)=T'
end
%% add noise
N=M+(randn([1000,2]))
%% find mean and covariance
Mn=[mean(N(:,1)) mean(N(:,2))]
Co=cov(N)
%% compute Mahalanobis distances
for i=1:1000
    D(i,:)=(N(i,:)-Mn)*inv(Co)*(N(i,:)-Mn)'
end
%% Find eigenvalues and eigenvectors of Co
[P,L]=eig(Co)
%% plot points
scatter(N(:,1), N(:,2),9,D,'filled','s')
colormap(flipud(parula))
colorbar
title({'Mahalanobis Distance from the mean of points';'rotated 45 degrees around the x-axis with Gaussian noise';'and principal components'})
%% Add Quivers along principal components
v1=sqrt(L(1,1)).*P(:,1)
v2=sqrt(L(2,2)).*P(:,2)
hold on
quiver(Mn(1,1),Mn(1,2),v1(1,1),v1(2,1),'Color','k','LineWidth',4)
hold on
quiver(Mn(1,1),Mn(1,2),v2(1,1),v2(2,1),'Color','k','LineWidth',4)
print('mahal pca illustration.png','-dpng')
