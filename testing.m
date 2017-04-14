

targets = [3 3 3 3 3 3 3 3 3 3 3 3 3 3 2 2 2 2 2 1 1 1 1 1];
target_ordering = randperm(24);

temp2 = [];
for i = target_ordering
    temp2 = [temp2;targets(i)];
end
targets = temp2;
targets