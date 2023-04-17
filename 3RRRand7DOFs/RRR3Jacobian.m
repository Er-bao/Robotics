function J = RRR3Jacobian(u,v,w)
%RRR3Jacobian ���������˵��ſ˱Ⱦ���
%   ���룺��ǰ���������˵�����״̬
%   ������ſ˱Ⱦ���
A=[
    cross(v(:,1),w(:,1)).'
    cross(v(:,2),w(:,2)).'
    cross(v(:,3),w(:,3)).'
];
B=diag([
    cross(u(:,1),v(:,1)).'*w(:,1),...
    cross(u(:,2),v(:,2)).'*w(:,2),...
    cross(u(:,3),v(:,3)).'*w(:,3)]);
J=A\B;
end