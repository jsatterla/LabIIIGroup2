function [CleanSig,ts] = RemoveFree(sig,tsInput)
    

    for i = 1:length(sig)
        if sig(i) ~= 0
            CleanSig(i) = sig(i);
            ts(i) = tsInput(i);
        end
        
            
    end

end