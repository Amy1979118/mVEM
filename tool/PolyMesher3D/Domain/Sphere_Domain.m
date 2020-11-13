%------------- PolyMesher -------------------%
% Ref: Բ������
% �޸� BdBox,dCircle ����
%--------------------------------------------%
function [x] = Sphere_Domain(Demand,P)
BdBox = [-1 1 -1 1 -1 1];
switch(Demand)
    case('Dist');  x = DistFnc(P,BdBox);
    case('BdBox'); x = BdBox;
end
%--------- the signed distance function ----------
function Dist = DistFnc(P,BdBox)
Dist = dSphere(P,0,0,0,1);