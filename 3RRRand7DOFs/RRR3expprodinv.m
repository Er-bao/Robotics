function [theta,phi,xi] = RRR3expprodinv(T,err)
% ָ��������ⷨExponential product
% ���룺ĩ��λ��T
% �����һ��֧���������ؽڽ�theta,phi,xi
% ����ת���ؽ�����uvw
%% �ṹ�����ͳ�ֵ
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
u_i=u(:,1);
v_i=v(:,1);
w_i=w(:,1);
%% ������wĩ��C�㣬C����ĩ������ϵy����
pc=w_i;
%% pcΪ������2��p��T*pc��������2��q
p=pc;
q=T*pc;
[theta,phi] = subproblem2(p,q,u_i,v_i);
exp3=expprod(-v_i,phi)*expprod(-u_i,theta)*T;
p1=[0 0 1].'+w_i;
q1=exp3*p1;
xi=subproblem1(p1,q1,w_i);
end

