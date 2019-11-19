clc;clear;close all
tic;
% ------------- Mesh --------------------
% generated by meshfun.m in tool
load meshdata.mat; % rectangle
%load meshdataCircle.mat;  % circle
figure, showmesh(node,elem);
%findnode(node); % findelem(node,elem);

% ---------------- PDE data -----------------------
pde = elasticitydata();
bdStruct = setboundary(node,elem);

% ------- Solve the problem -----
u = elasticityVEM_displacement(node,elem,pde,bdStruct);

% --------- error analysis -------
u = reshape(u,[],2);
uexact = pde.uexact;  ue = uexact(node);
id = 1;
figure,
subplot(1,2,1), showsolution(node,elem,u(:,id));
zlabel('u');
subplot(1,2,2), showsolution(node,elem,ue(:,id));
zlabel('ue');
Eabs = u-ue;  % Absolute errors
figure,showsolution(node,elem,Eabs(:,id)); zlim('auto');
format shorte
Err = norm(Eabs)./norm(ue)
toc