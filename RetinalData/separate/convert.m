function convert(dbid)
% 
% Convert the TLD format of bounding box to DDVT format and then plot the
% results.
% 

st = [224 1319 1551 1575 1575 1194];
ed = [625 1540 2097 2174 2174 2174];

if ~exist('dbid', 'var'),
    dbid = 1;
end


for thres = 0.5:0.05:0.65

    if dbid == 4,
        %srcsuffix = '_tld_fast_dt.txt';
        %dstsuffix = '_tld_test_fast_dt.txt';
        %srcsuffix = '_tld_origin.txt';
        %dstsuffix = '_tld_test_origin.txt';
        error('Do not covert 5');
        srcsuffix = '_tld.txt';
        dstsuffix = '_tld_test_ct.txt';
    elseif dbid == 5,
        error('Do not covert 4');
        srcsuffix = '_tld.txt';
        dstsuffix = '_tld_test.txt';
    else
        srcsuffix = sprintf('_tld_fast_dt_conf%.2f.txt', thres);
        dstsuffix = sprintf('_tld_test_fast_dt_conf%.2f.txt', thres);
    end

    

    curdir = cd;

    for i = dbid
        srcfn = ['seq' num2str(i) srcsuffix];
        ret = dlmread(srcfn);
        disp(srcfn);

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

%***** Make plots
% cd 'C:\Users\UTA\Research\Projects\Retinal Tracking\package\scripts'
cd(fullfile('..', 'package', 'scripts'));
mainMakeGraphs(dbid)

%***** Go back to script dir.
disp(curdir)
cd(curdir)

disp('Done');



