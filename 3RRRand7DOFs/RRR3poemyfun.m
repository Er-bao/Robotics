function F = RRR3poemyfun(psi,err)
%RRR3poemyfun ָ����������Ԫ�����Է�����
%   ���룺psi
%   �����������
%% ȫ�ֱ���%3*1����
global thetatheta
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
W1t=expprod(u(:,1),thetatheta(1))*expprod(v(:,1),psi(1))*w(:,1);
W2t=expprod(u(:,2),thetatheta(2))*expprod(v(:,2),psi(2))*w(:,2);
W3t=expprod(u(:,3),thetatheta(3))*expprod(v(:,3),psi(3))*w(:,3);
%% ��ɷ�����
A=norm(W1t-W2t)-norm(w(:,1)-w(:,2));
B=norm(W2t-W3t)-norm(w(:,2)-w(:,3));
C=norm(W3t-W1t)-norm(w(:,3)-w(:,1));
F = [
    A;
    B;
    C;
];

end

