% errortestL.m
%% һ��λ�˲���
clear
phi=[pi/11,pi/12,pi/13];
T=rotz(phi(1))*roty(phi(2))*rotz(phi(3));
[theta,phi,xi] = RRR3expprodinvPro(T);
[gamma,beta,alpha_1,~,eta,~,~,~] = paraconfig();

JL = JacobL(gamma,alpha_1,beta,eta,phi,theta)
delta_L=[0.01 0 0 0 0 0].';
delta_x=JL*delta_L
R_dphi2domega = dphi2domega(phi)
delta=R_dphi2domega*delta_x
%% һ��λ�˵����
clear
num=100;
a=linspace(0,pi/11,num);
b=linspace(0,pi/9,num);
c=linspace(0,pi/10,num);
for i=1:num
    phi=[a(i),b(i),c(i)];
    T=rotz(phi(1))*roty(phi(2))*rotz(phi(3));
    [theta,phi,xi] = RRR3expprodinvPro(T);
    [gamma,beta,alpha_1,~,eta,~,~,~] = paraconfig();

    JL = JacobL(gamma,alpha_1,beta,eta,phi,theta);
    delta_L=[ 0.01 0 0 0 0 0 ].';
    delta_x=JL*delta_L;
    R_dphi2domega = dphi2domega(phi);
    delta=R_dphi2domega*delta_x;
    dotomega(:,i)=delta;
end
% plot(dotomega.')
plot1 = plot(dotomega.','LineWidth',2);
legend('\omega_x', '\omega_y','\omega_z')
%% �Ľ�JacobL����
clear
phi=[pi/11,pi/12,pi/13];
T=rotz(phi(1))*roty(phi(2))*rotz(phi(3));
[theta,~,xi] = RRR3expprodinvPro(T);
[gamma,beta,alpha_1,~,eta,~,~,~] = paraconfig();

JL = JacobLPro(gamma,alpha_1,beta,eta,phi,theta)
delta_L=[0.01 0 0 0 0 0 0 0 0 0 0 0].';
delta_x=JL*delta_L
R_dphi2domega = dphi2domega(phi)
J=R_dphi2domega*JL
delta=R_dphi2domega*delta_x
%% �Ľ�һ�����
clear
num=100;
a=linspace(0,pi/11,num);
b=linspace(0,pi/9,num);
c=linspace(0,pi/10,num);
wor=["\gamma_1" "\gamma_2" "\gamma_3" "\alpha_{11}" "\alpha_{12}" "\alpha_{13}" "\beta_1" "\beta_2" "\beta_3" "\eta_1" "\eta_2" "\eta_3"];
for j=1:12
for i=1:num
    phi=[a(i),b(i),c(i)];
    T=rotz(phi(1))*roty(phi(2))*rotz(phi(3));
    [theta,~,xi] = RRR3expprodinvPro(T);
    [gamma,beta,alpha_1,~,eta,~,~,~] = paraconfig();

    JL = JacobLPro(gamma,alpha_1,beta,eta,phi,theta);
    delta_L=zeros(12,1);
    delta_L(j)=0.01;
    delta_x=JL*delta_L;
    R_dphi2domega = dphi2domega(phi);
    delta=R_dphi2domega*delta_x;
    dotomega(:,i)=delta;
end
figure
plot(dotomega.','LineWidth',2);
title(wor(j))
legend('\omega_x', '\omega_y','\omega_z')
saveas(gcf,['E:\��ѧ�ļ�\����\��ҵ���\20220429���Ȼ㱨\�ṹ�������\',num2str(j),'.jpg']);

end
%% У׼ģ��
% �����
clear;clc
err=[ 0 0 0 0 0 0 0.02 0 0.05 0 0 0].';%��ʵ���
err_sol=zeros(12,1);%��Ϊ���
sum=err_sol;%�ۼ����
q=[pi/6 pi/10 pi/9].';%�������
[R_err,~,~,~,~] = RRR3expprodPro(q,err);
[a, b, c]=r2zyz(R_err);phi_err=[a b c].';%��ʵ���x��
[R,~,~,~,~] = RRR3expprodPro(q,sum);
[a, b, c]=r2zyz(R);phi=[a b c].';%���������x
%% 
global JL
global delta_phi
delta_phi=phi_err-phi%�в�
opts=optimoptions(@fsolve);
opts.Algorithm="levenberg-marquardt";
[gamma,beta,alpha_1,~,eta,~,~,~] = paraconfig(sum);
JL = JacobLPro(gamma,alpha_1,beta,eta,phi,q);
err_sol=fsolve(@F,zeros(12,1),opts);%
a=F(err_sol);
sum=sum+err_sol;
[R,~,~,~,~] = RRR3expprodPro(q,sum);
[a, b, c]=r2zyz(R);phi=[a b c].';%���������x
delta_phi=phi_err-phi;%�в�
delta_phi
%% ��һ�ַ�ʽ��������Ч��alpha��
global JL
global delta_phi
delta_phi=phi_err-phi%�в�
opts=optimoptions(@fsolve);
opts.Algorithm="levenberg-marquardt";
[gamma,beta,alpha_1,~,eta,~,~,~] = paraconfig(sum);
JL = JacobLPro(gamma,alpha_1,beta,eta,phi,q);
alpha_err=fsolve(@F,zeros(3,1),opts);%
    err_sol=zeros(12,1);
    err_sol(4:6)=alpha_err;
sum=sum+err_sol;
[R,~,~,~,~] = RRR3expprodPro(q,sum);
[a, b, c]=r2zyz(R);phi=[a b c].';%���������x
delta_phi=phi_err-phi;%�в�
delta_phi
%% �����е�۽ṹ������
clear
num=100;
load('T_history.mat');
T=T_history;
%%
wor=["��ƽ̨\gamma_1" "��ƽ̨\gamma_2" "��ƽ̨\gamma_3" "��ƽ̨\alpha_{11}" "��ƽ̨\alpha_{12}" "��ƽ̨\alpha_{13}" "��ƽ̨\beta_1" "��ƽ̨\beta_2" "��ƽ̨\beta_3" "��ƽ̨\eta_1" "��ƽ̨\eta_2" "��ƽ̨\eta_3"...
    "\alpha_3" "a_3" "d_4" "\alpha_4" "a_4" "d_5"...
    "��ƽ̨\gamma_1" "��ƽ̨\gamma_2" "��ƽ̨\gamma_3" "��ƽ̨\alpha_{11}" "��ƽ̨\alpha_{12}" "��ƽ̨\alpha_{13}" "��ƽ̨\beta_1" "��ƽ̨\beta_2" "��ƽ̨\beta_3" "��ƽ̨\eta_1" "��ƽ̨\eta_2" "��ƽ̨\eta_3"
];
for j=1:30
    %%
for i=3:num
    %%
    [LL,rr,R_B5,qq,phi_j,phi_d,x_4,x_3_] = wholeL_getL(T{i});
    J = wholeL_Jacobian(LL,rr,R_B5,qq,phi_j,phi_d,x_4,x_3_);
    
    dotl=zeros(30,1);
    dotl(j)=0.01;
    spacevomega=J*dotl;
    R_BT=T{i}(1:3,1:3);p=T{i}(1:3,4);pp=T{i}(1:4,4);
    ppdot=skewV(spacevomega)*pp;
    vomega=spacevomega;vomega(1:3)=ppdot(1:3);
    vomega_h(:,i)=vomega;
end
save(strcat('E:\��ѧ�ļ�\����\��ҵ���\20220322�������\Lvomega_h',num2str(j)),'vomega_h');
%%
figure;
plot(vomega_h(1:3,3:end).','LineWidth',2)
legend('d_x', 'd_y','d_z')
% word=['��',num2str(j),'���ṹ������0.01���ʱĩ��ִ�������ƶ�΢��������'];
title(wor(j))
saveas(gcf,['E:\��ѧ�ļ�\����\��ҵ���\20220429���Ȼ㱨\�����е�۽ṹ�������\','�ṹ����',num2str(j),'�ƶ�.jpg']);
figure
plot(vomega_h(4:6,3:end).','LineWidth',2)
legend('\delta_x', '\delta_y','\delta_z')
% word=['��',num2str(j),'���ṹ������0.01���ʱĩ��ִ������ת��΢��������'];
title(wor(j))
saveas(gcf,['E:\��ѧ�ļ�\����\��ҵ���\20220429���Ȼ㱨\�����е�۽ṹ�������\','�ṹ����',num2str(j),'ת��.jpg']);
end
%% ����ѭ��
clear;
Lvomgea_hall=cell(30,1);
for i=1:30
    wor=['Lvomega_h',num2str(i),'.mat'];
    load(wor)
    Lvomgea_hall{i}=vomega_h(:,3:end);
end
save(strcat('E:\��ѧ�ļ�\����\��ҵ���\20220322�������\Lvomega_hall'),'Lvomgea_hall');
%% �̶����������ֵ ����Ա�
dx=zeros(length(Lvomgea_hall{1}),30);
dy=zeros(length(Lvomgea_hall{1}),30);
dz=zeros(length(Lvomgea_hall{1}),30);
deltax=zeros(length(Lvomgea_hall{1}),30);
deltay=zeros(length(Lvomgea_hall{1}),30);
deltaz=zeros(length(Lvomgea_hall{1}),30);
for i=1:length(Lvomgea_hall{1})
    for j=1:30
        dx(i,j)=Lvomgea_hall{j}(1,i);
        dy(i,j)=Lvomgea_hall{j}(2,i);
        dz(i,j)=Lvomgea_hall{j}(3,i);
        deltax(i,j)=Lvomgea_hall{j}(4,i);
        deltay(i,j)=Lvomgea_hall{j}(5,i);
        deltaz(i,j)=Lvomgea_hall{j}(6,i);
    end
end
%%
wor=["��ƽ̨\gamma_1" "��ƽ̨\gamma_2" "��ƽ̨\gamma_3" "��ƽ̨\alpha_{11}" "��ƽ̨\alpha_{12}" "��ƽ̨\alpha_{13}" "��ƽ̨\beta_1" "��ƽ̨\beta_2" "��ƽ̨\beta_3" "��ƽ̨\eta_1" "��ƽ̨\eta_2" "��ƽ̨\eta_3"...
    "\alpha_3" "a_3" "d_4" "\alpha_4" "a_4" "d_5"...
    "��ƽ̨\gamma_1" "��ƽ̨\gamma_2" "��ƽ̨\gamma_3" "��ƽ̨\alpha_{11}" "��ƽ̨\alpha_{12}" "��ƽ̨\alpha_{13}" "��ƽ̨\beta_1" "��ƽ̨\beta_2" "��ƽ̨\beta_3" "��ƽ̨\eta_1" "��ƽ̨\eta_2" "��ƽ̨\eta_3"
];
figure
plot(dx,'LineWidth',2)
% legend1 = legend(wor);
% set(legend1,...
%     'Position',[0.152213541666667 0.716694078947368 0.4796875 0.185307017543859],...
%     'NumColumns',6);
word=['dx'];
title(word)
saveas(gcf,'E:\��ѧ�ļ�\����\��ҵ���\20220429���Ȼ㱨\����ԱȾ������\dx.jpg');
figure
plot(dy,'LineWidth',2)
% legend1 = legend(wor);
% set(legend1,...
%     'Position',[0.152213541666667 0.716694078947368 0.4796875 0.185307017543859],...
%     'NumColumns',6);
word=['dy'];
title(word)
saveas(gcf,'E:\��ѧ�ļ�\����\��ҵ���\20220429���Ȼ㱨\����ԱȾ������\dy.jpg');
figure
plot(dz,'LineWidth',2)
% legend1 = legend(wor);
% set(legend1,...
%     'Position',[0.152213541666667 0.716694078947368 0.4796875 0.185307017543859],...
%     'NumColumns',6);
word=['dz'];
title(word)
saveas(gcf,'E:\��ѧ�ļ�\����\��ҵ���\20220429���Ȼ㱨\����ԱȾ������\dz.jpg');
figure
plot(deltax,'LineWidth',2)
% legend1 = legend(wor);
% set(legend1,...
%     'Position',[0.152213541666667 0.716694078947368 0.4796875 0.185307017543859],...
%     'NumColumns',6);
% word=['\delta_x'];
title(word)
saveas(gcf,'E:\��ѧ�ļ�\����\��ҵ���\20220429���Ȼ㱨\����ԱȾ������\deltax.jpg');
figure
plot(deltay,'LineWidth',2)
% legend1 = legend(wor);
% set(legend1,...
%     'Position',[0.152213541666667 0.716694078947368 0.4796875 0.185307017543859],...
%     'NumColumns',6);
% word=['\delta_y'];
title(word)
saveas(gcf,'E:\��ѧ�ļ�\����\��ҵ���\20220429���Ȼ㱨\����ԱȾ������\deltay.jpg');
figure
plot(deltaz,'LineWidth',2)
% legend1 = legend(wor);
% set(legend1,...
%     'Position',[0.152213541666667 0.716694078947368 0.4796875 0.185307017543859],...
%     'NumColumns',6);
% word=['\delta_z'];
title(word)
saveas(gcf,'E:\��ѧ�ļ�\����\��ҵ���\20220429���Ȼ㱨\����ԱȾ������\deltaz.jpg');
%% ������������ֵ100%
pard=cell(6,1);
for i=1:length(Lvomgea_hall{1})
    for j=1:6
        for k=1:30
            pard{j}(i,k)=Lvomgea_hall{k}(j,i);
        end
    end
end
save('E:\��ѧ�ļ�\����\��ҵ���\20220322�������\pard','pard');
%%
            pard=load('pard.mat');
            plotdata=cell(6,1);
            for i=1:6
                temp=pard.pard{i}.';
                count=1;
                for j=1:30
                    if temp(j,:)~=0
                    tem(count,:)=temp(j,:);
                    count=count+1;
                    end
                end
                vrds=abs(tem)./min(abs(tem));
                plotdata{i}=vrds.';
            end
            figure
            plot(plotdata{1}(10:end,:),'LineWidth',2)
            figure
            plot(plotdata{2}(10:end,:),'LineWidth',2)
            figure
            plot(plotdata{3}(10:end,:),'LineWidth',2)
            figure
            plot(plotdata{4}(10:end,:),'LineWidth',2)
            figure
            plot(plotdata{5}(10:end,:),'LineWidth',2)
            figure
            plot(plotdata{6}(10:end,:),'LineWidth',2)
%% �������΢��ͼ
word=["d_x";"d_y";"d_z";"\delta_x";"\delta_y";"\delta_z"];
for i=1:31
    joi(i)=i-1;
end
joint=joi*pi*2/30;            
% str=["��ƽ̨\gamma_1" "��ƽ̨\gamma_2" "��ƽ̨\gamma_3" "��ƽ̨\alpha_{11}" "��ƽ̨\alpha_{12}" "��ƽ̨\alpha_{13}" "��ƽ̨\beta_1" "��ƽ̨\beta_2" "��ƽ̨\beta_3" "��ƽ̨\eta_1" "��ƽ̨\eta_2" "��ƽ̨\eta_3"...
%     "\alpha_3" "a_3" "d_4" "\alpha_4" "a_4" "d_5"...
%     "��ƽ̨\gamma_1" "��ƽ̨\gamma_2" "��ƽ̨\gamma_3" "��ƽ̨\alpha_{11}" "��ƽ̨\alpha_{12}" "��ƽ̨\alpha_{13}" "��ƽ̨\beta_1" "��ƽ̨\beta_2" "��ƽ̨\beta_3" "��ƽ̨\eta_1" "��ƽ̨\eta_2" "��ƽ̨\eta_3"
% ];
str=["j_\gamma_1" "j_\gamma_2" "j_\gamma_3" "j_\alpha_{11}" "j_\alpha_{12}" "j_\alpha_{13}" "j_\beta_1" "j_\beta_2" "j_\beta_3" "j_\eta_1" "j_\eta_2" "j_\eta_3"...
    "\alpha_3" "a_3" "d_4" "\alpha_4" "a_4" "d_5"...
    "w_\gamma_1" "w_\gamma_2" "w_\gamma_3" "w_\alpha_{11}" "w_\alpha_{12}" "w_\alpha_{13}" "w_\beta_1" "w_\beta_2" "w_\beta_3" "w_\eta_1" "w_\eta_2" "w_\eta_3"
];
%%

for i=1:6
    %%
    figure
    temp=abs(d{i}.');
    temp=[temp;temp(1,:)];
        polarplot(joint,temp.','g-','LineWidth',2,'marker','.','markeredgecolor','b','markersize',20);
        hold on
        thetaticks(0:360/30:360/30*29)
        thetaticklabels(str)
%         for k=1:30
%             text(joint(k),temp(k,end),str(k));
%         end
%         if i<3.5
%             rlim([0 5])
%         else
%             rlim([0 0.01])
%         end
    title(word(i))
%     saveas(gcf,['E:\��ѧ�ļ�\����\��ҵ���\20220429���Ȼ㱨\����΢�ַ���ͼ\',num2str(i),'.jpg']);
end
%% ������
function a=F(alpha_err)
    global JL
    global delta_phi
    err_sol=zeros(12,1);
    err_sol(4:6)=alpha_err;
    a=abs(JL*err_sol)-abs(delta_phi);
%     a=JL*err_sol-delta_phi;
end