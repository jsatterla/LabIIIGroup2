function [Data1,Data2,Data3] = TestLoader (Phrase1,Phrase2,Phrase3,TopFolder,FF,PhraseFolder)
    
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

            if i == 1
                temp1_Data1 = mean(time_PhraseData1');
                temp1_Data2 = mean(time_PhraseData2');
                temp1_Data3 = mean(time_PhraseData3');
                temp1_Data4 = mean(time_PhraseData4');
                
                Data1 = [temp1_Data1;temp1_Data2; temp1_Data3; temp1_Data4];
             
            elseif i == 2
                temp2_Data1 = mean(time_PhraseData1');
                temp2_Data2 = mean(time_PhraseData2');
                temp2_Data3 = mean(time_PhraseData3');
                temp2_Data4 = mean(time_PhraseData4');
                
                Data2 = [temp2_Data1; temp2_Data2; temp2_Data3; temp2_Data4];
                
            elseif i == 3
                temp3_Data1 = mean(time_PhraseData1');
                temp3_Data2 = mean(time_PhraseData2');
                temp3_Data3 = mean(time_PhraseData3');
                temp3_Data4 = mean(time_PhraseData4');

                Data3 = [temp3_Data1; temp3_Data2; temp3_Data3; temp3_Data4];
                
            end

    end
end