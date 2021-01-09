clc;clear;close all

load meshex1
figure,
% ��ʼ�ʷ�
showmesh(node,elem);
findnode(node); 
% findelem(node,elem);

% �� 1 �μ���
figure,
elemMarked = [2,5];
[node,elem] = PolyMeshRefine(node,elem,elemMarked);
showmesh(node,elem);
findnode(node,'noindex');
% findelem(node,elem);
%
% �� 2 �μ���
figure,
elemMarked = [10];
[node,elem] = PolyMeshRefine(node,elem,elemMarked);
showmesh(node,elem);
findnode(node,'noindex');
% findelem(node,elem);
%
% �� 3 �μ���
figure,
elemMarked = [10,15,3,4,8,5,1];
[node,elem] = PolyMeshRefine(node,elem,elemMarked);
showmesh(node,elem);
findnode(node,'noindex');
% findelem(node,elem);

