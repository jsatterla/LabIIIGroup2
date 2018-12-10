function [Min] = TemplateMaker2(signal)
    
    tol = 3;
    
    Min = zeros(length(signal),length(signal));
    Max = zeros(length(signal),length(signal));

    for i = 1:length(signal)
        for j = 1:length(signal)
            Min(i,j) = signal(i,j) - tol;
            Max(i,j) = signal(i,j) + tol;
        end
    end
    
end