[v1 v2 v3 v4 v5] = textread('log.txt');


X = (v2+v4)/2;
Y = (v3+v5)/2;

Result = [X Y];

save Result3 Result;