function [PhraseData1,PhraseData2,PhraseData3,PhraseData4]...
    = VoiceReader(Phrase,TopFolder,PhraseFolder)

     cd(TopFolder )
     cd(PhraseFolder) 
     cd(Phrase)
    
     for i = 1:4              

        SavedPhrase = char([Phrase,'-',num2str(i),'.wav']);         % converts String data in char array so that the files can be called upon based on their specific file name
        
        if i == 1
            [PhraseData1]=readwav(SavedPhrase,'p'); % Reads in the .wav files
        elseif i == 2
            [PhraseData2]=readwav(SavedPhrase,'p');
        elseif i == 3
            [PhraseData3]=readwav(SavedPhrase,'p'); 
        elseif i == 4
            [PhraseData4]=readwav(SavedPhrase,'p');
        end
     end
end  
    
