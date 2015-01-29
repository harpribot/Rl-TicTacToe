function randAgentChance = whoseChance( Table )
% if randAgentChance == 1, means next chance is of random agent
% if randAgentChance == 0, means next chance is of learning agent
% if randAgentChance == -1,means this state is not reachable

num_zeros = size(find(Table == 2),2);
num_cross = size(find(Table == 1),2);

if(num_cross == num_zeros) % because random agent makes the first move
    randAgentChance = 1;  
elseif(num_zeros - num_cross == 1)
    randAgentChance = 0;
else
    randAgentChance = -1; % because certain states like 2X - 0 O's is not possible
end


end

