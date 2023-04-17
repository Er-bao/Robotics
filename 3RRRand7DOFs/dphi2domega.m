function R_dphi2domega = dphi2domega(phi)
%dphi2domega ��z-y-z�ǵ�΢��ת��Ϊ���ٶȣ�ת��΢�֣�
%   ���룺z-y-zŷ����
%   �����ת������
R_dphi2domega=[
    0   -sin(phi(1))    sin(phi(2))*cos(phi(1))
    0   cos(phi(1))     sin(phi(2))*sin(phi(1))
    1   0               cos(phi(2))
];
end

