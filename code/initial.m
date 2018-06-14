global p;   %并联电池数量
global dr;  %电阻浮动百分比的上下限
global C;   %电池平均容量
global PaE1;
global PaE2;
global PaR1;
global PaR2;
global tri;
global options;
global E_SOC_10Sparse;
load('E_SOC_10Sparse.mat');
tri.a=0;tri.r=[];tri.e=[];tri.s=[];
PaE1.a='M';PaE1.b=[1 4];
PaE2.a='M';PaE2.b=[1 4];
PaR1.a='M';PaR1.b=[-1 1.8];
PaR2.a='M';PaR2.b=[-1 1.8];%初始的e、r曲线都是测量值Original


dr=0.5;
dc=0;
color=['b','r','c','k','y','m','g'];
p=2;
acuracy=zeros(p,1);
for i=1:p
    acuracy(i)=1e-8;
end
options = odeset('RelTol',1e-10,'AbsTol',acuracy,'Events',@eventBoundary);      %设置求解方程的精度

C=zeros(p,1);

for i=1:p;
    C(i)=0.5*(1+dc*2*((i-1)/(p-1)-0.5));
end              %计算各个支路电池的容量大小


global I0;       %输入电流，正为充电，负为放电
rate=1;        %充放电倍率
I0=0;
for i=1:p
    I0=I0-C(i)*rate;
end        %根据倍率计算输入电流
%  I0 = abs(I0); %Charging first
%I0=0.5;
SOC=zeros(p,1);
for i=1:p
    SOC(i)=1;
end        %初始SOC
disp(['-n/m=' num2str(-PaR1.b(2)/PaR1.b(1))]);
disp(['mI=' num2str(PaR1.b(1)*I0) ' -mI-2k=' num2str(-PaR1.b(1)*I0-2*PaE1.b(1))]);

SOC(1)=0;SOC(2)=0.5;
global t;
t=2.1/rate; %第一次计算总仿真时间
tintv=1000;
global dt;
dt=t/tintv;  %仿真步长