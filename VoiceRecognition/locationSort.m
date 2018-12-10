function [dist] = locationSort(pk,loc)

    max_pk = maxk(pk,10);
    max_pks = sort(max_pk,'descend');
    max_loc = zeros(1:length(max_pks));


    for i = 1 : length (max_pks)    
        for j = 1:length(pk)
            if max_pks(i) == pk(j)
                max_loc(i) = loc(j);
            end
        end
    end
    
    dist = zeros(length(max_loc),length(max_loc));
    
    for a = 1:length(max_loc)
        for b = 1:length(max_loc)
            dist(a,b)=max_loc(a)-max_loc(b);
        end
    end
    
    
end