function [] = plotter(R1,R2,C,L2L1,a1,a2,loc_minmaxtime,d)

k1 = C-R1;
k2 = C-R2;
step = .1;
%% 

x = 0:step:R1;
m = 10*step;
comp_func = @(x) R2.*(x < k2) + (-x+R2+k2).*((x < R1-m)&(x > k2))...
    + (-(x-R1).*k1/m).*((x >= R1-m)&(x < R1)) + 0.*(x >= R1);
% comp_func = @(x) R2.*(x < k2) + (-x+R2+k2).*((x < R1)&(x > k2))...
%     + k1.*(x == R1) + 0.*(x > R1);
plot(x,comp_func(x));
hold on;
grid on;
%% 


lin_func = @(x) x.*(L2L1);

plot(x,lin_func(x));
hold on
grid on;

scatter(a1,a2);
hold on;

lambda = (a1-R1)/(k2-R1);
lambda = round(lambda,2);
title(['m:',num2str(L2L1),' x:',num2str(loc_minmaxtime/d),'  \lambda:',num2str(lambda,2)]);
axis([0 R1+R1/8 0 R2+R2/8]);
end

