%% Load data
load('bunny.mat');

%% Example: plotting bunny
figure;
imshow(reshape(X(1,:),sz),'initialmagnification','fit');
title('First bunny');
print('first_bunny.png','-dpng');


%% Example: making 3d scatter plot
figure;
scatter3(1:10,1:10,1:10,24,1:10);
colormap('jet')
print('3d_scatter.png','-dpng');

%% plot 'mean' bunny image

M=mean(X)
imshow(reshape(M(1,:),sz),'initialmagnification','fit');
title('Mean bunny');
print('mean_bunny.png','-dpng');

%% Implement MDS algorithm
%% Centering

C=bsxfun(@minus,X,M)

%% eigenvalues and eigenvectors

[U,S,V]=svd(C,'econ')

%% Projection Matrix

P=C*V(:,1:3)

%% 3D scatter

scatter3(P(:,1),P(:,2),P(:,3),24,theta)
colormap('jet')
title('PCA Coordinates')
print('pca_coordinates.png','-dpng');

%% MDS
D=pdist(X)
Z=squareform(D)
% squaring
sq=Z'*Z
% double centering
n=size(Z,1)
J=eye(n)-(1/n)*ones(n)
G=-1/2*J*sq*J

%% SVD
[U2,S2,V2]=svd(G,'econ')
P2=G*V2(:,1:3)

%% 3D scatter

scatter3(P2(:,1),P2(:,2),P2(:,3),24,theta)
colormap('jet')
title('MDS Coordinates')
print('mds_coordinates.png','-dpng');

