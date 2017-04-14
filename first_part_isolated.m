% Fernando Ponce 73237738
% Experiment Part 2
clear all;
%p = input('Input participant number: ');
%c = input('Input condition[1/2/3]: ');
%d = input('Debug?: ');
p = 2;
c = 2;
d = 0;
%-------------------------------------
% Condition 1: Token 1: Positive, Token 2: Negative, Token 3: Independent
% Condition 2: Token 1: Independent, Token 2: Positive, Token 3: Negative
% Condition 3: Token 1: Negative, Token 2: Independent, Token 3: Positive
% New Conditions use only neg/pos and independent
% Condition 1: Token 1: Positive, Token 3: Independent
% Condition 2: Token 2: Positive, Token 1: Independent
% Condition 3: Token 3: Positive, Token 2: Independent
%-------------------------------------
% Set the number of trials wanted for phase 2:
num_trials = 6;
debugkey = 0;
if d==1
    num_trials = 1;
    debugkey =1;
end

% Cogent Settings ---------------------------------
warning('off','MATLAB:dispatcher:InexactMatch')
config_display(0, 4,[1 1 1], [0 0 0], 'Arial', 32, 8);
config_keyboard(10, 5, 'nonexclusive');
start_cogent;
%HideCursor;
cgpencol(0, 0, 0);
makesprites; % LOAD THE SCRIPT WITH ALL THE IMAGE SPRITES
cgfont('Arial', 35);
map = getkeymap; % Shows the keybindings
% --------------------------------------------------
% General Settings ---------------------------------
filename = 'settings.mat';
load(filename); % Load image settings
% Random Settings
first_token = [101 102 103];
second_token = [201 202 203];
third_token = [301 302 303];
if c == 1
    token_ordering = [first_token third_token];
elseif c == 2
    token_ordering = [first_token second_token];
else
    token_ordering = [second_token third_token];
end

ordering = randperm(6);
token = [];
iti = [1000 1000 1000 1000 1000 1000 1000 1000 1000];
for i = randperm(6)
    token = [token;token_ordering(i)];
end

blocks_completed = 0;

% Randomizing the independent var in part 1
indep = randi([1 2],1,1);

% Recording Variables ------------------------
part_1_shape = [];
part_1_correct = [];
part_1_answer = [];
part_1_activation = [];
part_1_RT = [];
part_1_accuracy = [];
% Main Loop ----------------------------------
cgsetsprite(0);
cgflip(1,1,1);

% Insturctions -------------------------------
cgtrncol(1001,'w');
cgdrawsprite(1001,0,0);
cgflip(1,1,1);
waitkeydown(inf,[71]); % space bar

cgsetsprite(0);
cgflip(1,1,1);

x = 1;
select = 0;
act = 0;
w = 0; % number of times they have achieved 90% accuracy
accuracy = 0;
while accuracy < .9 || blocks_completed < 3 || w < 3
    accuracy = 0;
    x = 1;
    ordering = randperm(6);
    correct = 0;
    token = [];
    ran_iti = [];
    for i = randperm(6)
        token = [token;token_ordering(i)];
    end
    for i = ordering
        ran_iti = [ran_iti;iti(i)];
    end

    % Reset Data Collection/New Block
    shape_ = zeros(9,1);
    correct_ = zeros(9,1);
    answer_ = zeros(9,1);
    activation_ = zeros(9,1);
    rt_ = zeros(9,1);

for x=1:num_trials
    disp(x);
    shape_(x,1) = token(x);
    if token(x) == 103 || token(x) == 203 || token(x) == 303
       cgtrncol((token(x) - 2),'w');
       cgdrawsprite((token(x) - 2),spacing1,0,scalex,scaley);
       cgtrncol((token(x) - 1),'w');
       cgdrawsprite((token(x) - 1),spacing2,0,scalex,scaley);
       cgtrncol((token(x) + 1),'w');
       cgdrawsprite((token(x) + 1),0,-220,200,220); % Sign
       if token(x) == 103
           sign = 'alpha';
       elseif token(x) == 203
           sign = 'beta';
       elseif token(x) == 303
           sign = 'gamma';
       end
    elseif token(x) == 101 || token(x) == 201 || token(x) == 301
       cgtrncol(token(x),'w');
       cgdrawsprite(token(x),spacing1,0,scalex,scaley);
       cgtrncol((token(x) + 3),'w');
       cgdrawsprite((token(x) + 3),0,-220,200,220); % Sign
       if token(x) == 101
           sign = 'alpha';
       elseif token(x) == 201
           sign = 'beta';
       elseif token(x) == 301
           sign = 'gamma';
       end
    else
       cgtrncol(token(x),'w');
       cgdrawsprite(token(x),spacing2,0,scalex,scaley);
       cgtrncol((token(x) + 2),'w');
       cgdrawsprite((token(x) + 2),0,-220,200,220); % Sign
       if token(x) == 102
           sign = 'alpha';
       elseif token(x) == 202
           sign = 'beta';
       elseif token(x) == 302
           sign = 'gamma';
       end
    end
    info = ['Will the ' sign ' receptor be activated given this enzyme treatment?'];
    cgtext(info,0,150);

    cgtext('Yes',-210,-275);
    cgtext('No',210,-275);

    tic;
    cgflip(1,1,1);
    answer = 0;
    waitkeydown(inf,[97,98,52]); % Weird error, look into it!!!!
    if ans == 59
        answer = 1;
    elseif ans == 97
        select = 1;
        answer = 1;
    elseif ans == 98
        select = 0;
        answer = 1;
    elseif ans == 52
        stop_cogent;
    end
    
    rt_(x,1) = toc; % Collect response time data
    answer_(x,1) = select; % Collect answer data
    
    % ----------- Prenting the participant's answer
    if token(x) == 103 || token(x) == 203 || token(x) == 303
       cgtrncol((token(x) - 2),'w');
       cgdrawsprite((token(x) - 2),spacing1,0,scalex,scaley);
       cgtrncol((token(x) - 1),'w');
       cgdrawsprite((token(x) - 1),spacing2,0,scalex,scaley);
       cgtrncol((token(x) + 1),'w');
       cgdrawsprite((token(x) + 1),0,-220,200,220); % Sign
       if token(x) == 103
           sign = 'alpha';
       elseif token(x) == 203
           sign = 'beta';
       elseif token(x) == 303
           sign = 'gamma';
       end
    elseif token(x) == 101 || token(x) == 201 || token(x) == 301
       cgtrncol(token(x),'w');
       cgdrawsprite(token(x),spacing1,0,scalex,scaley);
       cgtrncol((token(x) + 3),'w');
       cgdrawsprite((token(x) + 3),0,-220,200,220); % Sign
       if token(x) == 101
           sign = 'alpha';
       elseif token(x) == 201
           sign = 'beta';
       elseif token(x) == 301
           sign = 'gamma';
       end
    else
       cgtrncol(token(x),'w');
       cgdrawsprite(token(x),spacing2,0,scalex,scaley);
       cgtrncol((token(x) + 2),'w');
       cgdrawsprite((token(x) + 2),0,-220,200,220); % Sign
       if token(x) == 102
           sign = 'alpha';
       elseif token(x) == 202
           sign = 'beta';
       elseif token(x) == 302
           sign = 'gamma';
       end
    end
    
    info = ['Will the ' sign ' receptor be activated given this enzyme treatment?'];
    cgtext(info,0,150);

    cgtext('Yes',-210,-275);
    cgtext('No',210,-275);
    
    if select == 1
       cgtrncol(999,'w');
       cgdrawsprite(999,-200,-255);
    else
       cgtrncol(999,'w');
       cgdrawsprite(999,220,-255);
    end
    
    cgflip(1,1,1);
    wait(1000);
    
    
    % Present square over participant answer
    

    % Assignment of value
    if c == 1 % 300 is independent 
        if token(x) == (300 + indep) || token(x) == 103 || token(x) == 303
            act = 1; % 1 means it will be activated
        else
            act = 0; % 0 means it will not be activated
        end
    elseif c == 2 % 100 is independent
        if token(x) == 203 || token(x) == (100 + indep) || token(x) == 103
            act = 1; % 1 means it will be activated
        else
            act = 0; % 0 means it will not be activated
        end
    elseif c == 3 % 200 is independent
        if token(x) == 303 || token(x) == (200 + indep) || token(x) == 203
            act = 1; % 1 means it will be activated
        else
            act = 0; % 0 means it will not be activated
        end
    end

    activation_(x,1) = act; % Collect activation data

    % -------------------------------

    if answer == 1
        if token(x) == 103 || token(x) == 203 || token(x) == 303
           cgtrncol((token(x) - 2),'w');
           cgdrawsprite((token(x) - 2),spacing1,0,scalex,scaley);
           cgtrncol((token(x) - 1),'w');
           cgdrawsprite((token(x) - 1),spacing2,0,scalex,scaley);
           if act == 1; %Activation
               %cgtrncol(777,'w');
               %cgdrawsprite(777,0,-220,200,220)

               cgtrncol((token(x)+1),'w');
               cgdrawsprite((token(x)+1),0,-220,200,220); % Sign
           else
               cgtrncol((token(x) + 1),'w');
               cgdrawsprite((token(x) + 1),0,-220,200,220); % Sign

               %cgtrncol(778,'w');
               %cgdrawsprite(778,0,-220,100,120)
           end

        elseif token(x) == 101 || token(x) == 201 || token(x) == 301
           cgtrncol(token(x),'w');
           cgdrawsprite(token(x),spacing1,0,scalex,scaley);
           if act == 1;
               %cgtrncol(777,'w');
               %cgdrawsprite(777,0,-220,200,220)

               cgtrncol((token(x) + 3),'w');
               cgdrawsprite((token(x) + 3),0,-220,200,220); % Sign
           else
               cgtrncol((token(x)+3),'w');
               cgdrawsprite((token(x)+3),0,-220,200,220); % Sign

               %cgtrncol(778,'w');
               %cgdrawsprite(778,0,-220,100,120)
           end

        else
           cgtrncol(token(x),'w');
           cgdrawsprite(token(x),spacing2,0,scalex,scaley);
           if act == 1;
               %cgtrncol(777,'w');
               %cgdrawsprite(777,0,-220,200,220)

               cgtrncol((token(x) + 2),'w');
               cgdrawsprite((token(x) + 2),0,-220,200,200); % Sign
           else
               cgtrncol((token(x) + 2),'w');
               cgdrawsprite((token(x) + 2),0,-220,200,200); % Sign

               %cgtrncol(778,'w');
               %cgdrawsprite(778,0,-220,100,120)
           end

        end

        if select == act && select == 1
            info = 'You are right, it was!';
            correct = correct + 1;
            correct_(x,1) = 1; % Collect Correct Data
        elseif select == act && select == 0
            info = 'You are right, it was not!';
            correct = correct + 1;
            correct_(x,1) = 1; % Collect Correct Data
        elseif select ~= act && act == 0
            info = 'You are wrong, it was not!';
        elseif select ~= act && act == 1
            info = 'You are wrong, it was!';
        end

        cgtext(info,0,150);

        cgtext('Yes',-210,-275);
        cgtext('No',210,-275);

        if act == 1
           cgtrncol(1000,'w');
           cgdrawsprite(1000,-200,-255);
        else
           cgtrncol(1000,'w');
           cgdrawsprite(1000,220,-255);
        end

        cgflip(1,1,1);
        wait(1500);

        cgdrawsprite(444,0,0) % Fixation Cross
        cgflip(1,1,1)
        wait(ran_iti(x));
    end

end
accuracy = correct / num_trials;
blocks_completed = blocks_completed + 1;

if accuracy >= 90
    w = w + 1;
else
    w = 0;
end

if debugkey == 1
    accuracy = 1;
end

part_1_shape = [part_1_shape shape_];
part_1_correct = [part_1_correct correct_];
part_1_answer = [part_1_answer answer_];
part_1_activation = [part_1_activation activation_];
part_1_RT = [part_1_RT rt_];
part_1_accuracy = [part_1_accuracy accuracy];


end
