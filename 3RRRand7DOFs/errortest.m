%% errortest.m
clear
load('T_history.mat');
T=T_history{100};
%% ����
q = [pi/8 pi/9 0 pi/5*4 pi/10 pi/11 pi/8]
T = wholePOEforward(q)
%% ���������������
% mvnrnd(mu,sigma,number)��������number����ֵΪmu��Э�������Ϊsigma����̬�ֲ������
a=mvnrnd(0,0.001,100);
plot(a)
%% �������������󻯱�ʾ������
for j=1:7
    %%
for i=1:100
    [LL,rr,R_B5,uj,vj,wj,ud,vd,wd]  = wholegetL(T);
    J = wholeJacobian(LL,rr,R_B5,uj,vj,wj,ud,vd,wd);
    dottheta=zeros(7,1);
    dottheta(j)=mvnrnd(0,0.001,1);
    errorsave(i)=dottheta(j);
    spacevomega=J*dottheta;
    R_BT=T(1:3,1:3);p=T(1:3,4);pp=T(1:4,4);
    ppdot=skewV(spacevomega)*pp;
    vomega=spacevomega;vomega(1:3)=ppdot(1:3);
    vomega_h(:,i)=vomega;
end
%%
figure
plot(errorsave)
word=['��',num2str(j),'���ؽڽ�������'];
title(word)

figure
vrds=vomega_h(1:3,:);
plot3(vrds(1,:),vrds(2,:),vrds(3,:),'b.','MarkerFaceColor','b')
xlabel('d_x');
ylabel('d_y');
zlabel('d_z');grid on
word=['��',num2str(j),'���ؽڽ������ʱĩ��ִ�������ƶ�΢��������'];
title(word)
saveas(gcf,['E:\��ѧ�ļ�\����\��ҵ���\20220415���Ȼ㱨\��������Ծ������\','�ؽ�',num2str(j),'�ƶ�.jpg']);

figure
yids=vomega_h(4:6,:);
plot3(yids(1,:),yids(2,:),yids(3,:),'b.','MarkerFaceColor','b')
xlabel('\delta_x')
ylabel('\delta_y')
zlabel('\delta_z');grid on
word=['��',num2str(j),'���ؽڽ������ʱĩ��ִ������ת��΢��������'];
title(word)
saveas(gcf,['E:\��ѧ�ļ�\����\��ҵ���\20220415���Ȼ㱨\��������Ծ������\','�ؽ�',num2str(j),'ת��.jpg']);
end
%% 7���ؽڶ������ʱ�ĵ��ƣ���ؽڶ������
for i=1:1000
    [LL,rr,R_B5,uj,vj,wj,ud,vd,wd]  = wholegetL(T);
    J = wholeJacobian(LL,rr,R_B5,uj,vj,wj,ud,vd,wd);
    dottheta=zeros(7,1);
    for j=5:7
        dottheta(j)=mvnrnd(0,0.001,1);
    end
    spacevomega=J*dottheta;
    R_BT=T(1:3,1:3);p=T(1:3,4);pp=T(1:4,4);
    ppdot=skewV(spacevomega)*pp;
    vomega=spacevomega;vomega(1:3)=ppdot(1:3);
    vomega_h(:,i)=vomega;
end
figure
vrds=vomega_h(1:3,:);
plot3(vrds(1,:),vrds(2,:),vrds(3,:),'b.','MarkerFaceColor','b')
xlabel('d_x');
ylabel('d_y');
zlabel('d_z');grid on
word=['��ؽ������ʱĩ��ִ�������ƶ�΢��������'];
title(word)
saveas(gcf,['E:\��ѧ�ļ�\����\��ҵ���\20220422���Ȼ㱨\��������Ծ������\��ؽ��ƶ�',num2str(i),'��.jpg']);

figure
yids=vomega_h(4:6,:);
plot3(yids(1,:),yids(2,:),yids(3,:),'b.','MarkerFaceColor','b')
xlabel('\delta_x')
ylabel('\delta_y')
zlabel('\delta_z');grid on
word=['��ؽ������ʱĩ��ִ������ת��΢��������'];
title(word)
saveas(gcf,['E:\��ѧ�ļ�\����\��ҵ���\20220422���Ȼ㱨\��������Ծ������\��ؽ�ת��',num2str(i),'��.jpg']);
%% 7���ؽڶ������ʱ�ĵ��ƣ���ؽڶ������
for i=1:1000
    [LL,rr,R_B5,uj,vj,wj,ud,vd,wd]  = wholegetL(T);
    J = wholeJacobian(LL,rr,R_B5,uj,vj,wj,ud,vd,wd);
    dottheta=zeros(7,1);
    for j=1:3%5:7
        dottheta(j)=mvnrnd(0,0.001,1);
    end
    spacevomega=J*dottheta;
    R_BT=T(1:3,1:3);p=T(1:3,4);pp=T(1:4,4);
    ppdot=skewV(spacevomega)*pp;
    vomega=spacevomega;vomega(1:3)=ppdot(1:3);
    vomega_h(:,i)=vomega;
end
figure
vrds=vomega_h(1:3,:);
plot3(vrds(1,:),vrds(2,:),vrds(3,:),'b.','MarkerFaceColor','b')
xlabel('d_x');
ylabel('d_y');
zlabel('d_z');grid on
word=['��ؽ������ʱĩ��ִ�������ƶ�΢��������'];
title(word)
saveas(gcf,['E:\��ѧ�ļ�\����\��ҵ���\20220415���Ȼ㱨\��������Ծ������\��ؽ��ƶ�',num2str(i),'��.jpg']);

figure
yids=vomega_h(4:6,:);
plot3(yids(1,:),yids(2,:),yids(3,:),'b.','MarkerFaceColor','b')
xlabel('\delta_x')
ylabel('\delta_y')
zlabel('\delta_z');grid on
word=['��ؽ������ʱĩ��ִ������ת��΢��������'];
title(word)
saveas(gcf,['E:\��ѧ�ļ�\����\��ҵ���\20220415���Ȼ㱨\��������Ծ������\��ؽ�ת��',num2str(i),'��.jpg']);

%% 7���ؽڶ������ʱ�ĵ��ƣ�7���ؽڶ������
for i=1:1000
    [LL,rr,R_B5,uj,vj,wj,ud,vd,wd]  = wholegetL(T);
    J = wholeJacobian(LL,rr,R_B5,uj,vj,wj,ud,vd,wd);
    dottheta=zeros(7,1);
    for j=1:7
        dottheta(j)=mvnrnd(0,0.001,1);
    end
    spacevomega=J*dottheta;
    R_BT=T(1:3,1:3);p=T(1:3,4);pp=T(1:4,4);
    ppdot=skewV(spacevomega)*pp;
    vomega=spacevomega;vomega(1:3)=ppdot(1:3);
    vomega_h(:,i)=vomega;
%     JTV = wholevelocityJacobian(LL,rr,R_B5,T,uj,vj,wj,ud,vd,wd);
% 	veloomega=JTV*dottheta;
%     vomega_h(:,i)=veloomega;
end
%% ��ͼ
figure
vrds=vomega_h(1:3,:);
plot3(vrds(1,:),vrds(2,:),vrds(3,:),'b.','MarkerFaceColor','b')
xlabel('d_x');
ylabel('d_y');
zlabel('d_z');grid on
word=['7���ؽ������ʱĩ��ִ�������ƶ�΢��������'];
title(word)
saveas(gcf,['E:\��ѧ�ļ�\����\��ҵ���\20220422���Ȼ㱨\��������Ծ������\7���ؽ��ƶ�',num2str(i),'��.jpg']);

figure
yids=vomega_h(4:6,:);
plot3(yids(1,:),yids(2,:),yids(3,:),'b.','MarkerFaceColor','b')
xlabel('\delta_x')
ylabel('\delta_y')
zlabel('\delta_z');grid on
word=['7���ؽ������ʱĩ��ִ������ת��΢��������'];
title(word)
saveas(gcf,['E:\��ѧ�ļ�\����\��ҵ���\20220422���Ȼ㱨\��������Ծ������\7���ؽ�ת��',num2str(i),'��.jpg']);
%% ���ɷַ���vrds
X=vrds.';
[n,p]=size(X);
M=mean(X);
Xp=X-ones(n,1);
S=cov(Xp);
[V,D]=eig(S);
[D_sort,index]=sort(diag(D),'descend');
V_sort=V(:,index);
disp('�������Ӵ�С��');disp(D_sort);
disp('��������');disp(V_sort);
Rate=D_sort/sum(D_sort)
%% һ�����
clear
load('7���ؽ�������1000��T{100}.mat')
X=vomega_h(1:3,:).';
[n,p]=size(X);
M=mean(X);
Xp=X-ones(n,1)*M;
S=cov(Xp);
[pc,latent,explained]=pcacov(S);
figure
vrds=vomega_h(1:3,:);
plot3(vrds(1,:),vrds(2,:),vrds(3,:),'b.','MarkerFaceColor','b');hold on
for j=1:3
    len(j)=max(sqrt(diag(vrds.'*vrds)));
    len(j)=len(j)/max(explained)*explained(j);
    quiver3(M(1),M(2),M(3),pc(1,j),pc(2,j),pc(3,j),len(j),'k','filled','LineWidth',2);hold on
    str=[num2str(explained(j)),'%'];
    text(1.7*len(j)*pc(1,j),1.7*len(j)*pc(2,j),1.7*len(j)*pc(3,j),str,'FontSize',12)
end
xlabel('d_x');
ylabel('d_y');
zlabel('d_z');grid on
word=['7���ؽ������ʱĩ��ִ�������ƶ�΢��������'];
title(word)
%% ��һ����Բ��Χ����
clear
load('7���ؽ�������1000��T{100}.mat')
X=vomega_h(1:3,:).';
[n,p]=size(X);
M=mean(X);
Xp=X-ones(n,1)*M;
S=cov(Xp);
[pc,latent,explained]=pcacov(S);
figure
vrds=vomega_h(1:3,:);

%
if pc(:,3)-cross(pc(:,1),pc(:,2))<1.0e-10
    Relp=pc;    
    xc=latent(1);
    yc=latent(2);
    zc=latent(3);
%     xc=len(1);
%     yc=len(2);
%     zc=len(3);
else
    Relp=[pc(:,2),pc(:,1),pc(:,3)];
    xc=latent(2);
    yc=latent(1);
    zc=latent(3);
end
[X,Y,Z] = ellipsoid(0,0,0,xc,yc,zc);
% surf(X,Y,Z);
axis equal
hold on
s = surf(X+M(1),Y+M(2),Z+M(3));
[k,thet] = r2ktheta(Relp);
direction = [k(1) k(2) k(3)];
rotate(s,direction,thet/pi*180)
plot3(vrds(1,:),vrds(2,:),vrds(3,:),'b.','MarkerFaceColor','b');hold on
xlabel('d_x');
ylabel('d_y');
zlabel('d_z');grid on
word=['7���ؽ������ʱĩ��ִ�������ƶ�΢��������'];
title(word)
for j=1:3
    quiver3(M(1),M(2),M(3),pc(1,j),pc(2,j),pc(3,j),1.3*latent(j),'k','filled','LineWidth',2);hold on
    str=[num2str(explained(j)),'%'];
    text(1.7*latent(j)*pc(1,j),1.7*latent(j)*pc(2,j),1.7*latent(j)*pc(3,j),str,'FontSize',12)
end
%% ת��΢��
X=vomega_h(4:6,:).';
[n,p]=size(X);
M=mean(X);
Xp=X-ones(n,1)*M;
S=cov(Xp);
[pc,latent,explained]=pcacov(S);
figure
vrds=vomega_h(4:6,:);
plot3(vrds(1,:),vrds(2,:),vrds(3,:),'b.','MarkerFaceColor','b');hold on
for j=1:3
    len=max(sqrt(diag(vrds.'*vrds)));
    len=len/max(explained)*explained(j);
    quiver3(M(1),M(2),M(3),pc(1,j),pc(2,j),pc(3,j),len,'k','filled','LineWidth',2);hold on
    str=[num2str(explained(j)),'%'];
    text(1.3*len*pc(1,j),1.3*len*pc(2,j),1.3*len*pc(3,j),str)
end
xlabel('d_x');
ylabel('d_y');
zlabel('d_z');grid on
word=['7���ؽ������ʱĩ��ִ������ת��΢��������'];
title(word)
%% ��һ����Բ��Χ����
clear
load('7���ؽ�������1000��T{100}.mat')
X=vomega_h(4:6,:).';
[n,p]=size(X);
M=mean(X);
Xp=X-ones(n,1)*M;
S=cov(Xp);
[pc,latent,explained]=pcacov(S);
% figure
vrds=vomega_h(4:6,:);
for j=1:3
    len(j)=max(sqrt(diag(vrds.'*vrds)));
    len(j)=1.5*len(j)/max(explained)*explained(j);
end
% ��ת��΢������
% figure
if pc(:,3)-cross(pc(:,1),pc(:,2))<1.0e-10
    Relp=pc;    
    xc=len(1);
    yc=len(2);
    zc=len(3);
else
    Relp=[pc(:,2),pc(:,1),pc(:,3)];
    xc=len(2);
    yc=len(1);
    zc=len(3);
end
[X,Y,Z] = ellipsoid(0,0,0,xc,yc,zc);
% surf(X,Y,Z);
% axis equal
hold on
axis equal
% s = surf(X+M(1),Y+M(2),Z+M(3));
s = surf(X,Y,Z);
[k,thet] = r2ktheta(Relp);
direction = [k(1) k(2) k(3)];
rotate(s,direction,thet/pi*180)

plot3(vrds(1,:),vrds(2,:),vrds(3,:),'b.','MarkerFaceColor','b');hold on
for j=1:3
    quiver3(M(1),M(2),M(3),pc(1,j),pc(2,j),pc(3,j),1.1*len(j),'k','filled','LineWidth',2);hold on
    str=[num2str(explained(j)),'%'];
    text(1.3*len(j)*pc(1,j),1.3*len(j)*pc(2,j),1.3*len(j)*pc(3,j),str)
end
xlabel('d_x');
ylabel('d_y');
zlabel('d_z');grid on
word=['7���ؽ������ʱĩ��ִ������ת��΢��������'];
title(word)
%% ��������ϣ��õ��������
% function elli(xc,yc,zc,xr,yr,zr)
%     [X,Y,Z] = ellipsoid(xc,yc,zc,xr,yr,zr);
% %     surf(X,Y,Z);
%     axis equal
% %     hold on
%     s = surf(X+3,Y,Z+5);
%     direction = [1 0 0];
%     rotate(s,direction,45)
% end
%% ͹��
xdata = vrds.';
x=xdata(:,1);
y=xdata(:,2);
z=xdata(:,3);
[K,V] = convhull(x,y,z);
trisurf(K,x,y,z,'Facecolor','cyan')
%% ת��͹��
xdata = yids.';
x=xdata(:,1);
y=xdata(:,2);
z=xdata(:,3);
[K,V] = convhull(x,y,z);
trisurf(K,x,y,z,'Facecolor','cyan')
%%
v=xdata;
k = convhull(v);  % ����͹����k������͹����������Ƭ��Ϣ��ÿһ��Ϊ�����ζ�����v��������
 
bcent = [0,0,0];   % ͹����������
temp = [v(k(1,1),1),v(k(1,1),2),v(k(1,1),3)];    % ͹������һ����
sumvlm = 0.0;      % ͹�����
t2 =0.0;
for(i =1:size(k,1))
    p1 = [v(k(i,1),1),v(k(i,1),2),v(k(i,1),3)]; 
    p2 = [v(k(i,2),1),v(k(i,2),2),v(k(i,2),3)]; 
    p3 = [v(k(i,3),1),v(k(i,3),2),v(k(i,3),3)]; 
    t2 = volume(temp,p1,p2,p3);     % �����������              
    if(t2 > 0)
        bcent(1) = bcent(1) + (p1(1)+p2(1)+p3(1)+temp(1))/4*t2; 
        bcent(2) = bcent(2) + (p1(2)+p2(2)+p3(2)+temp(2))/4*t2; 
        bcent(3) = bcent(3) + (p1(3)+p2(3)+p3(3)+temp(3))/4*t2; 
        sumvlm = sumvlm + t2; 
    end  
end
bcent(1) = bcent(1)/(sumvlm); 
bcent(2) = bcent(2)/(sumvlm); 
bcent(3) = bcent(3)/(sumvlm); 
 
sumvlm
bcent
%% �ռ������������㷨
x=K(:,1);
y=K(:,2);
z=K(:,3);
num_points = length(x);
%һ����ͳ��ƽ��
x_avr = sum(x)/num_points;
y_avr = sum(y)/num_points;
z_avr = sum(z)/num_points;
%������ͳ��ƽ��
xx_avr = sum(x.*x)/num_points;
yy_avr = sum(y.*y)/num_points;
zz_avr = sum(z.*z)/num_points;
xy_avr = sum(x.*y)/num_points;
xz_avr = sum(x.*z)/num_points;
yz_avr = sum(y.*z)/num_points;
%������ͳ��ƽ��
xxx_avr = sum(x.*x.*x)/num_points;
xxy_avr = sum(x.*x.*y)/num_points;
xxz_avr = sum(x.*x.*z)/num_points;
xyy_avr = sum(x.*y.*y)/num_points;
xzz_avr = sum(x.*z.*z)/num_points;
yyy_avr = sum(y.*y.*y)/num_points;
yyz_avr = sum(y.*y.*z)/num_points;
yzz_avr = sum(y.*z.*z)/num_points;
zzz_avr = sum(z.*z.*z)/num_points;
%�Ĵ���ͳ��ƽ��
yyyy_avr = sum(y.*y.*y.*y)/num_points;
zzzz_avr = sum(z.*z.*z.*z)/num_points;
xxyy_avr = sum(x.*x.*y.*y)/num_points;
xxzz_avr = sum(x.*x.*z.*z)/num_points;
yyzz_avr = sum(y.*y.*z.*z)/num_points;

%����������Է��̵�ϵ������
A0 = [yyyy_avr yyzz_avr xyy_avr yyy_avr yyz_avr yy_avr;
     yyzz_avr zzzz_avr xzz_avr yzz_avr zzz_avr zz_avr;
     xyy_avr  xzz_avr  xx_avr  xy_avr  xz_avr  x_avr;
     yyy_avr  yzz_avr  xy_avr  yy_avr  yz_avr  y_avr;
     yyz_avr  zzz_avr  xz_avr  yz_avr  zz_avr  z_avr;
     yy_avr   zz_avr   x_avr   y_avr   z_avr   1;];
%����������
b = [-xxyy_avr;
     -xxzz_avr;
     -xxx_avr;
     -xxy_avr;
     -xxz_avr;
     -xx_avr];

resoult = inv(A0)*b;
%resoult = solution_equations_n_yuan(A0,b);

x00 = -resoult(3)/2                  %��ϳ���x����
y00 = -resoult(4)/(2*resoult(1))     %��ϳ���y����
z00 = -resoult(5)/(2*resoult(2))     %��ϳ���z����

AA = sqrt(x00*x00 + resoult(1)*y00*y00 + resoult(2)*z00*z00 - resoult(6))   % ��ϳ���x�����ϵ���뾶
BB = AA/sqrt(resoult(1))                                                    % ��ϳ���y�����ϵ���뾶
CC = AA/sqrt(resoult(2))                                                    % ��ϳ���z�����ϵ���뾶

fprintf('��Ͻ��\n');
fprintf('a = %f, b = %f, c = %f, d = %f, e = %f, f = %f\n',resoult);

%%
disp('c��:');disp(c);
function v = volume(a,b,c,d)
 
h = [b-a;c-a;d-a];
v = abs(det(h))/6;
end