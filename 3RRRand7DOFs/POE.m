function expLtheta = POE(L,theta)
%POE 4*4ָ��������
%   ���룺�ؽ�����ʸ��L=[r��w w].'
%   �����ָ��������expLtheta
expLtheta=eye(4);
exp=expprod(L(4:6),theta);
expLtheta(1:3,1:3)=exp;
%% ���ֲ�ͬ���������ָ��
expLtheta(1:3,4)=(eye(3)-exp)*cross(L(4:6),L(1:3))+L(4:6).'*L(1:3)*theta*L(4:6);
%% �ڶ��ַ���
% Gtheta=eye(3)*theta+(1-cos(theta)).*skew(L(4:6))+(theta-sin(theta)).*(skew(L(4:6))*skew(L(4:6)));
% expLtheta(1:3,4)=Gtheta*L(1:3);
end

