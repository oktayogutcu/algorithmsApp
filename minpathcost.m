function [path_cost] = minpathcost(i,sub,eta,eta_s,mcost)
    index = sum(2.^sub);
     if(isempty(sub))
            path_cost =eta_s(i);
             d = [i 0];
             %disp(d);
            %disp('bitdu');
    
     elseif(~isnan(mcost(i,index)))
        path_cost = mcost(i,index); 
     
     else         
            k = sub(1);
            path_cost = eta(i,k);
            sub(sub==k) = [];
            %disp('girdu');
             d = [i k];
            % disp(d);
            path_cost = path_cost + minpathcost(k,sub,eta,eta_s,mcost);     
     end  
end        
