function [R,psi,u,vt,wt] = RRR3expprodPro(q,err)
% ָ��������ⷨExponential product
% ���룺һ��֧���������ؽڽ�theta,phi,xi
% �����ĩ������p
% ����ת���ؽ�����uvw
global thetatheta
thetatheta=q;
psi=fsolve(@RRR3poemyfun,[0.00001 0.00001 0.00001].');
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
%% ������
w1t=expprod(u(:,1),thetatheta(1))*expprod(v(:,1),psi(1))*w(:,1);
w2t=expprod(u(:,2),thetatheta(2))*expprod(v(:,2),psi(2))*w(:,2);
w3t=expprod(u(:,3),thetatheta(3))*expprod(v(:,3),psi(3))*w(:,3);
w12=w2t-w1t;
w13=w3t-w1t;
R(:,3)=cross(w12,w13)/norm(cross(w12,w13));
w23=w3t-w2t;
R(:,1)=w23/norm(w23);
R(:,2)=cross(R(:,3),R(:,1));
%% uvw
wt=[w1t w2t w3t];
v1t=expprod(u(:,1),thetatheta(1))*v(:,1);
v2t=expprod(u(:,2),thetatheta(2))*v(:,2);
v3t=expprod(u(:,3),thetatheta(3))*v(:,3);
vt=[v1t v2t v3t];
end

