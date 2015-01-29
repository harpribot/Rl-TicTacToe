function Table = tableForStateIndex( stateIndex )
% Find tic tac toe table for a particular state

Table = [0,0,0,0,0,0,0,0,0];
TablePowers = [3^0,3^1,3^2,3^3,3^4,3^5,3^6,3^7,3^8];
reverseCounter = 9;
stateIndex = stateIndex - 1;
while(reverseCounter >= 1)
    if(stateIndex >= TablePowers(reverseCounter))
        Table(reverseCounter) = floor(stateIndex/TablePowers(reverseCounter));
        stateIndex = mod(stateIndex,TablePowers(reverseCounter));
        reverseCounter = reverseCounter - 1;
    else
        reverseCounter = reverseCounter - 1;
    end
end

end

