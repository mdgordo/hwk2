% Problem 5: Consider using the following functions in your solution.
%
%   rng         Seed random number generator
%   cos         cosine
%   sin         sine
%   rand        uniformly random points on [0,1]
%   randn       random normal mean 0 variance 1 points
%   mean        computes average or mean value
%   ones        creates a vector of ones
%   repmat      replicate and tile an array
%   inv         computes the inverse of array
%   sqrt        square root
%   svd         computes the singular value decomposition
%   figure      creates a figure
%   scatter     creates scatter plot
%   title       creates title
%   colormap    define colormap    
%   hold on     hold current graph
%   axis equal  equal aspect ratio
%   quiver      quiver plot
%   
clear all; close all; clc; 
% Seed the random number generator to you favorite integer, e.g., rng(213);
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
%% Scatter plots
scatter(N(:,1), N(:,2),9,D,'filled','s')
colormap(flipud(parula))
colorbar
title({'Mahalanobis Distance from the mean of points';'rotated 45 degrees around the x-axis with Gaussian noise';'and principal components'})
%% Add Quivers
v1=sqrt(L(1,1)).*P(:,1)
v2=sqrt(L(2,2)).*P(:,2)
hold on
quiver(Mn(1,1),Mn(1,2),v1(1,1),v1(2,1),'Color','k','LineWidth',4)
hold on
quiver(Mn(1,1),Mn(1,2),v2(1,1),v2(2,1),'Color','k','LineWidth',4)
print('mahal pca illustration.png','-dpng')