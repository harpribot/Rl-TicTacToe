function [reward,whoWon,isTerminal] = findRewardForUserAction( actionIndex )
% Here we determine if the stateIndex is a terminal state or not
% If it is terminal then if we win, reward = +1
%                        if we lose,reward = 0
%                        if we draw,reward = 0
%                        if we are in game, reward = +0.5
% Learning agent uses X, random agent uses O
% Who won
% 0 -> Robot Won
% 1 -> User Won
% 2 -> Draw
% 3 -> Game in Progress
table = tableForStateIndex(actionIndex);
isTerminal = false;
% if the learning agent wins
if((table(1) == 1 && table(5) ==1 && table(9) == 1) || ...
        (table(3) == 1 && table(5) == 1 && table(7) == 1) || ...
            (table(1) == 1 && table(2) == 1 && table(3) == 1) || ...
                (table(4) == 1 && table(5) == 1 && table(6) == 1) || ...
                    (table(7) == 1 && table(8) == 1 && table(9) == 1) || ...
                        (table(1) == 1 && table(4) == 1 && table(7) == 1) || ...
                            (table(2) == 1 && table(5) == 1 && table(8) == 1) || ...
                                (table(3) == 1 && table(6) == 1 && table(9) == 1))
    reward = +2;
    isTerminal = true;
    whoWon = 0;
% if learning agent loses    
elseif((table(1) == 2 && table(5) ==2 && table(9) == 2) || ...
        (table(3) == 2 && table(5) == 2 && table(7) == 2) || ...
            (table(1) == 2 && table(2) == 2 && table(3) == 2) || ...
                (table(4) == 2 && table(5) == 2 && table(6) == 2) || ...
                    (table(7) == 2 && table(8) == 2 && table(9) == 2) || ...
                        (table(1) == 2 && table(4) == 2 && table(7) == 2) || ...
                            (table(2) == 2 && table(5) == 2 && table(8) == 2) || ...
                                (table(3) == 2 && table(6) == 2 && table(9) == 2))
    reward = -2;
    isTerminal = true;
    whoWon = 1;
% if the match is draw i.e no empty places left
elseif(size(find(table == 0),2) == 0)
    reward = -1;
    isTerminal = true;
    whoWon = 2;
% non terminal state
else
    reward = 0;
    whoWon = 3;
end

end

