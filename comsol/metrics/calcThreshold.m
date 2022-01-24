% function [threshold] = calcThreshold(FVr_x, W, currentDensityAtNeurons)
% 
% 	global NRT_real_k_Rec_Elect NRT_real_k_Amplitude
% 	global I_k I_Stimulation
% 
%         
%     It = polyval(polyfit(NRT_real_k_Amplitude(:,NRT_real_k_Rec_Elect==2), -I_k, 1), 0);
%     It = -It./ I_Stimulation;
% 
%     wt = InterpWeight(W, It, 2);
%     
%     [dt, St] = calcDeltas(currentDensityAtNeurons, size(W,1), FVr_x(1), FVr_x(2), FVr_x(3), FVr_x(4), It);
%     [wt_] = calcW_(dt, St, wt);
%     %threshold = max(wt_);
% end

function [threshold, It_] = calcThreshold(currentDensityAtNeurons)

	global NRT_real_k_Rec_Elect NRT_real_k_Amplitude
	global I_k I_Stimulation
    
    figure; hold on;
    for i=1:length(NRT_real_k_Rec_Elect)
        It(i) = polyval(polyfit(NRT_real_k_Amplitude(:,i), -I_k, 1), 0);
        [p,s] = polyfit(NRT_real_k_Amplitude(:,i), -I_k, 1);
        plot(-I_k, NRT_real_k_Amplitude(:,i),'o-b')
        x = 0:1e-6:0.1e-3;
        plot(polyval(p,x), x,'color',[219, 124, 107]./255)
        plot(It(i),0,'or')
    end
    
    hold off
%     It_ = polyval(polyfit(NRT_real_k_Rec_Elect, It , 2), 0)
%     figure; plot(NRT_real_k_Rec_Elect,It,'o-k'); hold on; plot(,It_,'or')
%     It = polyval(polyfit(NRT_real_k_Amplitude(:,NRT_real_k_Rec_Elect==2), -I_k, 1), 0);
    
    It_ = min(It);
    Ck = -It_./ I_Stimulation;
    threshold = max(max(currentDensityAtNeurons*Ck));
    
    figure; plot(NRT_real_k_Rec_Elect,It,'o-k'); hold on;
    fit = polyfit(NRT_real_k_Rec_Elect, It,2);
    x_ = NRT_real_k_Rec_Elect(1):1e-3:NRT_real_k_Rec_Elect(end);
    y_ = polyval(fit,x_);
    plot(x_,y_,'b')
    plot(NRT_real_k_Rec_Elect(find(It == It_)),It_,'xr')
    plot(0,polyval(fit,0),'or')
end