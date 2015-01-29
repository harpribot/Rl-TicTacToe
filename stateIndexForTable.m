function stateIndex = stateIndexForTable( tttTable )
% find the state for the given tic tac toe table

stateIndex = tttTable * [3^0;3^1;3^2;3^3;3^4;3^5;3^6;3^7;3^8] + 1;


end

