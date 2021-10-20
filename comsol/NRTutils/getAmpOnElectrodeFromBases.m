function ampOnElectrode=getAmpOnElectrodeFromBases(currentElectrode, V)
    centerElectrode = 6;
    [numNeurons, ~] = size(V{1});
    ampOnElectrode = zeros((numNeurons*2)-1,1);
    n=1;
    
    for i=-(numNeurons):-2
        potentialOnElectrode = V{centerElectrode+(-currentElectrode)};
        ampV = max(potentialOnElectrode,[],2)-min(potentialOnElectrode,[],2);
        ampOnElectrode(n) = ampV(-i);
        n=n+1;
    end
    for i=1:numNeurons
        potentialOnElectrode = V{centerElectrode+(currentElectrode)};
        ampV = max(potentialOnElectrode,[],2)-min(potentialOnElectrode,[],2);
        ampOnElectrode(n) = ampV(i);
        n=n+1;
    end
end