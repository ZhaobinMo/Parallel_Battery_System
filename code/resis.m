% m function
function dy=resis(t,x)    %函数的输入为时间t和各路的SOC x
global C;global I0;global p;global dr;global PaR1;global PaR2; global PaE1;global PaE2;global tri
display(['I0=' num2str(I0)]);
dy=[];
for i=1:p
    dy=[dy;0];
end  %各路soc的导数，赋零值
tri.a=tri.a+1;
%%
%%%%======================================================
%%%%==以下是原程序，r的差异人为取一个0.9与1.1倍或直线平移=================
%%%%=======================================================
% for i=1:p
%     tri.s(i,tri.a)=x(i);
% %     R(i)=(1+dr*2*((i-1)/(p-1)-0.5))*r(x(i),PaR1);%各路的R r1=0.9;r2=1.1
%     R(i)=r(x(i),PaR1)+(i-1)*dr;%r1=r(x) r2=r(x)+dr
%     tri.r(i,tri.a)=R(i);
% end   
%%
%%%%======================================================
%%%%==以下是新程序，r1由原程序，r2由新的r2函数=================
%%%%=======================================================
tri.s(tri.a,1)=x(1);
tri.s(tri.a,2)=x(2);
R(1)=r(x(1),PaR1);
tri.r(tri.a,1)=R(1);
R(2)=r2(x(2),PaR2);
tri.r(tri.a,2)=R(2);

%%
% for i=1:p
%     E(i)=e(x(i),PaE);
%     tri.e(i,tri.a)=E(i);
% end  %各路的E
%%%%======================================================
%%%%==以下是新程序，e1由原程序，e2由新的r2函数=================
%%%%=======================================================
E(1)=e(x(1),PaE1);
tri.e(tri.a,1)=E(1);
E(2)=e2(x(2),PaE2); 
tri.e(tri.a,2)=E(2);

a=0;b=0;
for i=1:p
    a=a+E(i)/(R(i));
    b=b+1/(R(i));
end
for i=1:p
    dy(i)=((a+I0)/b-E(i))/(C(i)*R(i));
end  %根据分流公式计算各路soc的导数； 计算结果为（e2-e1+I0*r2）/(C1*(r1+r2)) correct


end


