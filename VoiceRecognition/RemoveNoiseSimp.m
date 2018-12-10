function [CleanedData] = RemoveNoiseSimp(PhraseData,NoiseData)
temp_High = 0;
CleanedData = PhraseData;
    
    for i = 1:length(NoiseData)
        
        if temp_High < NoiseData(i)
            temp_High = NoiseData(i);
        end
        
        for j = 1:length(PhraseData)
            
            if temp_High > PhraseData(j)
                CleanedData(j) = 0;
            end
            
        end
    end

end