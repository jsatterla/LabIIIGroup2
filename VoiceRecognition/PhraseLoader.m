function [cT1,cT2,cT3] ...
    = PhraseLoader (Phrase1,Phrase2,Phrase3,fs1,TopFolder,FF,PhraseFolder)
    
    for i = 1:3
        
            if i == 1
                Phrase = Phrase1;
            elseif i == 2
                Phrase = Phrase2;
            elseif i == 3
                Phrase = Phrase3;
            end

            cd(FF)
            [time_PhraseData1,time_PhraseData2,time_PhraseData3,time_PhraseData4]...
                = VoiceReader(Phrase,TopFolder,PhraseFolder);

            c1=melcepst(time_PhraseData1,fs1,'E0dD');
            c2=melcepst(time_PhraseData2,fs1,'E0dD');
            c3=melcepst(time_PhraseData3,fs1,'E0dD');
            c4=melcepst(time_PhraseData4,fs1,'E0dD');

            if i == 1
                c_1 = c1(:,1)';
                c_2 = c2(:,1)';
                c_3 = c3(:,1)';
                c_4 = c4(:,1)';
                cT1 = [c_1; c_2; c_3; c_4];
            elseif i == 2
                c_5 = c1(:,1)';          
                c_6 = c2(:,1)';
                c_7 = c3(:,1)';          
                c_8 = c4(:,1)';
                cT2 = [c_5; c_6; c_7; c_8];
            elseif i == 3
                c_9 = c1(:,1)';      
                c_10 = c2(:,1)';           
                c_11 = c3(:,1)';
                c_12 = c4(:,1)';
                cT3 = [c_9; c_10; c_11; c_12];
            end
    end
    
    cd(FF)
end