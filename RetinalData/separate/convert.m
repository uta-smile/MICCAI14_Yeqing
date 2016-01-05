
st = [224 1319 1551 1575 1575 1194];
ed = [625 1540 2097 2174 2174 2174];

dbid = 1;


for thres = 0.5:0.05:0.65

srcsuffix = '_tld_fast_dt.txt';
dstsuffix = '_tld_test_fast_dt.txt';

srcsuffix = sprintf('_tld_fast_dt_conf%.2f.txt', thres);
dstsuffix = sprintf('_tld_test_fast_dt_conf%.2f.txt', thres);

% srcsuffix = '_tld_origin.txt';
% dstsuffix = '_tld_test_origin.txt';

for i = dbid
    ret = dlmread(['seq' num2str(i) srcsuffix]);

    ret(isnan(ret)) = -1;
    t = (st(i):ed(i))';
    if i==2
        %ret2 = [t ret(:, 3:4)-5 ret(:, 5)]; % very old version, before writting MICCAI paper
        ret2 = [t (ret(:, 1)+ret(:, 3))/2+15 (ret(:, 2)+ret(:, 4))/2+15 ret(:, 5)];
    else
        ret2 = [t (ret(:, 1)+ret(:, 3))/2 (ret(:, 2)+ret(:, 4))/2 ret(:, 5)];
    end

    dlmwrite(['seq' num2str(i) dstsuffix], ret2);
    disp(['Write seq' num2str(i) dstsuffix])
end

end

% for i = 1:3
%     ret = dlmread(['seq' num2str(i) '_tld_mf.txt']);
% 
%     ret(isnan(ret)) = -1;
%     t = (st(i):ed(i))';
%     if i==2
%         ret2 = [t ret(:, 3)-10 ret(:, 4)-10 ret(:, 5)];
%     elseif i == 1
%         ret2 = [t (ret(:, 1)+ret(:, 3))/2 (ret(:, 2)+ret(:, 4))/2+10 ret(:, 5)];
%     elseif i == 3
%         ret2 = [t (ret(:, 1)+ret(:, 3))/2 (ret(:, 2)+ret(:, 4))/2+10 ret(:, 5)];
%     end
% 
%     dlmwrite(['seq' num2str(i) '_tld_test_mf.txt'], ret2);
% end

% for i = 1
%     ret = dlmread(['seq' num2str(i) '_tld_fast_dt.txt']);
% 
%     ret(isnan(ret)) = -1;
%     t = (st(i):ed(i))';
%     if i==2
%         %ret2 = [t ret(:, 3)-30 ret(:, 4)-30 ret(:, 5)];
%         ret2 = [t (ret(:, 1)+ret(:, 3))/2-8 (ret(:, 2)+ret(:, 4))/2-15 ret(:, 5)];
%     elseif i == 1
%         ret2 = [t (ret(:, 1)+ret(:, 3))/2-5 (ret(:, 2)+ret(:, 4))/2+15 ret(:, 5)];
%     elseif i == 3
%         ret2 = [t (ret(:, 1)+ret(:, 3))/2 (ret(:, 2)+ret(:, 4))/2+10 ret(:, 5)];
%     end
% 
%     dlmwrite(['seq' num2str(i) '_tld_test_fast_dt.txt'], ret2);
%     disp(['Write seq' num2str(i) '_tld_test_fast_dt.txt'])
% end

cd 'C:\Users\UTA\Research\Projects\Retinal Tracking\package\scripts'
mainMakeGraphs(dbid)

disp('Done');



