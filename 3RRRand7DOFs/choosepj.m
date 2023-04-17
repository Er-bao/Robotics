function [pj,pd] = choosepj(u)
% ȡһ����ƽ̨���������
% ˳�������Ӧ�Ķ�ƽ̨�������
%% ����
[~,~,~,~,~,a_3,a_4,~] = paraconfig();
% a_3=255;
% a_4=260;
% d_1=50;
%% ���
a=norm(u);
u_=[u(1) u(2) 0].';
ax=rotz(-pi/2)*u_;
anguu_=atan2(u(3),sqrt(u(1).^2+u(2).^2));
% ��u��ת��z����
u2_=expprod(ax,pi/2-anguu_)*u;

ufan=-u_/norm(u_);
COSthe1=(a_3^2+a^2-a_4^2)/(2*a_3*a);
theta1=acos(COSthe1);
pj_=[ufan(1) ufan(2) tan(pi/2-theta1)*(ufan(1)^2+ufan(2)^2)].';
% ��u��ת����
pj=expprod(ax,-(pi/2-anguu_))*pj_;
pj=pj/norm(pj);
pd_=u-a_3*pj;
pd=pd_/norm(pd_);
end

