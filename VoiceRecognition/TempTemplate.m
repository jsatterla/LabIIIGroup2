function [] = TempTemplate(D,count1,TopFolder,TemptemplateFolder)

    
    cd(TemptemplateFolder)
    
    fileName = char([num2str(count1),'.txt']);
    
    dlmwrite(fileName,D,'delimiter','\t')
    
    cd(TopFolder)
    
    
    


end