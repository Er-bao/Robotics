function R = expprod(omega,theta)
% ָ��������
% ���룺��λ����omega����ת�Ƕ�theta
% �������ת����
% omega=omega/norm(omega);
R=eye(3)+sin(theta).*skew(omega)+(1-cos(theta)).*(skew(omega)*skew(omega));
end

