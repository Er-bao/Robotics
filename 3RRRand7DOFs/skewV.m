function skewV = skewV(V)
%skewV ����ʸ��ת��Ϊ�˶�����
%   ���룺��ʸ����ǰ���������ٶȣ�������Ԫ���ǽ��ٶ�
%   ������˶�����
skewV=zeros(4,4);
skewV(1:3,4) = V(1:3);
skewV(1:3,1:3) = skew(V(4:6));
end

