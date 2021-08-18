clc;clear;close all

% ----------- ��ȡ�����ʷ� ----------------
g = [    2  2  2  2  2  2
    0  1  1 -1 -1  0
    1  1 -1 -1  0  0
    0  0  1  1 -1 -1
    0  1  1 -1 -1  0
    1  1  1  1  1  1
    0  0  0  0  0  0];
[pp,~,tt]=initmesh(g,'hmax',1); % ��ʼ������
pp = pp'; tt = tt(1:3,:)';
% showmesh(pp,tt); findnode(pp); findedge(pp,tt); findelem(pp,tt)

pp = [pp, zeros(size(pp,1),1)] ; % Ƕ�뵽��ά
op.etol = +1e-8; % bound merge tolerance
op.atol = 1/2. ; % bound angle tolerance

np = size(pp,1); nt = size(tt,1);

%  ---------------------- �����ʷ����ڵ�Ԫ --------------------
% --- elem2edge ����Ԫ�洢�ı����
NT = size(tt,1);
totalEdge = sort([tt(:,[2,3]); tt(:,[3,1]); tt(:,[1,2])],2);
[ee, ~, totalJ] = unique(totalEdge, 'rows');
elem2edge = reshape(totalJ,NT,3);
% --- ep: ��¼ÿ�������ظ��߼����е�һ�κ͵ڶ��ε���� ����Ȼ�߽����ͬ���ڲ������ 1��
NE = size(ee,1);
ep = zeros(NE,2); 
ep(:,1) = +1; ep(:,2) = accumarray(elem2edge(:),+1); % �ߵĶ� (�� i �ж�Ӧ �� i ���ߣ�
% ���߰��ظ��ţ��� e1, e2,e2, e3 (�����ŵ�, �����У���һ�ж�Ӧ��һλ�ã��ڶ��еڶ�λ��)
ep(:,2) = cumsum(ep(:,2));   % ÿ���ߵڶ��ε����
ep(2:NE,1) = ep(1:NE-1,2)+1; % ÿ���ߵ�һ�ε����
tp = ep(:,1); % ÿ���ߵ�һ�ε����
% ep(NE,2): e1, e2,e2, e3 �������еı���
et = zeros(ep(NE,2),1); 
% ---- et:  �� e1, e2,e2, e3, e4,e4, ... �Ķ�Ӧ��¼ÿ���߶�Ӧ�ĵ�Ԫ��ʵ���Ͼ��� neighbor
for iel = 1 : NT    
    ei = elem2edge(iel,1); % ÿ����Ԫ�ıߵ�������
    ej = elem2edge(iel,2); 
    ek = elem2edge(iel,3);    
    et(tp(ei))=iel;  tp(ei) = tp(ei)+1; 
    et(tp(ej))=iel; tp(ej) = tp(ej)+1;
    et(tp(ek))=iel; tp(ek) = tp(ek)+1;    
end

% ---------------- mark nonmanifold edges (��ά����Ǳ߽��) -------------
ke = zeros(size(ee,1),1); ke(ep(:,1)==ep(:,2)) = 2;

%------------------ node positions ----------
% form tria circum-balls
cc = miniball2(pp,tt); % xr,yr,zr,r
% edge midpoints
pm = (pp(ee(:,1),:) + pp(ee(:,2),:))/2;
% pv
pv = [pp; cc(:,1:3); pm];

%------------ make edges in dual complex --------
ev = makeedge(ee,ep,et,ke,pv,np,nt);

%--------------- remove "short" edges -----------------
[pv,ev] = removeEdges(pv,ev,op);

%--------------- remove un-used nodes -----------------------
[pv,ev] = removeNodes(pv,ev,np);

%----------- make cells in dual complex ---------------------
[cp,ce] = clipcell(ev);

%--------------------------------------- dump extra indexing
ev = ev(:,1:2);

figure;
% subplot(1,2,1); hold on;
% title('Triangulation');
% drawtria2(pp,tt);
% set(gca,'units','normalized','position',[0.01,0.05,.48,.90]);
% axis image off;
% subplot(1,2,2); hold on;
% title('Dual complex');
drawdual2(cp,ce,pv,ev);
% set(gca,'units','normalized','position',[0.51,0.05,.48,.90]);
axis image off;
axis on
node = pv(:,1:2);
node = unique(node,'rows');
findnode(node)

% % node, elem
% node = pv(:,1:2); NT = size(cp,1);
% elemLen = cp(:,3)-cp(:,2);
% totalid = ce(1:sum(elemLen));
% elem = mat2cell(totalid',1,elemLen)';
% figure, showmesh(node,elem);




