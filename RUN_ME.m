% Fernando Ponce 73237738
% Experiment Part 2
clear all;
par = input('Input participant number: ');
c = input('Input condition[1/2]: ');
%d = input('Debug?: ');
%p = 2;
%c = 2;
d = 0;
%-------------------------------------
% Condition 1: Token 1: Positive, Token 2: Negative, Token 3: Independent
% Condition 2: Token 1: Independent, Token 2: Positive, Token 3: Negative
% Condition 3: Token 1: Negative, Token 2: Independent, Token 3: Positive
% New Conditions use only neg/pos and independent
% Condition 1: Token 1: Positive, Token 3: Independent
% Condition 2: Token 2: Positive, Token 1: Independent
% Condition 3: Token 3: Positive, Token 2: Independent
% New New Conditions using only two tokens
% Condition 1: Token 1: Positive, Token 2: Independent
% Condition 2: Token 1: Independent, Token 2: Positive
%-------------------------------------
% Set the number of trials wanted for phase 2:
num_trials = 6;
nToken = num_trials;
debugkey = 0;
if d==1
    num_trials = 1;
    debugkey =1;
end

% Cogent Settings ---------------------------------
warning('off','MATLAB:dispatcher:InexactMatch')
config_display(1, 4,[1 1 1], [0 0 0], 'Arial', 32, 8);
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
    token_ordering = [first_token second_token];
elseif c == 2
    token_ordering = [second_token first_token];
end

ordering = randperm(nToken);
token = [];
iti = [1000 1000 1000 1000 1000 1000 1000 1000 1000];
for i = randperm(nToken)
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
if d ~= 2
while accuracy < .9 || blocks_completed < 3 || w < 3
    accuracy = 0;
    x = 1;
    ordering = randperm(nToken);
    correct = 0;
    token = [];
    ran_iti = [];
    for i = randperm(nToken)
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
    % --------- Present Only Shape and Enzyme ----------------

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

    cgflip(1,1,1);
    wait(1000);

    % Present square over participant answer


    % Assignment of value
    if c == 1 % 200 is independent
        if token(x) == (200 + indep) || token(x) == 103 || token(x) == 203
            act = 1; % 1 means it will be activated
        else
            act = 0; % 0 means it will not be activated
        end
    elseif c == 2 % 100 is independent
        if token(x) == (100 + indep) || token(x) == 203 || token(x) == 103
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

if accuracy >= .9
    w = w + 1;
else
    w = 0;
end

if debugkey == 1
    accuracy = 1;
    w = 30000000;
end

part_1_shape = [part_1_shape shape_];
part_1_correct = [part_1_correct correct_];
part_1_answer = [part_1_answer answer_];
part_1_activation = [part_1_activation activation_];
part_1_RT = [part_1_RT rt_];
part_1_accuracy = [part_1_accuracy accuracy];


end
end


cgtrncol(1002,'w');
cgdrawsprite(1002,0,0);
cgflip(1,1,1);
waitkeydown(inf,[71]);

cgtrncol(1003,'w');
cgdrawsprite(1003,0,0);
cgflip(1,1,1);
waitkeydown(inf,[71]);

cgtrncol(1004,'w');
cgdrawsprite(1004,0,0);
cgflip(1,1,1);
waitkeydown(inf,[71]);
% Set the number of trials wanted for phase 2:
num_trials2 = 56;

% General Settings ---------------------------------
filename = 'settings.mat';
load(filename); % Load image settings
% Load Participant Information
% Load Ordering Data
load('order');
% ----------- Create ordering based on the condition -------------
if c == 1
    ex = 3;
elseif c == 2
    ex = 3;
else
    ex = 1;
end
temp_answer = [];
for p=1:length(answer)
    if answer(p,1) ~= ex
        temp_answer = [answer(p,:); temp_answer];
    end
end
answer = temp_answer;
temp_answer3 = answer;
temp_answer = [];

for p=1:length(answer)
    temp_answer = [answer(p,:) ; temp_answer];
end

temp_answer4 = temp_answer;
answer = temp_answer;

% Participant data that will be written ---------
shape_data = zeros(num_trials2,5);
rt_data = zeros(num_trials2,5);
cue_data = zeros(num_trials2,5);
target_data = zeros(num_trials2,5);
isi_data = zeros(num_trials2,5);
attempt_data = zeros(num_trials2,5);
same_data = zeros(num_trials2,5); % records if the cue and target are on the same spot
targets_data = zeros(num_trials2,5);

response_times = [];
attempts_to_correct = [];
cue_location = [];
target_location = [];
isi_info = [];
key_pressed = zeros(num_trials2,6);
spacing_data = zeros(num_trials2,1); % records spacing1,spacing2
size_data = zeros(num_trials2,2); % records scalex,scaley

% Create the random ordering of conditions
ordering = randperm(num_trials2);
original_answer = answer;
temp = [];
for i = ordering
    temp = [answer(i,:);temp];
end
answer = temp;
% Create the array of target locations that will be randomized
% after every block (3 = valid, 2 = different, 1 = same)
target_locations = [3 3 3 3 3 3 3 3 3 3 2 2 2 1 1 1]; % I don't think this is used!
% -----------------------------------------
% Settings
% Random data
v = [1 4];
% ITI time
iti = [1000 1000 1000];
ran_iti = randi([1 3],num_trials2,1);
% ISI time
isi = [200]; % Previously 300, changed to 200 because it was sig
% in paper we are basing this off of
ran_isi = randi([1],num_trials2,1);
% Tried to get correct answer
tries = 0;
tries_a = zeros(num_trials2,1);
% Reaction times
rt = zeros(num_trials2,1);
% IV
counter2 = 1;
% Type of shape
type = [100 200];

% ----- Instructions Display --------------
cgsetsprite(0);
cgflip(1,1,1);

ordering = randperm(num_trials2);
temp = [];
for i = ordering
    temp = [answer(i,:);temp];
end
answer = temp;

block = 1;
while block <= 5
    ordering = randperm(num_trials2);
    temp = [];
    for i = ordering
        temp = [temp;answer(i,:)];
    end
    answer = temp;


k = 1;
for x=1:num_trials2
    disp(x);
    load('settings.mat')

    cgsetsprite(0);

    cgtrncol(444);

    cgdrawsprite(444,0,0)
    cgflip(1,1,1)
    wait(iti(ran_iti(x)))

    % Data recording (Shape, Cue, Target, ISI)
    shape_data(x,block) = type(answer(x,1))+3; %Shape
    cue_data(x,block) = answer(x,4); %Cue
    target_data(x,block) = answer(x,5); % Target
    isi_data(x,block) = 200;

    % Object fixation
    cgtrncol((type(answer(x,1)) + 1),'w');
    cgdrawsprite((type(answer(x,1)) + 1),spacing1,0,scalex,scaley);
    cgtrncol((type(answer(x,1)) + 2),'w');
    cgdrawsprite((type(answer(x,1)) + 2),spacing2,0,scalex,scaley);

    cgtrncol(812,'w');
    cgdrawsprite(812,2.5,0,scalebar,800);
    cgflip(1,1,1);
    wait(1000);

    % Cue activation -----------
    cgtrncol((type(answer(x,1)) + 1),'w');
    cgdrawsprite((type(answer(x,1)) + 1),spacing1,0,scalex,scaley);
    cgtrncol((type(answer(x,1)) + 2),'w');
    cgdrawsprite((type(answer(x,1)) + 2),spacing2,0,scalex,scaley);

    cgtrncol(303,'b');

    % Cue placement
    if answer(x,4) == 2 % Upper Right
        cgdrawsprite(303,scaletx,scalety,5,5);
    elseif answer(x,4) == 3 % Lower Left
        cgdrawsprite(303,scaletxn,scaletyn,5,5);
    elseif answer(x,4) == 4 % Lower Right
        cgdrawsprite(303,scaletx,scaletyn,5,5);
    else  % Upper Left
        cgdrawsprite(303,scaletxn,scalety,5,5);
    end

    cgtrncol(812,'w');
    cgdrawsprite(812,2.5,0,scalebar,800);

    cgflip(1,1,1);
    wait(60);

    % ISI -----------------------------
    cgtrncol((type(answer(x,1)) + 1),'w');
    cgdrawsprite((type(answer(x,1)) + 1),spacing1,0,scalex,scaley);
    cgtrncol((type(answer(x,1)) + 2),'w');
    cgdrawsprite((type(answer(x,1)) + 2),spacing2,0,scalex,scaley);

    cgtrncol(812,'w');
    cgdrawsprite(812,2.5,0,scalebar,800);

    cgflip(1,1,1);
    wait(200);
    % -------------------------------

    % Target Presentation -----------
    cgtrncol((type(answer(x,1)) + 1),'w');
    cgdrawsprite((type(answer(x,1)) + 1),spacing1,0,scalex,scaley);
    cgtrncol((type(answer(x,1)) + 2),'w');
    cgdrawsprite((type(answer(x,1)) + 2),spacing2,0,scalex,scaley);
    if answer(x,5) == 1 % Same side as target
        if answer(x,4) == 1 %|| answer(x,4) == 3
            tar = [3]; % Used to be tar = [1 3];
        elseif answer(x,4) == 2 %|| answer(x,4) == 4
            tar = [4]; % Used to be tar = [2 4];
        elseif answer(x,4) == 3
            tar = [1];
        else
            tar = [2];
        end
    elseif answer(x,5) == 2 % Opposite side of target
        if answer(x,4) == 1
            tar = [2];
        elseif answer(x,4) == 2
            tar = [1];
        elseif answer(x,4) == 3
            tar = [4];
        else
            tar = [3];
        end
    else % Target is on the same location as cue
        tar = [answer(x,4)];
    end
    %choose_target_randomly = randi([1 2],1,1);
    %targ = tar(choose_target_randomly);
    targ = tar(1);
    % Target and Distractors
    if targ == 2 % Upper Right
        cgtrncol(1,'w');
        cgdrawsprite(1,scaletx,scalety,sizex,sizey);
        cgtrncol(2,'w');
        cgdrawsprite(2,scaletxn,scalety,sizex,sizey);
        cgtrncol(3,'w');
        cgdrawsprite(3,scaletx,scaletyn,sizex,sizey);
        cgtrncol(4,'w');
        cgdrawsprite(4,scaletxn,scaletyn,sizex,sizey);
    elseif targ == 3 % Lower Left
        cgtrncol(1,'w');
        cgdrawsprite(1,scaletxn,scaletyn,sizex,sizey);
        cgtrncol(2,'w');
        cgdrawsprite(2,scaletxn,scalety,sizex,sizey);
        cgtrncol(3,'w');
        cgdrawsprite(3,scaletx,scaletyn,sizex,sizey);
        cgtrncol(4,'w');
        cgdrawsprite(4,scaletx,scalety,sizex,sizey);
    elseif targ == 4 % Lower Right
        cgtrncol(1,'w');
        cgdrawsprite(1,scaletx,scaletyn,sizex,sizey);
        cgtrncol(2,'w');
        cgdrawsprite(2,scaletxn,scalety,sizex,sizey);
        cgtrncol(3,'w');
        cgdrawsprite(3,scaletxn,scaletyn,sizex,sizey);
        cgtrncol(4,'w');
        cgdrawsprite(4,scaletx,scalety,sizex,sizey);
    else % Upper Left
        cgtrncol(1,'w');
        cgdrawsprite(1,scaletxn,scalety,sizex,sizey);
        cgtrncol(2,'w');
        cgdrawsprite(2,scaletx,scaletyn,sizex,sizey);
        cgtrncol(3,'w');
        cgdrawsprite(3,scaletxn,scaletyn,sizex,sizey);
        cgtrncol(4,'w');
        cgdrawsprite(4,scaletx,scalety,sizex,sizey);
    end

    % Records if target and cue are on the same spot
    temp_same = 0;
    if targ == answer(x,4)
        temp_same = 1;
    end



    cgtrncol(812,'w');
    cgdrawsprite(812,2.5,0,scalebar,800);

    cgflip(1,1,1);
    tic;
    wait_for_correct = 0;
    while wait_for_correct == 0
        waitkeydown(60000, [82 83 79 80 52 71]);
        if ans(1) == 52
            stop_cogent;
            return
        elseif targ == 1 && ans(1) == 82
            wait_for_correct = 1;
            tries = tries + 1;
            key_pressed(k,tries) = 7;
        elseif targ == 2 && ans(1) == 83
            wait_for_correct = 1;
            tries = tries + 1;
            key_pressed(k,tries) = 8;
        elseif targ == 3 && ans(1) == 79
            wait_for_correct = 1;
            tries = tries + 1;
            key_pressed(k,tries) = 4;
        elseif targ == 4 && ans(1) == 80
            wait_for_correct = 1;
            tries = tries + 1;
            key_pressed(k,tries) = 5;
        else
            tries = tries + 1;
            if ans(1) == 83
                key_pressed(k,tries) = 8;
            elseif ans(1) == 82
                key_pressed(k,tries) = 7;
            elseif ans(1) == 80
                key_pressed(k,tries) = 5;
            elseif ans(1) == 79
                key_pressed(k,tries) = 4;
            else
                key_pressed(k,tries) = ans(1);
            end
        end
    end
    rt(x) = toc;
    rt_data(x,block) = toc; % Response Time Recording
    attempt_data(x,block) = tries; % Number of Attempts Recording
    same_data(x,block) = 1;
    targets_data(x,block) = answer(x,5);

    tries_a(x) = tries;
    tries = 0;
    k = k + 1;
    spacing_data(x) = spacing1;
    size_data(x,1) = scalex;
    size_data(x,2) = scaley;
end

block = block + 1;
end
% Passes data onto participant variables -------
response_times = [response_times;rt];
attempts_to_correct = [attempts_to_correct;tries_a];
cue_location = [cue_location];
target_location = [target_location];
t = ran_isi * 100;
isi_info = [isi_info;t];

save(int2str(par),'c','part_1_shape','part_1_correct','part_1_answer','part_1_activation','part_1_RT','part_1_accuracy','key_pressed','shape_data','rt_data','cue_data','target_data','isi_data','attempt_data','indep','targets_data');
stop_cogent;
