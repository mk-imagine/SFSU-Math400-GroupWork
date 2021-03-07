%Monty Hall Simulation
%Group 2
%Goal: Probability that no customers wait for change

numofpeople =50;    %50 people in line
five= 0.5;          %probability that customer pays with 5 dollar bill
ten= 0.5;           %probability that customre pays with 10 dollar bill
register =0;        %register has no change
bill = {5,10};

for i=1:numofpeople
    r = randi([1, 2], 1);   % Get a 1 or 2 randomly
    thisCustomer = bill(r); % Dollar bill for current customer
    
    if(bill(r)== 1)
       register = bill(r) + register; %add 5 to register if r is 1
    else
        register = bill(r) + register; %add 10 to register if r is 2
        register = register - 5;  %get 5 dollar change
    end
    
end
