clc;
clear;
close all;
run('initial.m');
%============================把r-soc曲线和e-soc曲线画出来================================
figure(4)%%%e-soc
hold on;
Interp=3.015861; B1=5.35916; B2=-13.31803; B3=15.25363; B4=-6.21085; x=[0:0.01:1];
% e(1,:)=Interp+B1.*x.^1+B2.*x.^2+B3.*x.^3+B4.*x.^4;
% e(2,:)=0.2.*x.^2+1.9.*x+3.2;
j=0;
for x=0:0.01:1
    j=j+1;
    if PaE1.a=='O'
        
        e(j,1)=Interp+B1*x^1+B2*x^2+B3*x^3+B4*x^4;
        record_y(j)=e(j,1)
        record_x(j)=x
    elseif PaE1.a=='M'
        e(j,1)=0;
        for i=1:length(PaE1.b)
            e(j,1)=e(j,1)+PaE1.b(length(PaE1.b)+1-i)*x^(i-1);
        end;
    elseif PaE1.a=='E'
        e(j,1)=PaE1.b(1)*exp(PaE1.b(2)*x)+PaE1.b(3)*exp(PaE1.b(4)*x);
    elseif PaE1.a=='S'
        e(j,1)=PaE1.b(1)*sin(PaE1.b(2)*x)+PaE1.b(3);
    end;
    e(j,2)=e(j,1);%%%%%这里是两条e曲线的差距！！
end;

for i=1:p
    plot([0:0.01:1],e(:,i),color(i),'linewidth',4);
    hold on;
end;
ylabel('E/V','fontsize',18,'FontWeight','bold');
xlabel('SOC','fontsize',18,'FontWeight','bold');
set(gca,'fontsize',18,'FontWeight','bold');
%title('E-SOC曲线','fontsize',18,'FontWeight','bold')
%legend('E1','E2');
hold on;
%%%plot a black line from the start to the end
%plot([0 1],[e(1,1) e(length(e(:,1)),1)],'k','linewidth',4);
figure(5)
c=[-311.7,858.5,-626.6,-290.7,654.1,-368.1,96.2,-12.5,1.0];
j=0;
for x=0:0.01:1
    j=j+1;
    if PaR1.a=='O'
        r(j,1)=c(1)*x^8+c(2)*x^7+c(3)*x^6+c(4)*x^5+c(5)*x^4+c(6)*x^3+c(7)*x^2+c(8)*x^1+c(9)*x^0;
    elseif PaR1.a=='M'
        r(j,1)=0;
        for i=1:length(PaR1.b)
            r(j,1)=r(j,1)+PaR1.b(length(PaR1.b)+1-i)*x^(i-1);
        end;
    elseif PaR1.a=='E'
        r(j,1)=PaR1.b(1)*exp(PaR1.b(2)*x)+PaR1.b(3)*exp(PaR1.b(4)*x);
    elseif Pa.a=='S'
        r(j,1)=PaR1.b(1)*sin(PaR1.b(2)*x)+PaR1.b(3);
    end;
    r(j,2)=r(j,1);%%%%%这里是两条r曲线的差距！！
end;%把r的曲线画出来
de=diff(e(:,1))/0.01;
dr=diff(r(:,1))/0.01;
hold on;
for i=1:p
    plot([0:0.01:1],r(:,i),color(i),'linewidth',4);
end;
plot([0 1],[round(r(1,1)) round(r(length(e(:,1)),1))],'k','linewidth',4);
% set(gca,'ytick',1.4:0.2:2.4,'yticklabel',{'','1.6','1.8','2','2.2','2.4'});
% axis([0 1 1.4 2.4]);
ylabel('r/Ω','fontsize',18,'FontWeight','bold');
xlabel('SOC','fontsize',18,'FontWeight','bold');
set(gca,'fontsize',18,'FontWeight','bold');
%title('r-SOC曲线','fontsize',18,'FontWeight','bold')
%legend('r1=-4.8x+5','r2=-4.8x+5.2');