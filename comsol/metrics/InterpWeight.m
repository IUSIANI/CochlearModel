function [wt] = InterpWeight(W, It, grado)
    global C_k
    for i=1:length(W)
       wt(i,:) = polyval(polyfit(C_k, W(i,:), grado), It);
    end
end