function e=e(x,Pa)
global E_SOC_10Sparse;
Interp=3.015861; B1=5.35916; B2=-13.31803; B3=15.25363; B4=-6.21085;
p=[ 5457,...
    -2.572e+04,...
    5.147e+04,...
    -5.698e+04,...
    3.816e+04,...
    -1.587e+04,...
    4048,...
    -602.9,...
    47.39,...
    1.663 ];
% if x>1
%     x=1.001;
%     if x<0
%         x=-0.001;
%     end;
% end;
if Pa.a=='O'
    e=Interp+B1*x^1+B2*x^2+B3*x^3+B4*x^4;
elseif Pa.a=='J'
    %     e=p(1)*x^9 + p(2)*x^8 + p(3)*x^7 + p(4)*x^6 +...
    %         p(5)*x^5 + p(6)*x^4 + p(7)*x^3 + p(8)*x^2 +...
    %         p(9)*x + p(10);
    if x>=E_SOC_10Sparse(596,1)
        e=interp1(E_SOC_10Sparse(:,1),E_SOC_10Sparse(:,2),x,'spline');
    else
        e=interp1(E_SOC_10Sparse(:,1),E_SOC_10Sparse(:,2),x,'linear');
    end
elseif Pa.a=='M'
    e=0;
    for i=1:length(Pa.b)
        e=e+Pa.b(length(Pa.b)+1-i)*x^(i-1);
    end;
elseif Pa.a=='E'
    e=Pa.b(1)*exp(Pa.b(2)*x)+Pa.b(3)*exp(Pa.b(4)*x);
elseif Pa.a=='S'
    e=Pa.b(1)*sin(Pa.b(2)*x)+Pa.b(3);
end;

%e=5*x+2;
%输入soc，通过插值法返回e