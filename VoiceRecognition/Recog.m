
function [] = Recog(TopFolder,FF,fs1,nBits,nChannels)

    cd(TopFolder)
    mkdir('TempTemplates')
    cd('TempTemplates')
    TemptemplateFolder = cd();
    cd(FF)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    recObj = audiorecorder(fs1,nBits,nChannels);
    J = 0;
    Tol = .5;
    countTime = 0;
    
    A = 0;
    B = 0;
    C = 0;
    
    [p1dMin1,p1dMax1,p1dMin2,p1dMax2,p1dMin3,p1dMax3,p1dMin4,p1dMax4,...
     p2dMin1,p2dMax1,p2dMin2,p2dMax2,p2dMin3,p2dMax3,p2dMin4,p2dMax4,...
     p3dMin1,p3dMax1,p3dMin2,p3dMax2,p3dMin3,p3dMax3,p3dMin4,p3dMax4,...
     Phrase1,Phrase2,Phrase3] = TemplateOpener (TopFolder);


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % create sequence from 4 seconds of recorded voice
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('press any key to start voice detection...')
    pause

    while J == 0
        disp('Start speaking.')
        recordblocking(recObj, 2);
        pause(2)
        disp('End of recording.');
        x = getaudiodata(recObj);

        cd(FF)

        [dist]=DataReturn(x,fs1,TopFolder,FF);
        
        
        for i = 1:3
            if i == 1
                [TolPer1] = DataChecker (dist,p1dMin1,p1dMax1,p1dMin2,p1dMax2,p1dMin3,p1dMax3,p1dMin4,p1dMax4);
            elseif i == 2
                [TolPer2] = DataChecker (dist,p2dMin1,p2dMax1,p2dMin2,p2dMax2,p2dMin3,p2dMax3,p2dMin4,p2dMax4);
            elseif i == 3
                [TolPer3] = DataChecker (dist,p3dMin1,p3dMax1,p3dMin2,p3dMax2,p3dMin3,p3dMax3,p3dMin4,p3dMax4);
            end
        end
        
        disp(TolPer1)
        disp(TolPer2)
        disp(TolPer3)
        
        TempTemplate(dist,countTime,TopFolder,TemptemplateFolder);

        if TolPer1 >= Tol
            A = 1;
            detPhrase = Phrase1;
        elseif TolPer2 >= Tol
            B = 1;
            detPhrase = Phrase2;
        elseif TolPer3 >= Tol
            C = 1;
            detPhrase = Phrase3;
        end
        
        if A == 1 || B == 1 || C ==1
            disp('Detected Phrase: ',detPhrase)

            serialPort(A,B,C)

            prompt = ('Do you wish to continue detection...? [0=Yes/1=No]');
            J = input(prompt);
        end
         
        countTime = countTime + 1;
        
        if countTime == 30
            disp('No Phrases detected within the last minute')
            prompt = ('Do you wish to continue detection...? [0=Yes/1=No]');
            J = input(prompt);
        end
    end
    
end