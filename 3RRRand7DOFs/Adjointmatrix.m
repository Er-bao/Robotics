function Ad_V = Adjointmatrix(T)
%Adjointmatrix �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
R=T(1:3,1:3);p=T(1:3,4);
Ad_V = [R skew(p)*R;
        zeros(3,3) R];
end

