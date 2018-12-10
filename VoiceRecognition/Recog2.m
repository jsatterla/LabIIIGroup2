
function [DetPhrase] = Recog2(TopFolder,FF,fs1,PhraseFolder)

    cd(TopFolder)
    cd(FF)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    J = 0;
    countTime = 0;
    
    [p1,p2,p3]= PhraseStr(TopFolder,PhraseFolder);
  
    cd(FF)
    
    [cT1,cT2,cT3] = PhraseLoader...
        (p1,p2,p3,fs1,TopFolder,FF,PhraseFolder);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    [Data1,Data2,Data3] = TestLoader...
        (p1,p2,p3,TopFolder,FF,PhraseFolder);
    
    disp('press any key to start voice detection...')
    pause

    while J == 0

%         disp('Start speaking.')
%         recordblocking(recObj, 2);
%         pause(2)
%         disp('End of recording.');
%         x = getaudiodata(recObj);
       
        x = Data1(3,:);

        cd(FF)

        c0=melcepst(x,fs1,'E0dD');
        c0_1 = c0(:,1)';
      
        [DetPhrase] = corLation(c0_1,cT1,cT2,cT3);
        
        countTime = countTime + 1;
        
        if countTime == 30
            disp('No Phrases detected within the last minute')
            prompt = ('Do you wish to continue detection...? [0=Yes/1=No]');
            J = input(prompt);
        end
        
        if DetPhrase ~= 0
            serialPort(DetPhrase);
            J = 1;
        end
    end
    pause()
end