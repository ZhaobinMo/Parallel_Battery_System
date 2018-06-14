clc;
clear;
close all;
run('initial.m');
global I00;global I0;
I00=I0;
runturn=10;
[Yt,I]=mutirun(SOC,runturn);
%%%%%%%%#======================.figure(1)SOC-t图=============================
%%%%===========================.figure(2)I-t图=========================
%%
figure(1);
runturnst=0;
for k=1:runturn

    hold on;
    for i=1:p
        runturned=length(Yt{k}(:,i));
        plot(runturnst*dt:dt:(runturnst+length(Yt{k}(:,i))-1)*dt,Yt{k}(:,i),color(i),'linewidth',1);
    end;
    runturnst=runturnst+length(Yt{k}(:,i));
end;

xlabel('t/h','fontsize',18,'fontweight','bold');
ylabel('SOC','fontsize',18,'fontweight','bold');
% title('SOC-t曲线','fontsize',18,'fontweight','bold');
set(gca,'fontsize',18,'fontweight','bold');
% legend('r1=0.8x1+1.2','r2=0.8x2+1');
figure(2);
runturnst=0;
for k=1:runturn
    hold on;
    for i=1:p
        runturned=length(I{k}(:,i));
        plot(runturnst*dt:dt:(runturnst+length(I{k}(:,i))-1)*dt,I{k}(:,i),color(i),'linewidth',1);
    end;
    runturnst=runturnst+length(I{k}(:,i));
end;

xlabel('t/h','fontsize',18,'fontweight','bold');
ylabel('I/A','fontsize',18,'fontweight','bold');
% title('I-t曲线','fontsize',18,'fontweight','bold');
set(gca,'fontsize',18,'fontweight','bold');
% legend('I1','I2');
 a=xlim;
 plot([0 a(2)],[0 0],'k');
%%
%%%###============================figure(3)SOC1-SOC2的相图=====================
% 
% figure(3);
% run('FieldPlot.m');
% % close(figure(1));
% % close(figure(2));
figure(3);
hold on;
for  i=1:runturn
    plot(Yt{i}(:,1),Yt{i}(:,2),color(1+mod(i,2)),'linewidth',1);
end;
plot([0,1],[1,1],'k');
plot([1,1],[0,1],'k');
% x=0:.1:.9;
% plot(x,x+.1,'k','linewidth',2);

axis square;
xlabel('SOC1','fontsize',18,'fontweight','bold');
ylabel('SOC2','fontsize',18,'fontweight','bold');
%title(strcat('反复充放',num2str(runturn),'次'),'fontsize',18,'fontweight','bold');
axis([0 1 0 1]);
% 
% Box=[0 0.35];Box_Width=2;
% plot([Box(1) Box(2)],[Box(1) Box(1)],'k','linewidth',Box_Width);
% plot([Box(2) Box(2)],[Box(1) Box(2)],'k','linewidth',Box_Width);
% plot([Box(2) Box(1)],[Box(2) Box(2)],'k','linewidth',Box_Width);
% plot([Box(1) Box(1)],[Box(2) Box(1)],'k','linewidth',Box_Width);

set(gca,'fontsize',18,'fontweight','bold');

k1=PaE1.b(1);
b1=PaE1.b(2);
k2=PaE2.b(1);
b2=PaE2.b(2);
m1=PaR1.b(1);
n1=PaR1.b(2);
m2=PaR2.b(1);
n2=PaR2.b(2);
AD=(k1-k2+sqrt((k1-k2)^2+4*(k1+I00*m1)*(k2+I00*m2)))/(2*(k2+I00*m2));
BD=(-AD*(b1*m2-b2*m2+k2*n1+I00*m2*n1+k2*n2)-b1*m1+b2*m1+k1*n1+k1*n2+I00*m1*n2)*1/(-k2*m1-k1*m2-I00*m1*m2);
I00=-I00;
AC=(k1-k2+sqrt((k1-k2)^2+4*(k1+I00*m1)*(k2+I00*m2)))/(2*(k2+I00*m2));
BC=(-AC*(b1*m2-b2*m2+k2*n1+I00*m2*n1+k2*n2)-b1*m1+b2*m1+k1*n1+k1*n2+I00*m1*n2)*1/(-k2*m1-k1*m2-I00*m1*m2);
I00=2*I00;
AC2=(k1-k2+sqrt((k1-k2)^2+4*(k1+I00*m1)*(k2+I00*m2)))/(2*(k2+I00*m2));
BC2=(-AC*(b1*m2-b2*m2+k2*n1+I00*m2*n1+k2*n2)-b1*m1+b2*m1+k1*n1+k1*n2+I00*m1*n2)*1/(-k2*m1-k1*m2-I00*m1*m2);
I00=-I00;
xr=0:0.1:1;
yAD=AD.*xr+BD;
yAC=AC.*xr+BC;
yAC2=AC2.*xr+BC2;
%plot(xr,yAD,'--b',xr,yAC,'--r','linewidth',4);
hold on;
% plot(xr,yAC2,'--g','linewidth',4);
plot([0 1],[0 1],'k');
% set(gca,'ytick',[0  0.5  1],'yticklabel',{'0','0.5','1'});
% set(gca,'xtick',[0  0.5  1],'xticklabel',{'0','0.5','1'});
%legend('Discharging Orbit','Charging Orbit','Discharging Eigenline','Charging Eigenline');



