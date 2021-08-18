function [ke] = markedge(ee,ep,et,pp,tt,op)
% mark any constrained/non-manifold edges in tria
ke = zeros(size(ee,1),1); % 0-����, 2-�߽�, 3-
for i = 1 : size(ee,1)
    % �߶˵���
%     ni = ee(i,1); nj = ee(i,2);
    if (ep(i,2)-ep(i,1) == +1) % �ڲ���
%         % ���ڵ�Ԫ
%         ti = et(ep(i,1)+0) ; tj = et(ep(i,1)+1) ;
%         % ���� ti,tj �е���Զ���
%         na = tt(ti,:); na = na(na~=ni & na~=nj);
%         nb = tt(tj,:); nb = nb(nb~=ni & nb~=nj);
%         %  calc. local normals (������תʵ��)
%         ab = pp(nj,:)-pp(na,:); ac = pp(ni,:)-pp(na,:);
%         n1 = cross(ab,ac);
%         ab = pp(ni,:)-pp(nb,:); ac = pp(nj,:)-pp(nb,:);
%         n2 = cross(ab,ac);
%         %  cosine of dihedral angle (squared) (�����)
%         l1 = dot(n1,n1); l2 = dot(n2,n2); aa = dot(n1,n2);
%         aa = aa / sqrt(l1*l2);
%         % geometrically non-manifold edges
%         if (aa < op.atol), ke(i) = +3; end
    else % �߽�� topologically non-maifold edges
        ke(i) = +2;
    end
end
