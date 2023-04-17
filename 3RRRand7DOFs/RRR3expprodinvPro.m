function [theta,phi,xi] = RRR3expprodinvPro(T,err)
% ָ��������ⷨExponential product
% ���룺ĩ��λ��T
% ���������֧���������ؽڽ�theta��3��1��,phi��3��1��,xi��3��1��
% ����ת���ؽ�����uvw
%% ��ʼ��
theta=zeros(3,2);
phi=zeros(3,2);
xi=zeros(3,2);
%% �ṹ����
    if nargin==1
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
%% ���㷴��
for i=1:3
    u_i=u(:,i);
    v_i=v(:,i);
    w_i=w(:,i);
    %% ������wĩ��C�㣬C����ĩ������ϵy����
    pc=w_i;
    %% pcΪ������2��p��T*pc��������2��q
    p=pc;
    q=T*pc;
    for j=1:2
        [theta(i,j),phi(i,j)] = subproblem2(p,q,u_i,v_i,[0 0 0].',j*2-3);
        %% ���һ���ؽڽ�Ϊ������1
        exp3=expprod(-v_i,phi(i,j))*expprod(-u_i,theta(i,j))*T;
        p1=[0 0 1].'+w_i;
        q1=exp3*p1;
        xi(i,j)=subproblem1(p1,q1,w_i);
    end
end
end

