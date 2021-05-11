function S_locations = wave_detection_S(sig, R_locations)
    S_locations = zeros(1, length(R_locations));
    for i = 1:1:length(R_locations)
        is = R_locations(i) + 1;
        while(is < length(sig) && sig(is) < sig(is+1))
            is = is + 1;
        end
        S_locations(i) = is;
    end
end