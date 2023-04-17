%% ����7���ɶ�ģ�ͣ����������������ཻ����
%       theta    d          a        alpha
L1=Link([0       0          0        -pi/2],'modified'); 
L2=Link([0       0          0         pi/2],'modified');
L3=Link([0       0          0         pi/2],'modified');
L4=Link([0       0        255         0   ],'modified');
L5=Link([0     215          0        -pi/2],'modified');
L6=Link([0       0          0         pi/2],'modified');
L7=Link([0       100        0        -pi/2],'modified');

robot=SerialLink([L1,L2,L3,L4,L5,L6,L7]);
shoulder=SerialLink([L1,L2,L3]);
wrist=SerialLink([L5,L6,L7]);
robot.name='Bionic robotic arm';
robot.comment='RM';
RoboticArm=robot;
plot(RoboticArm,[0 0 0 0 0 0 0]);
%% ��3RRR���������˺������ཻ��Ӧ
% ���룺3RRR���������
% �����parallel���������
% ˼·����3RRR���������ת��Ϊ���λ�ˣ��������λ����������ཻ�����룬
% Ҳ����һ��3RRR����+һ�������ཻ�ķ���
function theta=RRR2para(theta_1,theta_2,theta_3)
    phi = RRR3forward_theta123(theta_1,theta_2,theta_3);
    Q=rotz(phi(1))*roty(phi(2))*rotz(phi(3));
    T=diag([1 1 1 1]);
    T(1:3,1:3)=Q;
    % ���룺ĩ��λ��
    % ����������ؽڽ�
    for i=1:8
        theta{i}=[0 0 0 0 0 0];
    end
    
    
theta=
end