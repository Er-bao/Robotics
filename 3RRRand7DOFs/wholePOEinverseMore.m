function qq = wholePOEinverse(T)
%wholePOEforward ���������ָ��������
%   �����7���ؽڽ�
%   ���룺ĩ��ִ����λ��
%% ����
qq=[0 0 0 0 0 0 0].';
[gamma,beta,alpha_1,alpha_2,eta,a_3,a_4,d_7] = paraconfig();
theta1=[0 0 0].';
%% u����
Q_u=cell(1,3);
u=ones(3);
for i=1:3
    Q_u{i}=rotz(pi/2+eta(i))*roty(pi-gamma)*floor(rotz(pi/2));
    u_0=[0 0 1].';
    u(:,i)=Q_u{i}*u_0;
end
%% v�������м���ת��ͷ
Q_v=cell(1,3);
v=ones(3);
for i=1:3
    Q_v{i}=Q_u{i}*rotz(theta1(i))*roty(alpha_1);
    v_0=[0 0 1].';
    v(:,i)=Q_v{i}*v_0;
end
%% w����
Q_w=cell(1,3);
w=ones(3);
for i=1:3
    Q_w{i}=rotz(pi/2+eta(i))*roty(beta)*floor(rotz(-pi/2));
    w_0=[0 0 1].';
    w(:,i)=Q_w{i}*w_0;
end
u_i=u(:,1);
v_i=v(:,1);
w_i=w(:,1);
p_0=[0;0;1];
%% �����ؽ����ߵ���ʸ��
r=[
    0   0   0   0       0           0           0
    0   0   0   0       0           0           0
    0   0   0   a_3     a_3+a_4     a_3+a_4     a_3+a_4
    ];
mu=[0 1 0].';
L=zeros(6,7);
L(:,1)=[cross(r(:,1),u_i); u_i];
L(:,2)=[cross(r(:,2),v_i); v_i];
L(:,3)=[cross(r(:,3),w_i); w_i];
L(:,4)=[cross(r(:,4),mu);  mu];
L(:,5)=[cross(r(:,5),u_i); u_i];
L(:,6)=[cross(r(:,6),v_i); v_i];
L(:,7)=[cross(r(:,7),w_i); w_i];

%% ��ʼλ��
M=[
    1 0 0 0
    0 1 0 0 
    0 0 1 a_3+a_4+d_7
    0 0 0 1
    ];
%% ������ؽ�qq(4)
    tau2pi=359;
    squa_his=zeros(tau2pi*2,1);
    qq_his=zeros(7,tau2pi*2);
for j=1:2
    T1=T*inv(M);
    % pw��������Ľ���
    pw=[0 0 a_3+a_4 1].';%T*[0 0 -d_7 1].';
    pb=[0 0 0 1].';
    temp=(T1*pw-pb);
    p=pw(1:3);q=pb(1:3);delta=norm(temp(1:3));
    qq(4) = subproblem3(p,q,mu,delta,r(:,4),(2*j-3));
    %% ����ǰ�����ؽ�
    for i=0:tau2pi
        %% ѡ��һ��qq(3)
        qq(3)=-pi+i/180*pi;
        %% ����qq(1)��qq(2)
        p=POE(L(:,3),qq(3))*POE(L(:,4),qq(4))*pw;
        q=T1*pw;
        try
            [qq(1),qq(2)] = subproblem2(p(1:3),q(1:3),u_i,v_i,r(:,1),1);
            %% ����ؽ�qq(5)qq(6)
            % p��L7�ϣ�����������L5L6��
            p=[r(:,7)+100*w_i;1];
            T2=POE(L(:,4),-qq(4))*POE(L(:,3),-qq(3))*POE(L(:,2),-qq(2))*POE(L(:,1),-qq(1))*T*inv(M);
            q=T2*p;
            [qq(5),qq(6)] = subproblem2(p(1:3),q(1:3),u_i,v_i,r(:,7),1);
            %% ����ؽ�qq(7)
            % pΪL7�������һ��
            p=[r(:,7)+10*w_i+[0 0 1].'; 1];
            T3=POE(-L(:,6),qq(6))*POE(-L(:,5),qq(5))*POE(-L(:,4),qq(4))*POE(-L(:,3),qq(3))*POE(-L(:,2),qq(2))*POE(-L(:,1),qq(1))*T*inv(M);
            q=T3*p;
            qq(7) = subproblem1(p(1:3),q(1:3),w_i,r(:,7));
            %% ����ؽڽ�
            squa_his((j-1)*(tau2pi+1)+i+1)=norm(qq)^2;
            qq_his(:,(j-1)*(tau2pi+1)+i+1)=qq;
        catch
            squa_his((j-1)*(tau2pi+1)+i+1)=2^32-1;
            qq_his(:,(j-1)*(tau2pi+1)+i+1)=2^32-1;
        end

    end

end
qq=qq_his(:,squa_his<2^32-1);
end

