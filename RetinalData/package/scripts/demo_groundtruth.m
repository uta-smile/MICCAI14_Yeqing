function demo_groundtruth()
close all;

idx = 3;
img_dir = fullfile('..', '..', 'separate', ['seq' num2str(idx)]);
gt_file = fullfile('..', '..', 'package', 'annotation_source', ['test' num2str(idx) '.txt']);
% img_dir = ['C:\Users\UTA\Research\Projects\Retinal Tracking\separate\seq' num2str(idx)];
% gt_file = ['C:\Users\UTA\Research\Projects\Retinal Tracking\package\annotation_source\test' num2str(idx) '.txt'];
% img_dir = ['C:\Users\UTA\Research\Projects\Retinal Tracking\separate\seq4'];
% gt_file = ['C:\Users\UTA\Research\Projects\Retinal Tracking\package\annotation_source\lapatool1.txt'];

ddvt_dir = fullfile('..', '..', 'package', 'results');
ddvt_ret = fullfile(ddvt_dir, ['exp_test' num2str(idx) '.txt']);

tld_dir = fullfile('..', '..', 'separate');
tld_ret = fullfile(tld_dir, ['seq' num2str(idx) '_tld_test_best.txt']);

ddvt = dlmread(ddvt_ret);
tld = dlmread(tld_ret);
truth = dlmread(gt_file);

pts = [truth(:, [5 4])];

figure(2); set(2,'KeyPressFcn', @handleKey); % open figure for display of results
finish = 0; function handleKey(~,~), finish = 1; end % by pressing any key, the process will exit


bwrite = false;

if bwrite
writerObj = VideoWriter(['result' num2str(idx) '.avi']);
writerObj.FrameRate = 10;
open(writerObj);
end

files = dir([img_dir '\*.png']);
w = 20;
j = 1; k = 1;
for i = 1:length(files)
    filepath = fullfile(img_dir, files(i).name);
    frame = (str2double(files(i).name(1:end-4)));
    im = imread(filepath);
    clf; imshow(im, 'Border','tight');
    [height, width, ~] = size(im);
    
    while truth(i, 1) < frame 
        i=i+1;
    end
    
    while j <= size(ddvt, 1) && ddvt(j, 1) < frame
        j=j+1;
    end
    
    while tld(k, 1) < frame 
        k=k+1;
    end
    
    if (frame == truth(i, 1))
        rect = [pts(i, :) - w - 10, 2*w, 2*w];
        %rectangle('Position', rect, 'EdgeColor', 'g');
        hold on; plot(pts(i, 1), pts(i, 2), 'rx', 'MarkerSize', 12, 'LineWidth',2);
        %text(pts(i, 1)+10, pts(i, 2)+10, 'Ground truth', 'Color', 'r')
        text(width-140, 10, 'Ground truth', 'Color', 'r', ...
            'FontWeight', 'bold', 'FontSize', 12)
    end
    
%     if j < size(ddvt, 1) && (frame == ddvt(j, 1))
%         hold on; plot(ddvt(j, 2), ddvt(j, 3), 'yo', 'MarkerSize', 12, 'LineWidth',2);
%         %text(ddvt(j, 2)+10, ddvt(j, 3)+10, 'DDVT', 'Color', 'y')
%         text(width-140, 30, 'DDVT', 'Color', 'y', ...
%             'FontWeight', 'bold', 'FontSize', 12)
%     end
    
    if (frame == tld(k, 1))
        hold on; plot(tld(k, 2), tld(k, 3), 'gs', 'MarkerSize', 12, 'LineWidth',2);
        %text(tld(k, 2)+10, tld(k, 3)+10, 'TLD', 'Color', 'g')
        text(width-140, 50, 'Proposed', 'Color', 'g', ...
            'FontWeight', 'bold', 'FontSize', 12)
    end
    
    text(15, 30, ['Frame: ' num2str(frame)], 'Color', 'g', ...
            'FontWeight', 'bold', 'FontSize', 12)
    
    drawnow;
    
    if bwrite
    frame = getframe(gcf);
    writeVideo(writerObj,frame);
    end
    
    if (finish) % finish if any key was pressed
        return;
    end
end

if bwrite
close(writerObj);
end
close all

end