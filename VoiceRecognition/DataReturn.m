
function [dist] = DataReturn(phraseData,fs1,TopFolder,FF)

    cd(TopFolder) %selects the main Directory 
    cd(FF)
    
    [phraseData1] = VectorSimp(phraseData);
    
    cd(FF)
    
    [NoiseData] = NoiseReader (TopFolder,FF);
    
    [c1]=melcepst(phraseData1,fs1);
    
    [cNoise]=melcepst(NoiseData,fs1);
    
    cd(FF)
    
    clean_c1 = RemoveNoise(c1,cNoise,fs1);
    
    [pk,loc] = findpeaks(clean_c1);
    
    [dist] = locationSort(pk,loc);
      
end
    

