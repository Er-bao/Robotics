%% ���ֿΣ�PUMA560��������֤����
% ���� ��е1807�� 2021��3��31��
% ��չ�����
clear;
%% ����PUMA560�ĸĽ�DHģ��
%       theta    d          a        alpha
L1=Link([0       0          0         0   ],'modified'); 
L2=Link([0       149.09     0        -pi/2],'modified');
L3=Link([0       0          431.8     0   ],'modified');
L4=Link([0       433.07     20.32    -pi/2],'modified');
L5=Link([0       0          0         pi/2],'modified');
L6=Link([0       0          0        -pi/2],'modified');

robot=SerialLink([L1,L2,L3,L4,L5,L6]);
robot.name='PUMA560';
robot.comment='RM';
puma=robot;
%% ����
q=[pi/2 pi/3 -pi/2 pi/6 pi/4 pi/8];
disp('�����˹������Դ������⺯����')
puma.fkine(q)
disp('�Լ���д�����⺯���������')
Kinematics(q)
%% ����
%% ���������ཻPIEPER����
% ��ĩ��λ�ú�����ڹ̶�����ϵ��zyzŷ����
in=[-250 430 -240 pi/8 pi/4 pi/5];
theta=Three_axis_intersection_pieper(in);
disp('����������ؽڽ�Ϊ��')
theta{1}
r=rotz(in(4))*roty(in(5))*rotz(in(6));
T=[
    1 0 0 in(1);
    0 1 0 in(2);
    0 0 1 in(3);
    0 0 0 1];
T(1:3,1:3)=r
disp('�����˹�����ķ��⺯��ikine���õ��Ĺؽڽǣ�')
q=puma.ikine(T)
disp('�����˹������Դ�������fkine���鷴�����ȷ��:')
puma.fkine(theta{1})
disp('ͨ���Լ�д��������鷴�����ȷ��:')
Kinematics(theta{1})

%% ���鷴�任����
in=[-200 300 -220 pi/3 pi/8 pi/6];
q=InverseTransformation(in);
% ����
for i=1:8
    word=['���任���ĵ�',num2str(i),'��ؽڽ�:'];disp(word);
    q{i}
    disp('�����˹������Դ�������fkine��������ȷ��:')
    puma.fkine(q{i})
end

r=rotz(in(4))*roty(in(5))*rotz(in(6));
T=[
    1 0 0 in(1);
    0 1 0 in(2);
    0 0 1 in(3);
    0 0 0 1];
disp('ĩ��λ�ˣ�')
T(1:3,1:3)=r
disp('�����˹�����ķ��⺯��ikine���õ��Ĺؽڽǣ�')
q=puma.ikine(T)
puma.fkine(q)


% mdl_puma560
% r=rotz(in(4))*roty(in(5))*rotz(in(6));
% T=[
%     1 0 0 in(1)/1000;
%     0 1 0 in(2)/1000;
%     0 0 1 in(3)/1000;
%     0 0 0 1];
% disp('ĩ��λ�ˣ�')
% T(1:3,1:3)=r;
% disp('�����˹�����ķ��⺯��ikine���õ��Ĺؽڽǣ�')
% q=p560.ikine6s(T)
% p560.fkine(q)

%% ŷ���ǵ�ת��
R_zyz = eul2r(15,30,60);  %���������ǽǶ���
gamma = tr2eul(R_zyz); %��������ǻ�����
%% 
mdl_puma560
r=rotz(in(4))*roty(in(5))*rotz(in(6));
T=[
    1 0 0 in(1)/1000;
    0 1 0 in(2)/1000;
    0 0 1 in(3)/1000;
    0 0 0 1];
T(1:3,1:3)=r;
q=p560.ikine6s(T)
p560.fkine(q)
%% ĩ�����������˶�
%������
plot(p560,[0 0 0 0 0 0]);

theta=-3*pi:0.1*pi:3*pi;
x=0.3*cos(theta);
y=0.3*sin(theta);
z=0.05*theta;

plot3(x,y,z);


for theta=-3*pi:0.2*pi:3*pi
    x=0.3*cos(theta);
    y=0.3*sin(theta);
    z=0.05*theta;
    
    targ_tran1=p560.base;
    targ_tran1(1:3,4)=[x y z]';
    targ_ang1=p560.ikine(targ_tran1);
    
    p560.plot(targ_ang1);
    
    targ_tran2=p560.base;
    targ_tran2(1:3,4)=[x y z]';
    targ_ang2=p560.ikine(targ_tran2);

    p560.plot(targ_ang2);
    
    pause(0.01);
end
%%
init_ang = [0 0 0 0 0 0];
targ_ang = [pi/4, -pi/3, pi/5, pi/2, -pi/4, pi/6];
step = 50;
[q,qd,qdd] = jtraj(init_ang,targ_ang,step);   %ֱ�ӵõ��Ƕȡ����ٶȡ��Ǽ��ٶȵĵ�����

%������ʾ
figure; 
p560.plot(q);

figure;
%��ʾλ�á��ٶȡ����ٶȱ仯����
subplot(3, 1, 1);

plot(q);
title('�ؽڽǵĽǶ�');
grid on;

subplot(3, 1, 2);
i = 1:6;
plot(qd);
title('�ٶ�');
grid on;

subplot(3, 1, 3);
i = 1:6;
plot(qdd);
title('���ٶ�');
grid on;

t =p560.fkine(q);%�˶�ѧ����
rpy=tr2rpy(t);  %t����ȡλ�ã�xyz��
figure;
plot2(rpy);
%% 
theta=-3*pi:0.1*pi:3*pi;
x=100*cos(theta)+300;
y=100*sin(theta)+300;
z=50*theta;
% plot3(x,y,z);
a_ang=[x(1) y(1) z(1) 0 0 0];
q=InverseTransformation(a_ang);
q=q{1};
puma.plot(q);
for i=2:length(theta)
    % ��ǰλ�ùؽڽ�ת��Ϊ��һλ�õĹؽڽ�
    tar_ang=[x(i) y(i) z(i) 0 0 0];
    next_ang=comparetheta(q,tar_ang);
    q=next_ang;
    puma.plot(next_ang);
    pause(0.1);
    
end