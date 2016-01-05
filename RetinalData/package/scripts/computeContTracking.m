function vec = computeContTracking(List)

    vec = zeros(1,1000);
    cnt = 0;
    for ix = 2:length(List)
        
        if List(ix) == 0
            cnt = cnt + 1;
        else
            vec(cnt+1) = vec(cnt+1) + 1;
            cnt = 0;
        end
        
    end

end