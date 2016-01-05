%
%
%

basepath = 'C:\Users\UTA\Research\Projects\Retinal Tracking\package\results';

for i = 1:3
    initpos = dlmread(fullfile(['seq' num2str(i)], 'init.txt')); 
    respath = fullfile(basepath, ['exp_test' num2str(i) '.txt']);
    gtpoints = dlmread(respath);
    
    w = initpos(3) - initpos(1);
    h = initpos(4) - initpos(2);
    nframe = size(gtpoints, 1);
    start = 1;
    if i == 3
        nframe = nframe - 10;
        start = 11;
    end
    gt = zeros(nframe, 4);
    gt(:, 1) = gtpoints(start:end, 2)-w/2;
    gt(:, 2) = gtpoints(start:end, 3)-2*h/3;
    gt(:, 3) = round(w);
    gt(:, 4) = round(h);
    
    dlmwrite(fullfile(['seq' num2str(i)], ['seq' num2str(i) '_gt.txt']), gt, 'delimiter', ',');
end

disp('Done');