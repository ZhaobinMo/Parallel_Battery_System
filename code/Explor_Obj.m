clear;
global E_SOC_10Sparse;
load('E_SOC_10Sparse.mat');
 R_SOC = xlsread('FromOBJ.xlsx','sheet1');
 E_SOC = xlsread('FromOBJ.xlsx','sheet2');
% %%%%
% R_SOC_SOC1 = R_SOC(:,1);
% R_SOC_R1 = R_SOC(:,2);
% R_SOC_SOC2 = R_SOC(:,3);
% R_SOC_R2 = R_SOC(:,4);
% 
% E_SOC_SOC = E_SOC(:,1);
% E_SOC_E = E_SOC(:,2);
% E_10Sparse_SOC = E_SOC(1:10:end,1);
% E_10Sparse_E = E_SOC(1:10:end,2);
%E_SOC_10Sparse = E_SOC;
% %%%%
close all;
Pa.a='J';
Pa.b=[0.5 4];
figure(1);
Num=0;
Start = 0;
for i=Start:0.01:1
    Num=Num+1;
    R1(Num)=r(i,Pa);
    R2(Num)=r2(i,Pa);
    E(Num)=e(i,Pa);
end
plot(R_SOC(:,1),R_SOC(:,2),'*b');
hold on;
plot(Start:0.01:1,R1,'b','linewidth',2);
plot(R_SOC(:,3),R_SOC(:,4),'*r');
plot(Start:0.01:1,R2,'r','linewidth',2);

plot(0.0453,r(0.0453,Pa),'.b','MarkerSize',40);
plot(0.0213,r2(0.0213,Pa),'.r','MarkerSize',40);

xlabel('SOC');
ylabel('R');
set(gca,'fontsize',18);


figure(2);
% plot( E_SOC_10Sparse(:,1), E_SOC_10Sparse(:,2),'.b');
hold on;
plot(Start:0.01:1,E,'b','linewidth',2);

xlabel('SOC');
ylabel('E/V');
set(gca,'fontsize',18);

% plot(0.0453,e(0.0453,Pa),'.b','MarkerSize',40);
% plot(0.0213,e(0.0213,Pa),'.r','MarkerSize',40);




% %%Find the tangend point - 598
% D_E_10 = diff(E_SOC_10Sparse(:,2))./diff(E_SOC_10Sparse(:,1));
% D_E_to0=( E_SOC_10Sparse(:,2)-E_SOC_10Sparse(end,2) )...
%     ./( E_SOC_10Sparse(:,1)-0 ) ;
% D_D=zeros(length(D_E_10),1);
% for i=1:length(D_D)
%     D_D(i)=abs(D_E_10(i)-D_E_to0(i));
% end
% find(D_D(end:-1:300)==min(D_D(end:-1:300)));
% hold on;
% plot(D_D(end:-1:1),'*r');

%%dV/dQ
Gap = 50;
close(figure(1));
dE_SOC = diff(E_SOC(end:-1*Gap:1,2))./diff(E_SOC(end:-1*Gap:1,1))/2.9402;
plot(E_SOC(end-1*Gap:-1*Gap:1,1),dE_SOC,'linewidth',2);
xlim([0 1]);
ylim([0 1]);
legend('25deg Discharge');
xlabel('SOC');
ylabel('dV/dQ(Ah)');
set(gca,'fontsize',18);