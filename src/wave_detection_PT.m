function [T_locations, P_locations] = wave_detection_PT(ECG, R_locations)

    %% filtring
    ECG_G1 = filter([1 0 0 0 0 0 -1],[1],ECG);
    
    G1_delay = 3;
    ECG_G1(G1_delay:1:length(ECG_G1));
    
    ECG_G2 = filter([1 0 0 0 0 0 0 0 -1],[1 -1],ECG_G1);
    
    G2_delay = 4;
    ECG_G2 = ECG_G2(G2_delay:1:length(ECG_G2));
    
   
    
    %% T Detection
    T_locations= [];

    for i = 1:1:(length(R_locations)-1)
        zero_loc = [];
        lim = floor((R_locations(i+1) - R_locations(i))*0.7);
        
        for j= R_locations(i):1:R_locations(i) + lim
            
            if ( ECG_G2(j-1)*ECG_G2(j) <= 0)
                zero_loc = [zero_loc, j-1];
            end
        end
        [maxx , T]= max(ECG(zero_loc));
        T_locations = [T_locations, zero_loc(T)];
    end
    T_locations = T_locations -2 ;
    
    %% P Detection
    P_locations = []
    for i = 1:1:(length(R_locations)-2)
        zero_loc = [];
        lim = floor((R_locations(i+1) - R_locations(i))*0.7);
        
        for j= R_locations(i)+lim:1:R_locations(i+1)
            
            if ( ECG_G2(j-1)*ECG_G2(j) <= 0)
                zero_loc = [zero_loc, j-1];
            end
        end
        [maxx , P]= max(ECG(zero_loc));
        P_locations = [P_locations, zero_loc(P)];
    end
    P_locations = P_locations -2;
    
    figure,
    
    subplot(3,1,1);
    plot(ECG);
    hold on
    plot(T_locations, ECG(T_locations), '.')
    hold on
    plot(P_locations, ECG_G1(P_locations), '.')
    
    subplot(3,1,2);
    plot(ECG_G1)
    hold on
    plot(T_locations, ECG_G1(T_locations), '.')
    hold on
    plot(P_locations, ECG_G1(P_locations), '.')
    
    subplot(3,1,3);
    plot(ECG_G2)
    hold on
    plot(T_locations, ECG_G2(T_locations), '.')
    hold on
    plot(P_locations, ECG_G1(P_locations), '.')
    
end