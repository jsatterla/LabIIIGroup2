function [TolPer] = DataChecker (d,dmin1,dmax1,dmin2,dmax2,dmin3,dmax3,dmin4,dmax4)

    loopcount = 0;
    acc1 = 0;
    acc2 = 0;
    acc3 = 0;
    acc4 = 0;
    
    
    for i = 1:length(d)
        for j = 1:length(d)

            if dmin1(i,j) <= d(i,j) <= dmax1(i,j)
                acc1 = acc1 + 1;
            elseif dmin2(i,j) <= d(i,j) <= dmax2(i,j)
                acc2 = acc2 + 1;
            elseif dmin3(i,j) <= d(i,j) <= dmax3(i,j)
                acc3 = acc3 + 1; 
            elseif dmin4(i,j) <= d(i,j) <= dmax4(i,j)
                acc4 = acc4 + 1; 
            end

            loopcount = loopcount + 1;
        end
    end

    per1 = acc1 / loopcount;
    per2 = acc2 / loopcount;
    per3 = acc3 / loopcount;
    per4 = acc4 / loopcount;

    disp(per1)
    disp(per2)
    disp(per3)
    disp(per4)
    
    TolPer = (per1 + per2 + per3 + per4) / 4;

end

