% Problem 4
% Monty Hall 7 Door problem
% February 10, 2021
% Group 2: Mark Kim, Amber Hardigan, Adrian Lopez, Nyan Tun, Alyssa Reyes

clear;

numruns=100000;
noswitchwin=0;
switchwin=0;

for i=1:numruns
    money=randperm(7,1);                    % Randomly place treasure in one of 7 doors
    initialpick=randperm(7,3);              % Contestant randomly picks 3 doors
    correctpick=sum(initialpick==money);    % Stores 1 if one of the initial picks contains treasure
    %{
    Note that since the game host opens 3 empty doors, we do not need to
    simulate host's action. Final door will be either a win or lose
    depending solely on contestant's initial picks.
    %}
    if(correctpick==1)                      % Check to see if initial picks contains treasure
        noswitchwin=noswitchwin+1;          % Count wins if contestant does not switch
    else
        switchwin=switchwin+1;              % Count wins if contestant switches
    end
end
prob=[noswitchwin switchwin]/numruns;
fprintf('Probability of winning if contestant does not switch %.4f \n', prob(1))
fprintf('Probability of winning if contestant switches %.4f \n', prob(2))