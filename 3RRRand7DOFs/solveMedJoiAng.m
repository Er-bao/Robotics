function [medjoiang,u] = solveMedJoiAng(p,phi)
% �������м����ת�ؽڱ���
% ���룺��е��ĩ��λ��
% λ�ã�p=[px,py,pz].';
% λ�ˣ�phi=[alpha beta gamma].';
% ������м�ؽڱ���
% medjoiang(rad)
%% ������
[~,~,~,~,~,a_3,a_4,d_7] = paraconfig();
% a_3=255;% a_4=260;% d_1=50;
%% �����ĩ������������ζ���
% ��ĩ��λ��ת��Ϊ��ת����
Q=rotz(phi(1))*roty(phi(2))*rotz(phi(3));
% ����ת����ת��Ϊĩ��λ��
v_=Q(:,3);
v=d_7*v_;
w=p;%-[0 0 d_1].';
u=w-v;
%% �����Ҷ�������м�ؽڱ���
a=norm(u);
COSthe=(a_3^2+a_4^2-a^2)/(2*a_3*a_4);
medjoiang=acos(COSthe);
end

