function [cp,ce,pv,ev] = makedual2(pp,tt,varargin)

% pv: ��ż����Ķ�������
% ev: ��ż����ߵĶ������
% ��ż������ص���: ÿһ�������൱�����ģ���Ӧһ����Ԫ (���ܴ����ںϵ�)

% ce: ����Ԫ��ֱģʽ��¼�ߵı��, �� elem2edge ��ֱ
% cp: - NT * 3
%     - 2,3 �и���ÿ����Ԫ�ߵ���Ȼ������У��� ce �������� �����������žͿ��Ի�ñߵĶ����ţ���ͨ�� ev��
%     - 1 �и�����Ԫ��Ӧ�����ı�ţ�ԭ�ڵ㣩

% ���ϣ�ce ----- elem2edge ��ֱ
%       
%   Darren Engwirda : 2014 --
%   Email           : engwirda@mit.edu
%   Last updated    : 17/12/2014

%----------------------------------- extract optional inputs
    ec = []; op = [];

%---------- x-y ƽ������Ƕ�뵽 R^3 -------------
    if (size(pp,2) == +2)
        pp = [pp, zeros(size(pp,1),1)] ;
    end
    op.etol = +1e-8; % bound merge tolerance
    op.atol = 1/2. ; % bound angle tolerance
 
    np = size(pp,1);
    nt = size(tt,1);
%------------ �����ʷ����ڵ�Ԫ --------------
% ee: edge
% ep: e1, e2,e2, e3, .... ��¼˳��
% et: ��������˳���¼��Ԫ��ţ��� neighbor
    [ee,~,ep,et] = triaconn2(tt);
%------------------------------------ mark nonmanifold edges      
    [ke] = markedge(ee,ep,et,ec,pp,tt,op);
%------------------------------------ form tria circum-balls
    [cc] = miniball2(pp,tt); % xr,yr,zr,r
%-------------------------------------------- edge midpoints    
    [pm] = (pp(ee(:,1),:) + pp(ee(:,2),:))/2;
%-------------------------------------------- node positions
    [pv] = [pp; cc(:,1:3); pm];
%-------------------------------- make edges in dual complex
    [ev] = makeedge(ee,ep,et,ke,pv,np,nt);
%-------------------------------------- remove "short" edges
    [pv,ev] = removeEdges(pv,ev,op);
%-------------------------------------- remove un-used nodes
    [pv,ev] = removeNodes(pv,ev,np);
%-------------------------------- make cells in dual complex
    [cp,ce] = clipcell(ev)  ;
%--------------------------------------- dump extra indexing
    [ev] = ev(:,1:2);
   
end


