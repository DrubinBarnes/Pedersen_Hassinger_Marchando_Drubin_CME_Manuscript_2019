function goodTrackData = calculateTwoColorStats(goodTrackData, spf)


for ii = 1:length(goodTrackData)
    
    % indices of start and end of traces
    aa = goodTrackData(ii).ref_tp_first - goodTrackData(ii).tp_prev_all + 1;
    bb = goodTrackData(ii).ref_tp_last - goodTrackData(ii).tp_prev_all + 1;
    cc = goodTrackData(ii).cor_tp_first - goodTrackData(ii).tp_prev_all + 1;
    dd = goodTrackData(ii).ref_tp_last - goodTrackData(ii).tp_prev_all + 1;
    
    % trace lifetimes
    goodTrackData(ii).ref_lifetime = ...
        spf*(goodTrackData(ii).ref_tp_last - goodTrackData(ii).ref_tp_first + 1);
    goodTrackData(ii).cor_lifetime = ...
        spf*(goodTrackData(ii).cor_tp_last - goodTrackData(ii).cor_tp_first + 1);
    
    % identify peak of smoothed traces
    [~, jj] = max(goodTrackData(ii).cor_intensity_bg_corrected);
    [~, kk] = max(goodTrackData(ii).ref_intensity_bg_corrected);
    goodTrackData(ii).cor_peak = goodTrackData(ii).tp_prev_all + jj - 1;
    goodTrackData(ii).ref_peak = goodTrackData(ii).tp_prev_all + kk - 1;
    
    % time from start to peak intensities
    goodTrackData(ii).cor_time_2_peak = ...
        spf*((goodTrackData(ii).tp_prev_all + jj) - goodTrackData(ii).cor_tp_first);
    goodTrackData(ii).ref_time_2_peak = ...
        spf*((goodTrackData(ii).tp_prev_all + kk) - goodTrackData(ii).ref_tp_first);
    
    % time from start of one trace to peak of another
    goodTrackData(ii).ref_time_2_cor_peak = ...
        spf*((goodTrackData(ii).tp_prev_all + jj) - goodTrackData(ii).ref_tp_first);
    goodTrackData(ii).cor_time_2_ref_peak = ...
        spf*((goodTrackData(ii).tp_prev_all + kk) - goodTrackData(ii).cor_tp_first);
    
    % maximum intensities
    goodTrackData(ii).max_cor = max(goodTrackData(ii).cor_intensity_bg_corrected(cc:dd));
    goodTrackData(ii).max_ref = max(goodTrackData(ii).ref_intensity_bg_corrected(aa:bb));
    
    % minimum intensities
    goodTrackData(ii).min_cor = min(goodTrackData(ii).cor_intensity_bg_corrected(cc:dd));
    goodTrackData(ii).min_ref = min(goodTrackData(ii).ref_intensity_bg_corrected(aa:bb));
    
    % mean intensities
    goodTrackData(ii).mean_cor = mean(goodTrackData(ii).cor_intensity_bg_corrected(cc:dd));
    goodTrackData(ii).mean_ref = mean(goodTrackData(ii).ref_intensity_bg_corrected(aa:bb));
    
    % slopes
    goodTrackData(ii).slope_cor = gradient(goodTrackData(ii).cor_intensity_bg_corrected);
    goodTrackData(ii).slope_ref = gradient(goodTrackData(ii).ref_intensity_bg_corrected);
    
    % max slopes
    goodTrackData(ii).max_slope_cor = max(goodTrackData(ii).slope_cor(cc:dd));
    goodTrackData(ii).max_slope_ref = max(goodTrackData(ii).slope_ref(aa:bb));
    
    % full width half max
    xx = find(goodTrackData(ii).ref_intensity_bg_corrected(aa:bb)>=0.5*goodTrackData(ii).max_ref,1);
    yy = find(goodTrackData(ii).ref_intensity_bg_corrected(aa:bb)>=0.5*goodTrackData(ii).max_ref,1,'last');
    ww = find(goodTrackData(ii).cor_intensity_bg_corrected(aa:bb)>=0.5*goodTrackData(ii).max_cor,1);
    zz = find(goodTrackData(ii).cor_intensity_bg_corrected(aa:bb)>=0.5*goodTrackData(ii).max_cor,1,'last');
    goodTrackData(ii).ref_fwhm = spf*(yy - xx + 1);
    goodTrackData(ii).cor_fwhm = spf*(zz - ww + 1);

    % relative arrival and disappearance 
    goodTrackData(ii).rel_arrival = ...
        spf*(goodTrackData(ii).cor_tp_first - goodTrackData(ii).ref_tp_first);
    goodTrackData(ii).rel_end = ...
        spf*(goodTrackData(ii).cor_tp_last - goodTrackData(ii).ref_tp_last);
    
end

