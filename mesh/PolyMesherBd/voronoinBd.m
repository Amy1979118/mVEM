function [V,C] = voronoinBd(P,Pb)
% voronoinBd returns Voronoi vertices V and the Voronoi cells C 
%   of the Voronoi diagram of P with convex polytopal boundary constrained 
%   by Pb. 
%
%  Copyright (C) Terence Yu
%  Ref: https://github.com/hyongju/Polytope-bounded-Voronoi-diagram

NT = size(P,1);   

%% Get inequality constraints of convex polytope boundary
K = convhull(Pb);
Pb = Pb(K,:);
[Ab,bb] = vert2lcon(Pb);

%% Obtain inequality constraints of each Voronoi cell
% Delaunay triangulation of seeds
Tri = delaunay(P);
Tricol = Tri'; Tricol = Tricol(:);
% inequality constraints
A = cell(NT,1);  b = cell(NT,1);
for iel = 1:NT
    % find neighboring seeds of iel-th seed
    ix = ceil(find(Tricol==iel)/size(Tri,2));
    id = Tri(ix,:);  id = id(:); id = id(id~=iel);
    % construct inequality constraints using perpendicular bisector
    [A{iel},b{iel}] = pbisec(P(iel,:), P(id,:));
end
% add boundary constraints
Aaug = cellfun(@(a) [a;Ab], A, 'un', false);
baug = cellfun(@(b) [b;bb], b, 'un', false);

%% Derive node and convex hull of each cell - elemTri
% vertices of each cell
VV = cell(NT,1);
for iel = 1:NT
    V = con2vert(Aaug{iel},baug{iel});
    ID = convhull(V);  % note: ID(1) = ID(end), e.g. ID = [1 2 5 9 1]
    VV{iel} = V(ID(1:end-1),:); 
end
% node
V = vertcat(VV{:});  
tol = 1e-7;
[V, ~, J] = uniquetol(V,tol, 'ByRows',true);
% index of each cell
elemLen = cellfun('length',VV);
C = mat2cell(J',1,elemLen)';
% Note: �ڲ������� seeds ʱ, Voronoi ��Ԫ�Ѿ��ǹ̶���, ������
%       [V, ~, J] = uniquetol(V,tol, 'ByRows',true);
% ȥ���ظ�ʱ, ����Ҫ���⿼�� VV ÿ����Ԫȥ���ظ�������. 
% ��ʵ��, ���ַǳ�������ԭ����, ��Ԫ����ʹ���Ż��㷨 (con2vert.m) ����, 
% ����ͬ��Ԫ�Ͽ��ܳ���һ��С���, ���Ǳ�������һ����.