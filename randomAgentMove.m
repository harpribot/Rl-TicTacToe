function stateIndex = randomAgentMove( possibleActions )
% stateIndex -> next state index after the random agent makes a move
% possibleActions -> possible state index of the next state due to the
% actions undertaken for the current state

trueActions = find(possibleActions ~= 0);
chooseAction = randperm(size(trueActions,2));
stateIndex = possibleActions(trueActions(chooseAction(1)));


end

