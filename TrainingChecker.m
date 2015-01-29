function TrainingChecker( Q )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
terminalStateReached = false;
Table = [0 0 0 0 0 0 0 0 0];
actionMatrix = findActionsforStates(Table);
prompt = ' Enter The location where you wish to add a "O":';
while(terminalStateReached == false)
    userPosition = input(prompt);
    Table(userPosition) = 2;
    stateIndex = stateIndexForTable(Table);
    fprintf('%d,',Table);fprintf('\n');
    [~,whoWonIfTerminal,isPresentStateTerminalState] = findRewardForAgentAction(stateIndex);
    % find the most greedy state for that state
    if(isPresentStateTerminalState == false)
    [stateIndex,~] = epsilonGreedyAction(Q(stateIndex,:),actionMatrix(stateIndex,:),0);
    % see if next state is terminal state
    [~,whoWonIfTerminal,isPresentStateTerminalState] = findRewardForAgentAction(stateIndex);
    end
    Table = tableForStateIndex(stateIndex);
    fprintf('%d,',Table);fprintf('\n');
    % Episode Termination
    if(isPresentStateTerminalState == true)
        terminalStateReached = true;
        if(whoWonIfTerminal == 0)
            fprintf('Robot Won\n');
        elseif(whoWonIfTerminal == 1)
            fprintf('You Won\n');
        elseif(whoWonIfTerminal == 2)
            fprintf('Match Draw\n');
        end
    
    end
end

end

