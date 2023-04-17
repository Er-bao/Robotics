function [theta,psi,u,v,w] = RRR3inverse(phi,err)
%% RRR3inverse 3RRR���������˷������
% ���룺
% phi����ƽ̨λ��z-y-zŷ���Ƕ�
% �����theta,psi
% theta����ƽ̨�ؽڽ�
% psi���м�ؽڽ�
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
Q=rotz(phi(1))*roty(phi(2))*rotz(phi(3));
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
    if theta1(1,i)>pi
        theta(i)=theta1(1,i)-2*pi;
    elseif theta1(1,i)<-pi
        theta(i)=theta1(1,i)+2*pi;
    else
        theta(i)=theta1(1,i);
    end
end
%% u����
% u_i������z��ת(pi/2+eta),��������y��ת(pi-gamma)
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
% ������ת��ʼ�ؽ�u_i������z����תtheta,����y����ת�ṹ����alpha_1,�Ӷ��õ�v_i
% v_i:u_i�ƻ����ؽ�����ϵz����תtheta,������������ϵy��תalpha_1
% Q_v=Q_u*rotz(theta+pi/2)*roty(alpha_1);%ΪʲôҪ��һ��pi/2������
Q_v=cell(1,3);
v=ones(3);
for i=1:3
    Q_v{i}=Q_u{i}*rotz(theta(i))*roty(alpha_1(i));
    v_0=[0 0 1].';
    v(:,i)=Q_v{i}*v_0;
end

%% ���ʼpsi
% ��ֱ����
uv=cross(v,u);
vw=cross(w,v);
% ֮ǰ����ˣ�Ӧ�������ǣ�����
% �÷���������
psi=ones(3,1);

for i=1:3
    psi(i)=acos(dot(uv(:,i),vw(:,i))/(norm(uv(:,i))*norm(vw(:,i))));
end
%% ��ͼ
% hold on
% view([6,2,2]);
% limit=[-1,1];xlim(limit);ylim(limit);zlim(limit);
% plot3(0,0,0,'yo','MarkerFaceColor','k')
% plot3(p(1),p(2),p(3),'yo','MarkerFaceColor','k')
% for i=1:3
%     plot3(u(1,i),u(2,i),u(3,i),'yo','MarkerFaceColor','b')
%     plot3(v(1,i),v(2,i),v(3,i),'yo','MarkerFaceColor','r')
%     plot3(w(1,i),w(2,i),w(3,i),'yo','MarkerFaceColor','g')  
%     
%     plot3([0,u(1,i)],[0,u(2,i)],[0,u(3,i)],'b--')
%     plot3([0,w(1,i)],[0,w(2,i)],[0,w(3,i)],'k--')
%     plot3([u(1,i),u(1,ceil(mod(i+1,3.1)))],[u(2,i),u(2,ceil(mod(i+1,3.1)))],[u(3,i),u(3,ceil(mod(i+1,3.1)))],'b--')    
%     plot3([w(1,i),w(1,ceil(mod(i+1,3.1)))],[w(2,i),w(2,ceil(mod(i+1,3.1)))],[w(3,i),w(3,ceil(mod(i+1,3.1)))],'k--')
%     
%     plot3([u(1,i),v(1,i)],[u(2,i),v(2,i)],[u(3,i),v(3,i)],'r-')
%     plot3([v(1,i),w(1,i)],[v(2,i),w(2,i)],[v(3,i),w(3,i)],'g-')
% end


end

