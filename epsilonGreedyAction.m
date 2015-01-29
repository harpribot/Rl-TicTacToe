function [actionIndex,positionOfAction] = epsilonGreedyAction( Q, actionMatrix,epsilon )
% Use the epsilon greedy policy to choose action for the given state.
% This is done to ensure sufficient exploration and exploitation

% true actions for the given state
trueActions = find(actionMatrix ~= 0);
numActions = size(trueActions,2);

% Index of the most greedy action
Q_tempMax = -inf;   
for i = 1:numActions
    if(Q_tempMax < Q(trueActions(i)))
        Q_tempMax = Q(trueActions(i));
        bestActionLocation = trueActions(i);
        % reset the tieCounter and tieBrakerIndex
        tieCounter = 1;        % Note that tieCounter = 1 means no tie, = 2 means 2 nums with a tie
        tieBrakerIndex = bestActionLocation * ones(1,1); % indexes of the location of action that have a tie in Q
    elseif(Q_tempMax == Q(trueActions(i)))
        tieCounter = tieCounter + 1;
        tieBrakerIndex(tieCounter) = trueActions(i);
    end
end
% tie braker - crucial for random selection when choosing between more than
% one optima
if(tieCounter > 1)
    bestActionLocation = randsample(tieBrakerIndex, 1, true, (1/tieCounter)*ones(1,tieCounter));
end

% true action index of best action
bestActionIndex = actionMatrix(bestActionLocation);

% all the possible actionIndices for being placed in the randSample
myActions = actionMatrix(trueActions);

% the probability distribution for the possible actions
probDistribution = (epsilon/numActions) * ones(1,numActions);
probDistribution(find(myActions == bestActionIndex)) = 1 - epsilon + (epsilon/numActions);

% action Index for this distribution
if(size(myActions,2) > 1)
    actionIndex = randsample(myActions, 1, true, probDistribution);
else
    actionIndex = myActions(1);
end
positionOfAction = find(actionMatrix == actionIndex);

end

