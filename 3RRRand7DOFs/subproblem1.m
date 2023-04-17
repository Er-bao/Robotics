function theta = subproblem1(p,q,w,r)
%subproblem1 ������һ
%   ��֪p��q����p��q��ת��
    if nargin==3
        r=[0 0 0].';
    end
u=p-r;
v=q-r;
u1=u-w*(w.'*u);
v1=v-w*(w.'*v);
theta=atan2(w.'*cross(u1,v1),u1.'*v1);
end

