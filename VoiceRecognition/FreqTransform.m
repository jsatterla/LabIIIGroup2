function [y,tc] = FreqTransform(x,fs)
    
    y=rfft(x);
    tc=1/fs;
    

end