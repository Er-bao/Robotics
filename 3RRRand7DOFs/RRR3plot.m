function [u,v,w,psi] = RRR3plot()
%% RRR3inverse 3RRR���������˳�ʼλ�û�ͼ����
% ���룺
% theta����ƽ̨���������ؽڵĹؽڽǶ�
% �����
% u����ƽ̨��ת��������
% v���м�ؽڵ�ת��������
% w����ƽ̨��ת��������
% psi���м�ؽڵĽǶ�
%% �ṹ����
[gamma,beta,alpha_1,~,eta,~,~,~] = paraconfig();
theta=[0 0 0].';
% gamma=50/180*pi;
% beta=50/180*pi;
% alpha_1=pi/2;
% % alpha_2=pi/2;
% eta=[0 2/3*pi 4/3*pi].';
%% u����
% u_i������z��ת(pi/2+eta),��������y��ת(pi-gamma)
% ��������z��ת(pi/2)�����������ת�ؽڳ�ʼλ��
% eta=(i-1)*2/3*pi,i=1,2,3
Q_u=cell(1,3);
u=ones(3);
for i=1:3
    Q_u{i}=rotz(pi/2+eta(i))*roty(pi-gamma)*floor(rotz(pi/2));
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
    Q_v{i}=Q_u{i}*rotz(theta(i))*roty(alpha_1);
    v_0=[0 0 1].';
    v(:,i)=Q_v{i}*v_0;
end
%% w����
% ���ƶ�ƽ̨MP�����ʼλ��ʱ��
% w_i������z��ת(pi/2+eta_i),��������y��תbeta
% ��������z��ת(-pi/2)�����������ת�ؽڳ�ʼλ��
% eta_i=(i-1)*2/3*pi,i=1,2,3
Q_w=cell(1,3);
w=ones(3);
for i=1:3
    Q_w{i}=rotz(pi/2+eta(i))*roty(beta)*floor(rotz(-pi/2));
    w_0=[0 0 1].';
    w(:,i)=Q_w{i}*w_0;
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
hold on
view([6,2,2]);
limit=[-1,1];xlim(limit);ylim(limit);zlim(limit);
plot3(0,0,0,'yo','MarkerFaceColor','k')
for i=1:3
    plot3(u(1,i),u(2,i),u(3,i),'yo','MarkerFaceColor','y')
    plot3(v(1,i),v(2,i),v(3,i),'yo','MarkerFaceColor','r')
    plot3(w(1,i),w(2,i),w(3,i),'yo','MarkerFaceColor','g')
    
    plot3([0,u(1,i)],[0,u(2,i)],[0,u(3,i)],'b--','MarkerFaceColor','y')
    plot3([u(1,i),v(1,i)],[u(2,i),v(2,i)],[u(3,i),v(3,i)],'b-','MarkerFaceColor','r')
    plot3([v(1,i),w(1,i)],[v(2,i),w(2,i)],[v(3,i),w(3,i)],'b-','MarkerFaceColor','r')
end


end

