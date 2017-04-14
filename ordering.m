% Script to create the order of presentation
% 1 - 3
% 2 - 2
% 3 - 2
% 4 - 4
% 5 - 2
x = [3 3 3 3 3 3 3 3 2 2 2 2 2 1 1 1 1 1];
answer = [];
one = [1 2]; % Shape
two = [1];
three = [1];
four = [1 2 3 4]; % Cue
five = [1 1 2 2 3 3 3]; % Target
for a = one
    for b = two
        for c = three
            for d = four
                for e = five
                    temp = [a b c d e];
                    answer = [answer; temp];
                end
            end
        end
    end
end
answer


%save('order','answer')

