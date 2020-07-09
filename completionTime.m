function [a1,a2] = completionTime(R1,R2,C,L1,L2)
options = optimset('Display','off');
k1 = C-R1;
k2 = C-R2;
step = 0.1;
%% 

x = 0:step:R1;
m = 10*step;
comp_func = @(x) R2.*(x < k2) + (-x+R2+k2).*((x < R1-m)&(x > k2))...
    + (-(x-R1).*k1/m).*((x >= R1-m)&(x < R1)) + 0.*(x >= R1);
% comp_func = @(x) R2.*(x < k1) + (-x+R2+k1).*((x < R1-m)&(x > k1))...
%     + (-(x-R1).*k2/m).*((x >= R1-m)&(x < R1)) + 0.*(x >= R1);
plot(x,comp_func(x));
hold on;
%% 

% lin = x*(L1/L2);
x = 0;
y = 0;
lin_func = @(x) x.*(L2/L1);

plot(x,lin_func(x));
hold on
%%
sol = @(x) comp_func(x) - lin_func(x);
x_sol = fsolve(sol,0,options);
a1 = x_sol;
a2 = comp_func(x_sol);
scatter(x_sol,comp_func(x_sol));
hold on;

end

