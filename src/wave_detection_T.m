function T_locations = wave_detection_T(sig, R_locations)
    T_locations = zeros(1, length(R_locations) - 1);
    P_locations = zeros(1, length(R_locations) - 1);
    
    for i = 1:1:length(R_locations)-1
        ir1 = R_locations(i);
        ir2 = R_locations(i+1);
        ir0_7 = ir1 + floor(0.7*(ir2-ir1));
        Picks_values = [];
        Picks_index = [];
        for j = ir1:1:ir0_7
            if(sig(j) < sig(j+1) && sig(j+1) > sig(j+2))
               Picks_values = [Picks_values, sig(j+1)];
               Picks_index = [Picks_index, j+1];
            end
        end
        [Pick_max, Pick_max_index_in_pick_list] = max(Picks_values);
        T_locations(i) = Picks_index(Pick_max_index_in_pick_list);
    end
end