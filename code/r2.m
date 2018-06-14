function r=r2(x,Pa);   global tri;
c=[-311.7,858.5,-626.6,-290.7,654.1,-368.1,96.2,-12.5,1.0];
p=[ 71.79,...
    -319.5,...
    599.5,...
    -617.3,...
    380.4 ,...
    -143.2,...
    32.07 ,...
    -3.925,...
    0.2477 ];


SOC2=[1
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
DCR2=[0.04208
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

% if x>1
%     x=1.001;
%     if x<0
%         x=-0.001;
%     end;
% end;
if Pa.a=='O'
    r=c(1)*x^8+c(2)*x^7+c(3)*x^6+c(4)*x^5+c(5)*x^4+c(6)*x^3+c(7)*x^2+c(8)*x^1+c(9)*x^0;
elseif Pa.a =='J'
   % r=p(1)*x^8+p(2)*x^7+p(3)*x^6+p(4)*x^5+p(5)*x^4+p(6)*x^3+p(7)*x^2+p(8)*x^1+p(9)*x^0;
    r=interp1(SOC2,DCR2,x,'spline');
elseif Pa.a=='M'
    r=0;
    for i=1:length(Pa.b)
        r=r+Pa.b(length(Pa.b)+1-i)*x^(i-1);
    end;
elseif Pa.a=='E'
    r=Pa.b(1)*exp(Pa.b(2)*x)+Pa.b(3)*exp(Pa.b(4)*x);
elseif Pa.a=='S'
    r=Pa.b(1)*sin(Pa.b(2)*x)+Pa.b(3);
    
end;
% if r>0.5
%     r=0.5
% end
% 输入SOC 通过差值法返回r