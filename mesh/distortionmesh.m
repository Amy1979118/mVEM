clc;clear;close all

[node,elem] = squaremesh([0 1 0 1],1/40,1/40,'rec');

% diameter
NT = size(elem,1);
if ~iscell(elem) % transform to cell
    elem = mat2cell(elem,ones(NT,1),length(elem(1,:)));
end
diameter = cellfun(@(index) max(pdist(node(index,:))), elem);
% random perturbation
xrand = sin(2*pi*node(:,1)).*sin(2*pi*node(:,2));
yrand = xrand;
width = 4;
xrand = 2*width*(xrand-min(xrand))/(max(xrand)-min(xrand)) - width;
yrand = 2*width*(yrand-min(yrand))/(max(yrand)-min(yrand)) - width;
% shift length
tc = 1.3; hmax = max(diameter);
xs = xrand*hmax/2;
ys = yrand*hmax/2;

node = node + tc*[xs, ys];



% isDistortion = ~((node(:,1)==0) | (node(:,1)==1) | (node(:,2)==0) | (node(:,2)==1));
% node(isDistortion,:) = node(isDistortion,:) + tc*[hx(isDistortion), hy(isDistortion)];
showmesh(node,elem);