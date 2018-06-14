function dy=zheli4(t,x)
dy=[0;0];

% 1 is the new and 2 is the aged cell
% one could give SOC1 and DCR1,SOC2 and DCR2 here,I did not know why indicating in the
% worksapce and global them here does not work.

SOC1=[1
0.97091
0.92081
0.87071
0.8206
0.7705
0.72038
0.67027
0.62016
0.57006
0.51996
0.46985
0.41975
0.36963
0.3195
0.26939
0.21928
0.16918
0.11907];
DCR1=[0.04208
0.03734
0.03806
0.0391
0.03897
0.03845
0.03845
0.03877
0.03916
0.03961
0.04026
0.04085
0.04149
0.04247
0.04311
0.04421
0.04538
0.04707
0.05063];
SOC2=[1
0.94805
0.89609
0.84414
0.79219
0.74023
0.68828
0.63633
0.58438
0.53242
0.48047
0.42852
0.37657
0.32462
0.27267
0.22072
0.16876
0.11681
0.06486];
DCR2=[0.05763
0.05649
0.05803
0.05898
0.0581
0.05769
0.05884
0.05951
0.05978
0.06066
0.0616
0.06268
0.06362
0.06476
0.06665
0.0686
0.0717
0.07661
0.08725];
R1=interp1(SOC1,DCR1,x(1),'spline');
R2=interp1(SOC2,DCR2,x(2),'spline');
% if else R fits the linear hypothesis
%c=[-0.05402,0.0971;];
%R1=c(1)*x(1)^1+c(2)*x(1)^0;
%R2=c(1)*x(2)^1+c(2)*x(2)^0+0.08;
 
% in the command window the discreat interval of computing is 0.001 SOC
global simpleSOC
global simpleOCV
E1=interp1(simpleSOC,simpleOCV,x(1),'spline');
E2=interp1(simpleSOC,simpleOCV,x(2),'spline');
% if else E fits the polynomial fitting
%Interp=2.22751;
%B1=1.96753;
%B2=0;
%B3=0;
%B4=0;
%B5=0;
%B6=0;
%B7=0;
%B8=0;
%E1=Interp+B1*x(1)^1+B2*x(1)^2+B3*x(1)^3+B4*x(1)^4+B5*x(1)^5+B6*x(1)^6+B7*x(1)^7+B8*x(1)^8;
%E2=Interp+B1*x(2)^1+B2*x(2)^2+B3*x(2)^3+B4*x(2)^4+B5*x(2)^5+B6*x(2)^6+B7*x(2)^7+B8*x(2)^8;
 
c1=2.9402;
c2=2.8307;
I=-(c1+c2);
 
dy(1)= ((E2-E1)+R2*I)/(R1+R2)/c1;
dy(2)= (I-c1*dy(1))/c2;
end
