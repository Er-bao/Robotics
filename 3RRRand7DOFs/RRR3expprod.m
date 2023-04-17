function [T,p,u,v,w] = RRR3expprod(theta,phi,xi,err)
% ָ��������ⷨExponential product
% ���룺һ��֧���������ؽڽ�theta,phi,xi
% �����ĩ������p
% ����ת���ؽ�����uvw
%% �ṹ�����ͳ�ֵ
% u_i =[
%     0.0000
%     0.7660
%    -0.6428];
% v_i =[
%    -1.0000
%     0.0000
%    -0.0000];
% w_i =[
%    -0.0000
%     0.7660
%     0.6428];
%% �ṹ�����ı䣬gamma=60�㣬beta=45��
% u_i =[
%     0.0000
%     0.8660
%    -0.5000];
% v_i =[
%    -1.0000
%     0.0000
%    -0.0000];
% w_i =[
%    -0.0000
%     0.7071
%     0.7071];
%% �ṹ����
    if nargin==3
        err=[0 0 0 0 0 0 0 0 0 0 0 0].';
    end
[gamma,beta,alpha_1,~,eta,~,~,~] = paraconfig(err);
theta1=[0 0 0].';
%% u����
Q_u=cell(1,3);
u=ones(3);
for i=1:3
    Q_u{i}=rotz(pi/2+eta(i))*roty(pi-gamma(i))*floor(rotz(pi/2));
    u_0=[0 0 1].';
    u(:,i)=Q_u{i}*u_0;
end
%% v�������м���ת��ͷ
Q_v=cell(1,3);
v=ones(3);
for i=1:3
    Q_v{i}=Q_u{i}*rotz(theta1(i))*roty(alpha_1(i));
    v_0=[0 0 1].';
    v(:,i)=Q_v{i}*v_0;
end
%% w����
Q_w=cell(1,3);
w=ones(3);
for i=1:3
    Q_w{i}=rotz(pi/2+eta(i))*roty(beta(i))*floor(rotz(-pi/2));
    w_0=[0 0 1].';
    w(:,i)=Q_w{i}*w_0;
end
u_i=u(:,1);
v_i=v(:,1);
w_i=w(:,1);
p_0=[0;0;1];
M=[
    1 0 0
    0 1 0
    0 0 1
    ];
%% ��ĩ������p
p=expprod(u_i,theta)*expprod(v_i,phi)*expprod(w_i,xi)*p_0;
%% ��ĩ��λ��T
T=expprod(u_i,theta)*expprod(v_i,phi)*expprod(w_i,xi)*M;
%% ������ת���ؽ�����uvw
u=u_i;
v=expprod(u_i,theta)*v_i;
w=expprod(u_i,theta)*expprod(v_i,phi)*w_i;
end

