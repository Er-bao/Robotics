function [u,v,w] = RRR3getuvw(Q,err)
%% RRR3getuvw 3RRR���������˷������ӻ�ȡuvw����
% ���룺
% Q����ƽ̨λ��
% �����u,v,w
% theta����ƽ̨�ؽڽ�
%% �ṹ����
    if nargin==1
        err=[0 0 0 0 0 0 0 0 0 0 0 0].';
    end
[gamma,beta,alpha_1,alpha_2,eta,~,~,~] = paraconfig(err);
%% �������
% w����
% ���ƶ�ƽ̨MP�����ʼλ��ʱ��
% w_i������p��ת(pi/2+eta_i),��������y��תbeta
% ��������z��ת(-pi/2)�����������ת�ؽڳ�ʼλ��
% eta_i=(i-1)*2/3*pi,i=1,2,3
Q_w=cell(1,3);
w=ones(3);
w_0=[0 0 1].';
p_0=[0 0 1].';
p=Q*p_0;
theta1=ones(2,3);
theta=ones(3,1);
for i=1:3
    % w����
    % ���ƶ�ƽ̨MP�����ʼλ��ʱ��
    % w_i������p��ת(pi/2+eta_i),��������y��תbeta
    % ��������z��ת(-pi/2)�����������ת�ؽڳ�ʼλ��
    % eta_i=(i-1)*2/3*pi,i=1,2,3
    Q_w{i}=Q*rotz(pi/2+eta(i))*roty(beta(i))*floor(rotz(-pi/2));
    w(:,i)=Q_w{i}*w_0;
    % ����theta
    % ��U,V,W
    w_x=w(1,i);
    w_y=w(2,i);
    w_z=w(3,i);
    U=-sin(alpha_1(i))*sin(eta(i))*w_y-sin(alpha_1(i))*cos(eta(i))*w_x;
    V=sin(alpha_1(i))*cos(gamma(i))*cos(eta(i))*w_y-sin(alpha_1(i))*cos(gamma(i))*sin(eta(i))*w_x+sin(alpha_1(i))*sin(gamma(i))*w_z;
    W=w_y*cos(alpha_1(i))*sin(gamma(i))*cos(eta(i))-w_x*cos(alpha_1(i))*sin(eta(i))*sin(gamma(i))-w_z*cos(alpha_1(i))*cos(gamma(i))-cos(alpha_2(i));
    % ��A,B,C
    A=W-U;
    B=2*V;
    C=W+U;
    sol=[-B+sqrt(B^2-4*A*C);-B-sqrt(B^2-4*A*C)];
    theta1(:,i)=2*atan2(sol,2*A);
    theta(i)=theta1(1,i);
end
%% u����
% u_i������z��ת(pi/2+eta),��������y��ת(pi-gamma(i))
% ��������z��ת(pi/2)�����������ת�ؽڳ�ʼλ��
% eta=(i-1)*2/3*pi,i=1,2,3
Q_u=cell(1,3);
u=ones(3);
for i=1:3
    Q_u{i}=rotz(pi/2+eta(i))*roty(pi-gamma(i))*floor(rotz(pi/2));
    u_0=[0 0 1].';
    u(:,i)=Q_u{i}*u_0;
end
%% v�������м���ת��ͷ
% ������ת��ʼ�ؽ�u_i������z����תtheta,����y����ת�ṹ����alpha_1(i),�Ӷ��õ�v_i
% v_i:u_i�ƻ����ؽ�����ϵz����תtheta,������������ϵy��תalpha_1(i)
% Q_v=Q_u*rotz(theta+pi/2)*roty(alpha_1);%ΪʲôҪ��һ��pi/2������
Q_v=cell(1,3);
v=ones(3);
for i=1:3
    Q_v{i}=Q_u{i}*rotz(theta(i))*roty(alpha_1(i));
    v_0=[0 0 1].';
    v(:,i)=Q_v{i}*v_0;
end
end

