function q = wholePOEinversePro(T)
%wholePOEforward ���������ָ��������
%   �����7���ؽڽ�,ǰ�����ؽڽǺͺ������ؽڽ�������֧���Ĺؽڽ�
%   ���룺ĩ��ִ����λ��
% qq = wholePOEinverseMore(T);
qq = wholePOEinverse(T);
cou=1;
a=size(qq);
for i=1:a(2)
    [R1,~,~,~,~] = RRR3expprod(qq(1,i),qq(2,i),qq(3,i));
    [R2,~,~,~,~] = RRR3expprod(qq(5,i),qq(6,i),qq(7,i));
    [the1,~,~] = RRR3expprodinvPro(R1);
    [the2,~,~] = RRR3expprodinvPro(R2);
    q(1:3,cou)=the1(:,1);q(5:7,cou)=the2(:,1);q(4,cou)=qq(4,i);cou=cou+1;
    q(1:3,cou)=the1(:,1);q(5:7,cou)=the2(:,2);q(4,cou)=qq(4,i);cou=cou+1;
    q(1:3,cou)=the1(:,2);q(5:7,cou)=the2(:,1);q(4,cou)=qq(4,i);cou=cou+1;
    q(1:3,cou)=the1(:,2);q(5:7,cou)=the2(:,2);q(4,cou)=qq(4,i);cou=cou+1;
    
end
end