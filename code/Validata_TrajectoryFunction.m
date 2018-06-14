global I0;
run('mulirun_plot.m');
close all;
for i=1:length(Yt);
    mI=-1*I0;%i:discharge  i+1:charge
    left = Yt{i}(:,1)-Yt{i}(:,2);
    right = (2-(Yt{i}(:,1)+Yt{i}(:,2))).^(-(2+mI)/mI);
    ratio = left./right;
    figure(1);
    subplot(2,1,1);
    plot(Yt{i}(:,1));
    hold on;
    plot(Yt{i}(:,2));
    subplot(2,1,2);
    plot(ratio);
    hold on;
end