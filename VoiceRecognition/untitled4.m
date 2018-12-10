function [] = 


loopcount = 0;

for i = 1:length(dist)
    for j = 1:length(dist)

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

TolPer = (acc1 + acc2 + acc3 + acc4) / 4;


