joid=load('joid.mat');
plotdata=cell(6,1);
for i=1:6
    temp=joid.joid{i}.';
    vrds=abs(temp)./max(abs(temp));
    plotdata{i}=vrds.';
end
figure
plot(plotdata{1},'LineWidth',2)
legend('�ؽ�1','�ؽ�2','�ؽ�3','�ؽ�4','�ؽ�5','�ؽ�6','�ؽ�7' )
figure
plot(plotdata{2},'LineWidth',2)
legend('�ؽ�1','�ؽ�2','�ؽ�3','�ؽ�4','�ؽ�5','�ؽ�6','�ؽ�7' )
figure
plot(plotdata{3},'LineWidth',2)
legend('�ؽ�1','�ؽ�2','�ؽ�3','�ؽ�4','�ؽ�5','�ؽ�6','�ؽ�7' )
figure
plot(plotdata{4},'LineWidth',2)
legend('�ؽ�1','�ؽ�2','�ؽ�3','�ؽ�4','�ؽ�5','�ؽ�6','�ؽ�7' )
figure
plot(plotdata{5},'LineWidth',2)
legend('�ؽ�1','�ؽ�2','�ؽ�3','�ؽ�4','�ؽ�5','�ؽ�6','�ؽ�7' )
figure
plot(plotdata{6},'LineWidth',2)
legend('�ؽ�1','�ؽ�2','�ؽ�3','�ؽ�4','�ؽ�5','�ؽ�6','�ؽ�7' )
%%
pard=load('pard.mat');
plotdata=cell(6,1);
for i=1:6
%     temp=pard.pard{i}.';
%     vrds=abs(temp)./max(abs(temp));
%     plotdata{i}=vrds.';
    plotdata{i}=pard.pard{i};
end
figure
plot(plotdata{1},'LineWidth',2)
figure
plot(plotdata{2},'LineWidth',2)
figure
plot(plotdata{3},'LineWidth',2)
figure
plot(plotdata{4},'LineWidth',2)
figure
plot(plotdata{5},'LineWidth',2)
figure
plot(plotdata{6},'LineWidth',2)