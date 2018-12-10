function [OutLength] = sigLength(sig1,sig2,sig3,sig4)

    length1 = length(sig1);
    length2 = length(sig2);
    length3 = length(sig3);
    length4 = length(sig4);
    
    if (length1 >= length2) && (length1 >= length3) && (length1 >= length4)
        OutLength = length1;
    elseif (length2 >= length1) && (length2 >= length3) && (length2 >= length4)
        OutLength = length2;
    elseif (length3 >= length1) && (length3 >= length2) && (length3 >= length4)
        OutLength = length3;
    else
        OutLength = length4;
    end

end