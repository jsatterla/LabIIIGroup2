function []=setupNew(fs1,nBits,nChannels,RecordingTime,TopFolder,FF)
    
    cd(FF)
    [Phrase1,Phrase2,Phrase3,PhraseFolder] = VoiceRecorder(fs1,nBits,nChannels,RecordingTime,TopFolder,FF);
    cd(FF)
    [NoiseData] = NoiseRecorder(fs1,nBits,nChannels,RecordingTime,TopFolder,FF);
    
    for i = 1:3


        if i == 1
            Phrase = Phrase1;
        elseif i == 2
            Phrase = Phrase2;
        elseif i == 3
            Phrase = Phrase3;
        end

        cd(FF)
        [time_PhraseData1,time_PhraseData2,time_PhraseData3,time_PhraseData4] = VoiceReader(Phrase,TopFolder,FF,PhraseFolder);

    end

end