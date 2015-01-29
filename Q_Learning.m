function Q = Q_Learning 
% To learn the action value function q(s,a) for the tic tac toe agent to
% learn to play the game.
%   X is the robot agent, O is the human player(for simulation 
%   it is another agent that choses action randomly)
%   s - states - Total number of possible states = 3^9 (0 - vacant, 1 - X, 2 - O)
%   a - action - Add a X to one of the empty states to reach another state
%   r - 0.5 for non terminal resultant state
%       1 for terminal state in which the robot wins
%       0 for terminal state in which the robot loses
%       0 for terminal state in which the board is filled and thus is DRAW
%   y - discounting factor = 1 since it is episodic and is bound to
%       terminate at a win/loss/draw state 
%   a - step size in q learning = 0.7 
%   Q(s,a) - a matrix of size 3^9 x 3^9
%   actionsForState - matrix of possible next state index for a given state
%   sIndex = pi(statevalue(i,i) + 1)

%% Initialization
tttTable = [0,0,0,0,0,0,0,0,0]; % tic tac toe table
aCounter = ones(3^(size(tttTable,1)*size(tttTable,2)),9);
y = 0.8;
%epsilonInitial = 0.5; % greediness coefficient
%epsilonFinal = 0.01;
temperatureInitial = 1/2;
temperatureFinal = 1/50;
Q = (zeros(3^(size(tttTable,1)*size(tttTable,2)),9));
actionsForState = findActionsforStates(tttTable);
robotWins = 0;
userWins = 0;
draw = 0;

%% Episode Loop
for episode = 1:100000
    % State Initialization
    stateIndex = stateIndexForTable(tttTable);
    stateIndex = randomAgentMove(actionsForState(stateIndex,:));
    terminalStateReached = false;
    isPresentStateTerminalState = false;
    % epsilon for this iteration
    %epsilon = epsilonInitial + (epsilonFinal - epsilonInitial)*(episode/100000);
    % temperature for this iteration
    temperature = temperatureInitial + ...
        (temperatureFinal - temperatureInitial)*(episode/100000);
    % Q_sum before episode
    Q_sum_initial = sum(sum(Q));
    while (terminalStateReached == false)
        % Choose e-greedy action value policy Q to find the next action
        % stateIndex
        if(isPresentStateTerminalState == false) 
            %[nextStateIndex,positionOfAction] = epsilonGreedyAction(Q(stateIndex,:),actionsForState(stateIndex,:),epsilon);
            [nextStateIndex,positionOfAction] = boltzmannGreedyAction(...
                Q(stateIndex,:),actionsForState(stateIndex,:),temperature);
            % find and update the corresponding step value
            aCounter(stateIndex,positionOfAction) = aCounter(stateIndex,...
                positionOfAction)+ 1;
            a = 1 / aCounter(stateIndex,positionOfAction);
            % true actions for the next state
            trueActions = find(actionsForState(nextStateIndex,:) ~= 0);
            % Take action and find the corresponding reward and next state
            [reward,whoWonIfTerminal,isPresentStateTerminalState] = ...
                findRewardForAgentAction(nextStateIndex);
            % learned sum
            if(isPresentStateTerminalState == false)
                learnedSum = (reward + y * min(Q(nextStateIndex,trueActions)));
            else
                learnedSum = reward;
            end
            % inertia sum
            inertiaSum = Q(stateIndex,positionOfAction);
            Q(stateIndex,positionOfAction) = (1 - a) * inertiaSum ...
                + a * learnedSum ;
            stateIndex = nextStateIndex;
        end
        
        % Episode Termination
        if(isPresentStateTerminalState == true)
            terminalStateReached = true;
            if(whoWonIfTerminal == 0)
                robotWins = robotWins + 1;
            elseif(whoWonIfTerminal == 1)
                userWins = userWins + 1;
            elseif(whoWonIfTerminal == 2)
                draw = draw + 1;
            end
        else
            %[nextStateIndex,positionOfAction] = epsilonGreedyAction(Q(stateIndex,:),actionsForState(stateIndex,:),epsilon);
            [nextStateIndex,positionOfAction] = boltzmannGreedyAction(...
                Q(stateIndex,:),actionsForState(stateIndex,:),temperature);
            % find and update the step size
            aCounter(stateIndex,positionOfAction) = aCounter(stateIndex,...
                positionOfAction)+ 1;
            a = 1 / aCounter(stateIndex,positionOfAction);
            % true actions for the next state
            trueActions = find(actionsForState(nextStateIndex,:) ~= 0);
            % Take action and find the corresponding reward and next state
            [reward,whoWonIfTerminal,isPresentStateTerminalState] = ...
                findRewardForUserAction(nextStateIndex);
            % learned sum
            if(isPresentStateTerminalState == false)
                learnedSum = (reward + y * max(Q(nextStateIndex,trueActions)));
            else
                learnedSum = reward;
            end
            % inertia sum
            inertiaSum = Q(stateIndex,positionOfAction);
            Q(stateIndex,positionOfAction) = (1 - a) * inertiaSum ...
                + a * learnedSum;
            stateIndex = nextStateIndex;
        end
    end
    Q_sum_final = sum(sum(Q));
    fprintf('Difference of Q: %d \n',Q_sum_final - Q_sum_initial);
    fprintf('Episode Count: %d\n\n',episode);
end
fprintf('Robot Wins: %d \nUser Wins: %d \nDraw: %d \n',...
    robotWins,userWins,draw);
end

