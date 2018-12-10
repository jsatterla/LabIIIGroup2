function serialPort(temp)

   % this function was implemented on another computer, but can be easily
   % integrated with these functions, it was done this way due to the way
   % serial comunication works between a windows and mac 
   
   if temp == 1
       disp('"A" sent over serial')
   elseif temp == 2
       disp('"B" sent over serial')
   elseif temp == 3
       disp('"C" sent over serial')
   end

end