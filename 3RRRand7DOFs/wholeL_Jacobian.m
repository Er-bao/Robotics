function J = wholeL_Jacobian(LL,rr,R_B5,qq,phi_j,phi_d,x_4,x_3_)
%wholeJacobian ������е�۵Ŀռ��ſ˱Ⱦ���
%   ���룺��ǰ���������˵�����״̬
%   ������ſ˱Ⱦ���

[gamma,beta,alpha_1,~,eta,~,~,~] = paraconfig();
%% ��ؽ�
% Jl1=[0,0,0].';Jl2=[0,0,0].';Jl3=[0,0,0].';
Jlj=zeros(3,12);
Jaj=JacobLPro(gamma,alpha_1,beta,eta,phi_j,qq(1:3,1));
R_dphi2domega_j = dphi2domega(phi_j);
Jaj=R_dphi2domega_j*Jaj;
% Ja1=Jaj(:,1); Ja2=Jaj(:,2); Ja3=Jaj(:,3);
%% ��ؽ�
% Jl4=L(1:3,4);
% Ja4=L(4:6,4);
Ja4=[x_4 [0 0 0].' [0 0 0].' x_4 [0 0 0].' [0 0 0].'];
Jl4=[cross(rr(1:3,4),x_4) x_3_ LL(4:6,4) cross(rr(1:3,5),x_4) x_4 LL(4:6,4)];
%% ��ؽ�
Jd=JacobLPro(gamma,alpha_1,beta,eta,phi_d,qq(5:7,1));
R_dphi2domega_d = dphi2domega(phi_d);
Jd=R_dphi2domega_d*Jd;
Jld=skew(rr(1:3,5))*R_B5*Jd;
Jad=R_B5*Jd;
%% ����
% J=[     Jl1 Jl2 Jl3 Jl4 Jl5 Jl6 Jl7;     Ja1 Ja2 Ja3 Ja4 Ja5 Ja6 Ja7 ];
J=[
    Jlj Jl4 Jld;
    Jaj Ja4 Jad
];
end