function [p1,p2,p3]= PhraseStr(TopFolder,PhraseFolder)

     cd(TopFolder )
     cd(PhraseFolder) 
     
     P = readtable('PhraseStrings.txt');
     Pc = table2array(P);
     
     p1 = char(Pc(1,:));
     p2 = char(Pc(2,:));
     p3 = char(Pc(3,:));
     
end