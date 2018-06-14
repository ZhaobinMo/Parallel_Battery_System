	% command window of 02-Oct.-2017 for zhaobin's reference

% raw data of SOC-OCV has some confliction points, say (1,3.95998£©,£¨1,3.95997£© thus we adopt 1 out of adjacent 10 points. Use the below simpleF function to perform.
clear;
fid = loadobj('For simulation on OCV regions.obj');
global simpleSOC
global simpleOCV
simpleSOC=nan(625,1);
j=1;
for i=1:10:length(SOC)
    simpleSOC(j)=SOC(i,1);
    j=j+1;
end
simpleOCV=nan(625,1);
j=1;
for i=1:10:length(OCV)
    simpleOCV(j)=OCV(i,1);
    j=j+1;
end

% remember the global also needs to be done in the m.file 

options = odeset('RelTol',1e-6,'AbsTol',[1e-6 1e-6]);
[T,X]=ode45(@zheli4,0:0.001:0.98,[1 1],options);
subplot(2,1,1);
plot(T,X(:,1),'r',T,X(:,2),'b')
subplot(2,1,2);
plot(T(1:980,1),1000*2.9402*diff(X(:,1)),'r',T(1:980,1),1000*2.8307*diff(X(:,2)),'b')

% reason that deduced from 1 to 0.98 is OCV curve is too sharp to be accurately fitted at SOC=0~0.02.
% once tried to use the full OCV range, but the fitting between 0.98 to 1 leads to some odd data such as OCV>100

% for the spline fitting of SOC-OCV and SOC-DCR please see the zheli4.m for details

