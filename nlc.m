function [c,ceq] = nlc(x)
%%
global L1_nlc
global L2_nlc
global h_nlc
global P_nlc
global d_nlc
%parameters
% h = 100;
B = 10^5;
beta = 10^-4;
sigma = 10^-7;
%beta = 1;
%sigma = 1;
% P = 1;
% d = 100;
k1 = (beta*P_nlc)/sigma;
k2 = (beta*P_nlc)/sigma;

%%
%Rate Eqs
%C(x) = B*log2(1+k2/((d-x)^2+h^2 )+k1/(x^2+h^2 ));
%R1(x) = B*log2(1+k1/(x^2+h^2 ));
%R2(x) = B*log2(1+k2/((d-x)^2+h^2 ));
%%
%constraints
c(1) = L1_nlc/x(3) - x(2);
c(2) = L2_nlc/x(4) - x(2);
c(3) = x(3) - B*log2(1+k1/(x(1)^2+h_nlc^2 ));
c(4) = x(4) - B*log2(1+k2/((d_nlc-x(1))^2+h_nlc^2 ));
c(5) = x(3) + x(4) - B*log2(1+k2/((d_nlc-x(1))^2+h_nlc^2 )+k1/(x(1)^2+h_nlc^2 ));
ceq = [];
end

