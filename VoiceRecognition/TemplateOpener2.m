function [p1dMin1,p1dMax1,p1dMin2,p1dMax2,p1dMin3,p1dMax3,p1dMin4,p1dMax4,...
          p2dMin1,p2dMax1,p2dMin2,p2dMax2,p2dMin3,p2dMax3,p2dMin4,p2dMax4,...
          p3dMin1,p3dMax1,p3dMin2,p3dMax2,p3dMin3,p3dMax3,p3dMin4,p3dMax4,...
          Phrase1,Phrase2,Phrase3] = TemplateOpener2 (TopFolder)
    
    cd(TopFolder)
    cd('Templates')
    TempFolder = cd();
    
    SavedPhrasesChar = ls;                             % lists all files within directory with extentions

    SavedPhrasesStr = string(SavedPhrasesChar);        % converts char array into string array
    SavedPhrasesStr = erase(SavedPhrasesStr,"Icon?");  % erases random Icon file from the string
    SavedPhrasesStr = split(SavedPhrasesStr);
    
    Phrase1 = char(SavedPhrasesStr(2));                % converts String data in char array so that the files can be called upon based on their specific file name
    Phrase2 = char(SavedPhrasesStr(3));
    Phrase3 = char(SavedPhrasesStr(4));
    
    for i = 1:3
        if i == 1
            temp_phrase = Phrase1;
            c = 1;
        elseif i == 2
            temp_phrase = Phrase2;
            c = 2;
        elseif i == 3
            temp_phrase = Phrase3;
            c = 3;
        end

        cd(temp_phrase)

        for j = 1:4
            
            filenameMax = char([temp_phrase,'MAXtemplate',num2str(j),'.txt']); 
            filenameMin = char([temp_phrase,'MINtemplate',num2str(j),'.txt']);
            
            tempMax = readtable(filenameMax);
            tempMin = readtable(filenameMin);
        
            if j == 1
                dMax1 = tempMax; 
                dMin1 = tempMin;
            elseif j == 2
                dMax2 = tempMax; 
                dMin2 = tempMin;
            elseif j == 3
                dMax3 = tempMax; 
                dMin3 = tempMin;
            elseif j == 4
                dMax4 = tempMax; 
                dMin4 = tempMin;
            end
        
        end

        if c == 1
            p1dMin1 = table2array(dMin1);
            p1dMax1 = table2array(dMax1);
            p1dMin2 = table2array(dMin2);
            p1dMax2 = table2array(dMax2);
            p1dMin3 = table2array(dMin3);
            p1dMax3 = table2array(dMax3);
            p1dMin4 = table2array(dMin4);
            p1dMax4 = table2array(dMax4);
        elseif c == 2 
            p2dMin1 = table2array(dMin1);
            p2dMax1 = table2array(dMax1);
            p2dMin2 = table2array(dMin2);
            p2dMax2 = table2array(dMax2);
            p2dMin3 = table2array(dMin3);
            p2dMax3 = table2array(dMax3);
            p2dMin4 = table2array(dMin4);
            p2dMax4 = table2array(dMax4);
        elseif c == 3
            p3dMin1 = table2array(dMin1);
            p3dMax1 = table2array(dMax1);
            p3dMin2 = table2array(dMin2);
            p3dMax2 = table2array(dMax2);
            p3dMin3 = table2array(dMin3);
            p3dMax3 = table2array(dMax3);
            p3dMin4 = table2array(dMin4);
            p3dMax4 = table2array(dMax4);
        end
    
        cd(TempFolder)
    
    
    end

end