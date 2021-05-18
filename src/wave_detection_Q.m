function Q_locations = wave_detection_Q(sig, R_locations)
    Q_locations = zeros(1, length(R_locations));
    for i = 1:1:length(R_locations)
        iq = R_locations(i) -1;
        while(iq >= 1 && sig(iq-1) < sig(iq))
            iq = iq - 1;
        end
        Q_locations(i) = iq;
    end
end