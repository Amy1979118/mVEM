clc;clear;close all
% -------------- Given triangulation ------------------
g = [2  2  2  2  2  2
    0  1  1 -1 -1  0
    1  1 -1 -1  0  0
    0  0  1  1 -1 -1
    0  1  1 -1 -1  0
    1  1  1  1  1  1
    0  0  0  0  0  0];
[pp,~,tt]=initmesh(g,'hmax',1); % ��ʼ������
pp = pp'; tt = tt(1:3,:)';
showmesh(pp,tt); findnode(pp);
findelem(pp,tt)
findedge(pp,tt);

nt = size(tt,1); np = size(pp,1);

% -------------- �������ݽṹ ------------------
% edge, bdEdge
totalEdge = sort([tt(:,[2,3]); tt(:,[3,1]); tt(:,[1,2])],2);
[i,j,s] = find(sparse(totalEdge(:,2),totalEdge(:,1),1));
edge = [j,i]; bdEdge = edge(s==1,:);
% elem2edge
[~, i1, totalJ] = unique(totalEdge,'rows');
elem2edge = reshape(totalJ,nt,3);
% edge2elem
totalJelem = repmat((1:nt)',3,1);
[~, i2] = unique(totalJ(end:-1:1),'rows');
i2 = length(totalEdge)+1-i2;
edge2elem = totalJelem([i1,i2]);
% node2elem 
t2v = sparse([1:nt,1:nt,1:nt], tt, 1, nt, np);
node2elem = cell(np,1);
for iel = 1:np
    % triangle id
    index = find(t2v(:,iel))'; T = tt(index,:);
    nv = length(index);
    % �ߴ��������������
    eT = tt(index,:)'; eT(eT==iel) = [];
    eT = reshape(eT,2,[])';
    % cyclic order
    rows = zeros(nv,1); rows(1) = 1; % ��¼�߽�ߵ���Ȼ˳��
    previous = eT(1,1); current = eT(1,2);
    for s = 1:nv-1
        [ii,jj] = find(eT==current);
        rows(s+1) = ii(ii~=rows(s));
        next = eT(rows(s+1),:); next = next(next~=current);
        current = next;
    end
    % 
    node2elem{iel} = index(rows);
end

% ------------- nodes in dual mesh --------------
% inner dual nodes: centroid of triangles
v1 = tt(:,1); v2 = tt(:,2); v3 = tt(:,3);
nodeCd = 1/3*(pp(v1,:)+pp(v2,:)+pp(v3,:));
% boundary dual nodes: mid-points of boundary edges
ev1 = pp(bdEdge(:,1),:); ev2 = pp(bdEdge(:,2),:);
nodeBd = (ev1 + ev2)/2;
% dual nodes
node = [nodeCd; nodeBd];

% ------------------ ��ż��Ԫ��ŵķ��� ------------------
% �߽絥Ԫ
bdId = unique(bdEdge)';  % row vector
% �ڲ���Ԫ
temp = true(np,1); temp(bdId) = false;
innerId = find(temp)';  % row vector

NT = np; elem = cell(NT,1);
% ------------------ �����ڲ���Ԫ -----------------
for iel = innerId
    elem{iel} = node2elem{iel};
end

% ------------------ ����߽絥Ԫ ------------------
NE = size(bdEdge,1);
iel = bdId(1)

% ��ʼ�߽����ż���Ӧ��Ԫ
[ii,~] = find(bdEdge==iel);
e0 = ii(1); T0 = edge2elem(e0); eN = ii(2);
% ����˳��
index = node2elem{iel};
aj = find(index==T0);
if aj>1
    index = index(end:-1:1);
end
% elem{iel} = [iel+nt,e0+nt,index,eN];

% %
% % % % % subplot(1,2,2),
figure,showmesh(node,elem)


