function []=setup(fs1,nBits,nChannels,RecordingTime,TopFolder,FF)
    
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

        c1=melcepst(time_PhraseData1,fs1,'E0dD');
        c2=melcepst(time_PhraseData2,fs1,'E0dD');
        c3=melcepst(time_PhraseData3,fs1,'E0dD');
        c4=melcepst(time_PhraseData4,fs1,'E0dD');
        cNoise=melcepst(NoiseData,fs1,'E0dD');

        c1_1 = c1(:,1);
        c1_2 = c1(:,2);
        c2_1 = c2(:,1);
        c2_2 = c2(:,2);
        c3_1 = c3(:,1);
        c3_2 = c3(:,2);
        c4_1 = c4(:,1);
        c4_2 = c4(:,2);
        
        
        cd(FF)
%         clean_c1 = RemoveNoise(c1,cNoise,fs1);
%         clean_c2 = RemoveNoise(c2,cNoise,fs1);
%         clean_c3 = RemoveNoise(c3,cNoise,fs1);
%         clean_c4 = RemoveNoise(c4,cNoise,fs1);

        [pk1_1,loc1_1] = findpeaks(c1_1);
        [pk2_1,loc2_1] = findpeaks(c2_1);
        [pk3_1,loc3_1] = findpeaks(c3_1);
        [pk4_1,loc4_1] = findpeaks(c4_1);
        
        [pk1_2,loc1_2] = findpeaks(c1_2);
        [pk2_2,loc2_2] = findpeaks(c2_2);
        [pk3_2,loc3_2] = findpeaks(c3_2);
        [pk4_2,loc4_2] = findpeaks(c4_2);
        

        d1_1 = locationSort(pk1_1,loc1_1);
        d2_1 = locationSort(pk2_1,loc2_1);
        d3_1 = locationSort(pk3_1,loc3_1);
        d4_1 = locationSort(pk4_1,loc4_1);
        d1_2 = locationSort(pk1_2,loc1_2);
        d2_2 = locationSort(pk2_2,loc2_2);
        d3_2 = locationSort(pk3_2,loc3_2);
        d4_2 = locationSort(pk4_2,loc4_2);
        
        TemplateSaver(Phrase,d1_1,d1_2,d2_1,d2_2,d3_1,d3_2,d4_1,d4_2,TopFolder);
        
    end

end