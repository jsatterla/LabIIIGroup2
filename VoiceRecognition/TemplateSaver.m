function [] = TemplateSaver(PhraseStr,Dc1_1,Dc1_2,Dc2_1,Dc2_2,Dc3_1,Dc3_2,Dc4_1,Dc4_2,TopFolder)

    
    cd(TopFolder)
    mkdir('Templates')
    cd('Templates')
    mkdir(PhraseStr)
    cd(PhraseStr)
    
    first = char([PhraseStr,'template1_']);
    second = char([PhraseStr,'template2_']);
    saveType='.txt';
    
    
    for i = 1:4
        
        fileNameF = char([first,num2str(i),saveType]);
        fileNameS = char([second,num2str(i),saveType]);
        
        
        if i == 1
            dlmwrite(fileNameF,Dc1_2,'delimiter','\t');
            dlmwrite(fileNameS,Dc1_1,'delimiter','\t');
        elseif i == 2
            dlmwrite(fileNameF,Dc2_1,'delimiter','\t');
            dlmwrite(fileNameS,Dc2_2,'delimiter','\t');
        elseif i == 3
            dlmwrite(fileNameF,Dc3_2,'delimiter','\t');
            dlmwrite(fileNameS,Dc3_1,'delimiter','\t');
        elseif i == 4
            dlmwrite(fileNameF,Dc4_2,'delimiter','\t');
            dlmwrite(fileNameS,Dc4_1,'delimiter','\t');
        end
        
        
    
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    