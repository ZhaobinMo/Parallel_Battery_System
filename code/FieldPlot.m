clc;
% clear;
close all;
 run('initial.m');
k1=PaE1.b(1);
b1=PaE1.b(2);
k2=PaE2.b(1);
b2=PaE2.b(2);
m1=PaR1.b(1);
n1=PaR1.b(2);
m2=PaR2.b(1);
n2=PaR2.b(2);

%%%%##求向量场图
%%%%##6求向量场图
global I00;
I00=I0;%I00=-I00;
xmin=0;
xmax=3;
dtx=.01;
dtX=.1;
Thresh=1e13;
x=xmin:dtx:xmax;
y=xmin:dtx:xmax;
x1=zeros(length(x),length(y));
y1=zeros(length(x),length(y));

%%
%%%%%%%%%去掉r1+r2项
figure(2);
xn=xmin:dtx:xmax;
yn=xmin:dtx:xmax;
xn1=zeros(length(xn),length(yn));
yn1=zeros(length(xn),length(yn));

for m=1:length(xn)          
    for n=1:length(yn)
        E_1=e(xn(m),PaE1);
        E_2=e2(yn(n),PaE2);
        R_1=r(xn(m),PaR1);
        R_2=r2(yn(n),PaR2);
%         %%Copy from resis file to check if they are the same
%         E(1)=E_1;
%         E(2)=E_2;
%         R(1)=R_1;
%         R(2)=R_2;
%         a=0;b=0;
%         for i=1:p
%             a=a+E(i)/(R(i));
%             b=b+1/(R(i));
%         end
%         for i=1:p
%             dy(i)=((a+I0)/b-E(i))/(C(i)*R(i));
%         end
%         
%         xn1(n,m)=dy(1);
%         yn1(n,m)=dy(2);
%         %%
        xn1(n,m)=(E_2-E_1+R_2*I00)/(R_1+R_2)/C(1);
        yn1(n,m)=(E_1-E_2+R_1*I00)/(R_1+R_2)/C(2);
    end;
end;
X=xmin:dtX:xmax;
Y=xmin:dtX:xmax;
X1=zeros(length(X),length(Y));
Y1=zeros(length(X),length(Y));
for m=1:length(X)
    for n=1:length(Y)
        %         X1(n,m)=(e(Y(n),PaE2)-e(X(m),PaE1)+r(Y(n),PaR2)*I00)/C(1)/(r(X(m),PaR1)+r(Y(n),PaR2));
        %         Y1(n,m)=(e(X(m),PaE1)-e(Y(n),PaE2)+r(X(m),PaR1)*I00)/C(2)/(r(X(m),PaR1)+r(Y(n),PaR2));
        EE_1=e(X(m),PaE1);
        EE_2=e2(Y(n),PaE2);
        RR_1=r(X(m),PaR1);
        RR_2=r2(Y(n),PaR2);
        X1(n,m)=(EE_2-EE_1+RR_2*I00)/(RR_1+RR_2)/C(1);
        Y1(n,m)=(EE_1-EE_2+RR_1*I00)/(RR_1+RR_2)/C(2);
    end;
end;
dens=10;
stx=[linspace(xmin,xmax,dens),linspace(xmax,xmax,dens),linspace(xmax,xmin,dens),linspace(xmin,xmin,dens)];
sty=[linspace(xmax,xmax,dens),linspace(xmax,xmin,dens),linspace(xmin,xmin,dens),linspace(xmin,xmax,dens)];
h=streamline(xn,yn,xn1,yn1,stx,sty);
set(h,'color','b','linewidth',2);
%X,Y,X1,Y1,stx,sty
%x,y,x1,y1,stx,sty
axis square
hold on;
xr=xmin:.1:xmax;            
yr=-m1/m2.*xr-(n1 + n2)/m2;
A1=(k1-k2-sqrt((k1-k2)^2+4*(k1+I00*m1)*(k2+I00*m2)))/(2*(k2+I00*m2));
B1=(-A1*(b1*m2-b2*m2+k2*n1+I00*m2*n1+k2*n2)-b1*m1+b2*m1+k1*n1+k1*n2+I00*m1*n2)*1/(-k2*m1-k1*m2-I00*m1*m2);
A2=(k1-k2+sqrt((k1-k2)^2+4*(k1+I00*m1)*(k2+I00*m2)))/(2*(k2+I00*m2));
B2=(-A2*(b1*m2-b2*m2+k2*n1+I00*m2*n1+k2*n2)-b1*m1+b2*m1+k1*n1+k1*n2+I00*m1*n2)*1/(-k2*m1-k1*m2-I00*m1*m2);
yA1=A1.*xr+B1;
yA2=A2.*xr+B2;
plot(xr,yr,'r',xr,yA1,'k',xr,yA2,'k','linewidth',3  );

axis square;
[X,Y] = meshgrid(X,Y);
% X1(X1>1)=1;X1(X1<-1)=-1;
% Y1(Y1>1)=1;Y1(Y1<-1)=-1;
a=quiver(X,Y,X1,Y1,'Linewidth',0.5);
 set(a,'Autoscalefactor',0.5,'color','k');
axis([xmin xmax xmin xmax]);
ylabel('SOC_2','fontsize',18,'FontWeight','bold');
xlabel('SOC_1','fontsize',18,'FontWeight','bold');
% set(gca,'ytick',[0 2 4 6],'yticklabel',{'0','2','4','6'});
% set(gca,'xtick',[0 2 4 6],'xticklabel',{'0','2','4','6'});
set(gca,'fontsize',18,'fontweight','bold');
% title('相轨迹图','fontsize',18,'FontWeight','bold')
%text(xmax-1,xmax+0.2,'向量单位化','fontsize',14);
text(xmin,xmax+0.2,strcat('I=',num2str(I00),'A'),'fontsize',14);
%xr=1.3:.01:1.45;
%yr=2.75-xr;%%这些事画不动点和其所在特征直线
hold on;
plot([0 1],[1 1],'--b');
plot([1 1],[0 1],'--b');
plot([xmax xmax],[xmin xmax],'k');
hold on;
plot([xmin xmax],[xmax xmax],'k');
plot([0 0],[xmin xmax],'k');
plot([xmin xmax],[0 0],'k');

% %%Plot the SOC_CP
% load('SOC_CP_Normal.mat');
% load('SOC_CP_Partial.mat');
% hold on;
% plot(SOC_CP_Normal(:,1),SOC_CP_Normal(:,2),'.k','linewidth',2);