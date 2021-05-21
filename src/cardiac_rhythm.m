function bpm = cardiac_rhythm(Sig)
    [P, Q, R, S, T] = wave_detection_PQRST(Sig.ecg, 1/(Sig.Fs), 2, 'no plot');
    delta_R = zeros(1, length(R)-1);
    for i=1:1:length(R)-1
        delta_R(i) = R(i+1) - R(i);
    end
    
    delta_R_moy_min = mean(delta_R) * 1/(Sig.Fs) * 1/60;
    bpm = 1/delta_R_moy_min;
end

