function tld = expDetectFrame(tld, i)

I = tld.source.idx(i); % get current index
tld.img{I} = img_get(tld.source,I); % grab frame from camera / load image

% DETECTOR ----------------------------------------------------------------

[dBB dConf tld] = tldDetection(tld,I); % detect appearances by cascaded detector (variance filter -> ensemble classifier -> nearest neightbour)

DT = 1; if isempty(dBB), DT = 0; end % is detector defined?

if DT % and detector is defined
    dConf
    fprintf('detect succ\n');    
    [cBB,cConf,cSize] = bb_cluster_confidence(dBB,dConf); % cluster detections

    if length(cConf) == 1 % and if there is just a single cluster, re-initalize the tracker
        tld.bb(:,I)  = cBB;
        tld.conf(I)  = cConf;
        tld.size(I)  = cSize;
        tld.valid(I) = 0; 
    end
else
    % for debug ----------------
    dConf
    fprintf('detect fail\n');
    % --------------------------
end

% LEARNING ----------------------------------------------------------------

if tld.control.update_detector && tld.valid(I) == 1
    tld = tldLearning(tld,I);
end

% display drawing: get center of bounding box and save it to a drawn line
if ~isnan(tld.bb(1,I))
    tld.draw(:,end+1) = bb_center(tld.bb(:,I));
    if tld.plot.draw == 0, tld.draw(:,end) = nan; end
else
    tld.draw = zeros(2,0);
end

if tld.control.drop_img && I > 2, tld.img{I-1} = {}; end % forget previous image