function [actionIndex,positionOfAction] = boltzmannGreedyAction(Q, actionMatrix,temperature)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% true actions for the given state
trueActions = find(actionMatrix ~= 0);
QforTrueActions = Q(trueActions);
% use boltsmann distribution to find the probability weights of each
% possible action
% all the possible actionIndices for being placed in the randSample
myActions = actionMatrix(trueActions);

% the probability distribution for the possible actions
probDistribution = exp(QforTrueActions/temperature);
probDistribution = probDistribution/sum(probDistribution);
% action Index for this distribution
if(size(myActions,2) > 1)
    actionIndex = randsample(myActions, 1, true, probDistribution);
else
    actionIndex = myActions(1);
end
positionOfAction = find(actionMatrix == actionIndex);


end

