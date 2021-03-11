% Monte Carlo Simulation
% Project 1, Section 1.2
% Alyssa Reyes (primary coder), Mark Kim, Amber Hartigan, Nyan Tun, 
% and Adrian Lopez

% Initialize Global Variables
numsims = 100000;               % number of simulations
numppl = 50;                    % number of people in queue
num_wait = zeros(1,numsims);    % vector to store number of people who have to wait
zero_wait = 0;                  % number of times there was zero wait

% Simulate Queue at Box Office
for i=1:numsims
    % Initialize Variables for each Simulation
    wait = 0;       % number of people who had to wait
    need_change = 0;% number of people needing change
    fives = 0;      % number of fives in register
    for j=1:numppl
        prob = rand;
        % if person does not need change (has a five)
        if prob <= 0.5
            if need_change == 0     % if no one needs change
                fives = fives + 1;  % add to fives bucket
            else                    % else if someone needs change
                need_change = need_change - 1;% reduce number of people that need change (no fives go in bucket)
            end
        % else if person needs change (has a ten)
        else
            if fives == 0           % if fives bucket empty
                wait = wait + 1;    % person has to wait
                need_change = need_change + 1;% and add to number of people waiting for change
            else                    % else if change is available
                fives = fives - 1;  % give change (no wait)
            end
        end
    end
    num_wait(i) = wait;             % store number of people who had to wait
    if wait == 0
        zero_wait = zero_wait + 1;  % add to number of occurences of zero wait
    end
end

prob_zero_wait = zero_wait/numsims  % probability of zero wait time