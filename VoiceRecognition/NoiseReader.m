function [NoiseData1] = NoiseReader (TopFolder,FF)
   
    cd (TopFolder)
    cd ('noise')
    
    [NoiseData]=readwav('noise.wav','p');
    
    cd(FF)
    
    [NoiseData1] = VectorSimp(NoiseData);
    
end