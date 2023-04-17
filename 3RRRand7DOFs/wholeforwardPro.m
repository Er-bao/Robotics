function T_BT = wholeforwardPro(q)
%wholeforward �����е�����⣨����������ָ����ģ�ͣ�
%   ���룺һ��ؽڽ�q,ǰ�����ؽڽǺͺ������ؽڽ�������֧���Ĺؽڽ�
%   �����ĩ��λ��
%% ����
% q=10^-16*[0.00001 0.00001 0.00001 0.00001 0.00001 0.00001 0.00001].';
% q=[0 0 0 pi/2 0 0 0 ].'
% q=[0.2878    0.1563   -0.3921    0.1728   -0.1691    0.1318     -0.5226].'
[~,~,~,~,~,a_3,a_4,d_7] = paraconfig();
T_3_4=transformation(a_3,0,0,q(4));%screwx(a_3,-pi/2)*screwz(0,q(4));
T_45_=transformation(a_4,0,0,0);

T_33_=Rotx(-pi/2)*Rotz(-pi/2);
T_5_5=Rotz(pi/2)*Rotx(pi/2);

T_WT=transformation(0,0,d_7,0);%screwx(0,0)*screwz(d_7,0);
global theta
theta=1;
% theta=q(1:3);
T_B3=RRR3expprodPro(q(1:3));
T_B3=[T_B3,[0 0 0].';[0 0 0 1]];
% theta=q(5:7);
T_5W=RRR3expprodPro(q(5:7));
T_5W=[T_5W,[0 0 0].';[0 0 0 1]];

T_BW=T_B3*T_33_*T_3_4*T_45_*T_5_5*T_5W;

T_BT=T_BW*T_WT;

end


%% ������
function result=transformation(a,alpha,d,theta)
    result=screwx(a,alpha)*screwz(d,theta);
end
% ��дscrew����
function result=screwx(a,alpha)
    result=Rotx(alpha)*transl([a 0 0]);
end
function result=screwz(d,theta)
    result=Rotz(theta)*transl([0 0 d]);
end
% R4*4����ת���ƶ�����
function result=Rotz(theta)
    result=[rot('z',theta) [0 0 0].';[0 0 0 1]];
end
function result=Roty(theta)
    result=[rot('y',theta) [0 0 0].';[0 0 0 1]];
end
function result=Rotx(theta)
    result=[rot('x',theta) [0 0 0].';[0 0 0 1]];
end
% ��ת����
function result=rot(axis,theta)
    switch(axis)
        case 'x'
            result=[1 0 0;0 cos(theta) -sin(theta);0 sin(theta) cos(theta)];
        case 'y'
            result=[cos(theta) 0 sin(theta);0 1 0;-sin(theta) 0 cos(theta)];       
        case 'z'
            result=[cos(theta) -sin(theta) 0;sin(theta) cos(theta) 0; 0 0 1];
        otherwise
            disp('wrong')
    end
    if mod(theta,pi/2)==0
        result=round(result);
    end
end
