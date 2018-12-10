function [DetPhrase] = corLation(c0_1,cT1,cT2,cT3)
    
        for i = 1:4
            
            cTemp1 = cT1(i,:);
            cTemp2 = cT2(i,:);
            cTemp3 = cT3(i,:);
            
            CoTemp1 = xcorr(c0_1,cTemp1);
            CoTemp2 = xcorr(c0_1,cTemp2);
            CoTemp3 = xcorr(c0_1,cTemp3);
            
            if i == 1
                Z = zeros(1,length(CoTemp1(1,:)));
                VCorZ = [Z;Z;Z;Z;Z;Z;Z;Z;Z;Z;Z;Z];
            end
            
            VCorZ(i,1:length(CoTemp1))=CoTemp1;
            VCorZ(i+4,1:length(CoTemp2))=CoTemp3;
            VCorZ(i+8,1:length(CoTemp3))=CoTemp2;
            
        end
        
        M = max(VCorZ,[],2);
        [~,I] = max(M); 
        
        for k = 1:12
            if k == I
                l = k / 4;
                if l <= 1
                    DetPhrase = 1;
                elseif (1<l) && (l<=2)
                    DetPhrase = 2;
                elseif (2<l) && (l<=3)
                    DetPhrase = 3;
                else 
                    DetPhrase = 0;
                end
            end
        end
end