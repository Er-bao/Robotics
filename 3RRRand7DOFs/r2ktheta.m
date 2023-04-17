function [k,thet] = r2ktheta(r)
%r2ktheta ��Ч��Ǻ͵�Чת��
%   ������ת���������Ч��Ǻ͵�Чת��
costhet=0.5*(r(1,1)+r(2,2)+r(3,3)-1);
sinthet=0.5*sqrt( ( r(3,2)-r(2,3) )^2 + ( r(1,3)-r(3,1) )^2 + ( r(2,1)-r(1,2) )^2 );
kx=( r(3,2)-r(2,3) )/(2*sinthet);
ky=( r(1,3)-r(3,1) )/(2*sinthet);
kz=( r(2,1)-r(1,2) )/(2*sinthet);

thet = atan2(sinthet,costhet);
k = [kx,ky,kz].';
end

