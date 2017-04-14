load('order')
%disp(answer);
temp = [];
for i=1:length(answer)
    if answer(i,1) ~= 1
        %disp(answer(i,1));
        temp = [answer(i,:); temp];
    end
end
temp2 = [];
for i=1:length(temp)
    temp2 = [temp(i,:); temp2];
end
disp (temp2)
    