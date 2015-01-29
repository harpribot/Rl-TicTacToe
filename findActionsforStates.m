function actionMatrix = findActionsforStates(tttTable)
%It is a matrix of order 3^9 x 9 as for each state there are atmost 9
%actions possible. i.e 1 each for each empty state(depending one whether the
%next action for that state is x or 0) with maximum of 9 empty states

% for each stateIndex in the actionMatrix we store the row of possible
% actionIndex. If the actionIndex = 0 means that that state is unattainable
actionMatrix = (zeros(3^(size(tttTable,1)*size(tttTable,2)),9));

for stateIndex = 1:3^(size(tttTable,1)*size(tttTable,2))
    Table = tableForStateIndex(stateIndex);
    randAgentChance = whoseChance(Table);  % randAgentChance = 1 means random agent's chance
                                           % randAgentChance = 0 means learning
                                           % agent's chance
    emptyStates = find(Table == 0);
    for i = 1:size(emptyStates,2)
        temp_table = Table;
        if(randAgentChance == 0)
            temp_table(emptyStates(i)) = 1;
            actionMatrix(stateIndex,emptyStates(i)) = stateIndexForTable(temp_table);
        elseif(randAgentChance == 1)
            temp_table(emptyStates(i)) = 2;
            actionMatrix(stateIndex,emptyStates(i)) = stateIndexForTable(temp_table);
        end
    end
end

end

