function [costFunc,path] = pathFinder(u,center,trx,v)
Mn = size(u,1); %Sensor Node Number
eta = [];
eta_s = [];
for i = 1:size(u,1)
    tfb = dstnc(u(i,:),center)*v^-1;
    txb = trx(i);
%     eta_s(1,i) = tfb + txb; 
    eta_s(1,i) = tfb;
   for j =1:size(u,1)
      if (i ~= j)
          tf = dstnc(u(i,:),u(j,:))*v^-1;
          tx = trx(i);
%           eta(i,j) = tx + tf; 
          eta(i,j) = tf; 
         
      end
   end   
end

S = {};
for i = 1:Mn
   S(1,i) = {[i]}; 
end
    tt = 1;
    Sn = S;
    subset = {};
    ind = 1:1:Mn;
    ind = sum(2.^ind);
    costt = ones(Mn,ind)*NaN;
for i = 1:Mn % node number
    Sn = S;
    Sn{1,i} = [];
    Sn = cell2mat(Sn);
    t=1;
    ix=[];
    for j = 1:1:length(Sn) % subset value number 
        subset{t} = [nchoosek(Sn,j)];
        subs = cell2mat(subset(t));
        for k = 1:size(subs,1) % subset choose
            sub = subs(k,:);
            sub = perms(sub);
            cost_n = zeros(1,size(sub,1));
            for kk = 1:size(sub,1)        
                subb = sub(kk,:);
                dd = ['subset =',num2str(subb),'  node >',num2str(i),'   pathnumber>',num2str(tt)];
                %disp(dd);
                cost_n(1,kk,1) = minpathcost(i,subb,eta,eta_s,costt);
                %sub(kk,:)
            end   
        cost(tt) = min(cost_n);
        idx = sum(2.^subb);
        costt(i,idx) = cost(tt);
        %ix = find(cost_n==cost(tt));
        %pathh{i,idx} = sub(ix(1),:);
        %tt = tt+1;
        end
        t=t+1;
    end
end

%FIND OPTIMAL NODE
vv = 1:1:Mn;
first = [];
for i = 1:length(vv)
    v = vv;
    v(v==i) = [];
    index = sum(2.^v);
    first = [first costt(i,index)];
end
[X1,firstNode] = min(first);

%FIND PATH
currentNode = firstNode;
path = [currentNode];
valMat = [];
 for i = 1:Mn
    vv(vv == currentNode) = [];
    if (length(vv) > 1)
    for j = 1:length(vv)
        temp = vv;
        n = vv(j);
        temp(temp == n) = [];   
            ind = sum(2.^temp);
            val = costt(n,ind) + dstnc(u(currentNode,:),u(n,:));
            valMat(j,:) = [val , n];     
    end
    [~,I] = min(valMat(:,1));
    currentNode = valMat(I,2);
    elseif(isempty(vv))
        currentNode = 0;
    else
        currentNode = vv;
    end
    path = [path currentNode];
 end


costFunc = [];
path_tmp = path(1:end-1);
for i = 1:Mn
    n = path(i);
    if(i ~= Mn)
    path_tmp(path_tmp == n) = [];
    ind = sum(2.^path_tmp);
    costFunc(1,i) = costt(n,ind);
    else
    costFunc(1,i) = eta_s(n) ;
    end
end

costFunc = costFunc + trx;
end

