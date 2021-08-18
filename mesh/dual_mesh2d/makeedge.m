function [ev] = makeedge(ee,ep,et,ke,pv,np,nt)
%  assemble edge segments in cells of dual complex

nn = ep(:,2)-ep(:,1)+1 ; % �ߵĶ�
ev = zeros(sum(nn)*3,4);
% ev �� ���У�ǰ���ж�Ӧ��ż�ߣ������ж�Ӧ��ż�ߵ������δ�ֱ�� (���ظ���)

ne = +0;
for i = 1 : size(ee,1)
    % adj. nodes
    ni = ee(i,1); nj = ee(i,2); 
    mi = i+nt+np; % mi ��ʾ���Ŷ�������ĵ�˳�����
    % assemble dual cells
    if (ke(i) == +0) % �ڲ���
        % adj. trias
        ti = et(ep(i,1)+0)+np;   tj = et(ep(i,1)+1)+np; % ���Ľ��Ŷ������
        % add dual tria-tria segment
        ne = ne+1;
        ev(ne,1) = ti ; ev(ne,2) = tj ; % ���������δ�ֱƽ���ߣ������������Ƕ���
        ev(ne,3) = ni ; ev(ne,4) = nj ; % ��ֱ�ߵ�����յ�
        
    else % �߽��
        % add dual node-edge segment
        ne = ne+1;
        ev(ne,1) = mi ; ev(ne,2) = ni ;
        ev(ne,3) = ni ; ev(ne,4) = +0 ;
        ne = ne+1;
        ev(ne,1) = nj ; ev(ne,2) = mi ;
        ev(ne,3) = nj ; ev(ne,4) = +0 ;
        for ti = ep(i,1) : ep(i,2)
            % add dual tria-edge segment
            tc = et(ti); tc = tc+np ;
            ne = ne+1;
            ev(ne,1) = tc ; ev(ne,2) = mi ;
            ev(ne,3) = ni ; ev(ne,4) = nj ;
        end
    end
end
%  trim allocation per demand
ev = ev(1:ne,:);