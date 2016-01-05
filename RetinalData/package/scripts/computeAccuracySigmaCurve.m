function [ Acc Thr HIST dist] = computeAccuracySigmaCurve( res_file, true_file,ST,ND )


    Annot       = load(res_file); % frame index, Coord=2:3, 
    
    Truth       = load(true_file);
    
    %sel    = Truth(:,1)>=ST & Truth(:,1)<=ND;
    %Truth  = Truth(sel,:);

    if ST ~= -1
        st = ST;
        nd = ND;
    else
        st = 1;
        nd = size(Annot,1);
    end

    
    Cnt = 1;
    
    for ix = st:nd
            
            %fprintf('%d - %d \n',ix,nd);

            Coord       = round(Annot(ix,2:end-1));
            truth_index = Truth(:,1) == Annot(ix,1) ;
            truth_row   = Truth(truth_index,4:5);
            
            GT    = circshift(truth_row',1)';

            dist(Cnt) =  sqrt( sum( (Coord - GT).^2));
            if (GT(1) == -1 || Coord(1) == -1)
                dist(Cnt) = 0;
            end
            Cnt  = Cnt + 1;
    end
    
    index = 1;
    for sig = 15:5:40

        sel = find( dist < sig );

        Acc(index) = length(sel) / Cnt;
        Thr(index) = sig;
        index      = index + 1;
        
    end
    
    
    % Compute Histogram
    
    index = 1;
    for sig = 15:5:40
        
        VEC = zeros(1,1000);
        off_ix = 1;
        
        run_cnt = 0;
        off_cnt = 0;
        total = 0;
        for ix = 1:length(dist)
            if(dist(ix) < sig)
                run_cnt = run_cnt + 1;
                if(off_cnt ~=0)
                    OFF(off_ix) = off_cnt;
                    off_ix = off_ix + 1;
                    off_cnt = 0;
                end
            else
                VEC(run_cnt+1) = VEC(run_cnt+1) + 1;
                run_cnt = 0;
                off_cnt = off_cnt + 1;
                total = total + run_cnt;
            end
        end

%         mean(OFF)
        HIST{index} = VEC;
        index       = index + 1;
        
    end
    

end


