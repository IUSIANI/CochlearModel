function [distanceFocalization]= calcFocalization(w_, distanceBetweenNeurons)
    distanceFocalization = sum(w_>0, 1)*distanceBetweenNeurons
    foc = 1./distanceFocalization
    fprintf("[+] metrics/calcFocalization.m >> Focalization distance.\n")
end
