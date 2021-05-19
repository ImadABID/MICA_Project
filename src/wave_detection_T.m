function T_locations = wave_detection_T(ECG, R_locations)
    
    ECG_G1 = filter([1 0 0 0 0 0 -1],[1],ECG);
    
    G1_delay = 3;
    
    ECG_G1(G1_delay:1:length(ECG_G1));
    
    ECG_G2 = filter([1 0 0 0 0 0 0 0 -1],[1 -1],ECG_G1);
    
    G2_delay = 4;
    
   
    
    ECG_G2 = ECG_G2(G2_delay:1:length(ECG_G2));
    
   
    
    
    zero_loc = [];
    
    T_locations= [];
    
    for i = 1:1:(length(R_locations)-1)
        
        lim = floor((R_locations(i+1) - R_locations(i))*0.7);
        
        
        
        for j= R_locations(i):1:lim
            
            if ( ECG_G2(j) == 0)
                
                zero_loc = [zero_loc,j];
            end
            
            
            [maxx , T]= max(ECG(zero_loc));
            T_locations = [T_locations,T];
        end
    end
    
    
    
            
    
    
    
    
    
    
    figure,
    subplot(3,1,1);
    plot(ECG(1:1000));
    subplot(3,1,2);
    plot(ECG_G1(1:1000));
    subplot(3,1,3);
    plot(ECG_G2(1:1000));
    
    
    
    
    
    





    














%     T_locations = zeros(1, length(R_locations) - 1);
%     P_locations = zeros(1, length(R_locations) - 1);
%     for i = 1:1:length(R_locations)-1
%         ir1 = R_locations(i);
%         ir2 = R_locations(i+1);
%         ir0_7 = ir1 + floor(0.7*(ir2-ir1));
%         Picks_values = [];
%         Picks_index = [];
%         for j = ir1:1:ir0_7
%             if(sig(j) < sig(j+1) && sig(j+1) > sig(j+2))
%                Picks_values = [Picks_values, sig(j+1)];
%                Picks_index = [Picks_index, j+1];
%             end
%         end
%         [Pick_max, Pick_max_index_in_pick_list] = max(Picks_values);
%         T_locations(i) = Picks_index(Pick_max_index_in_pick_list);
%     end

end