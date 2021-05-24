function ecg_out = Adapting_ECG_polarisation(ecg_in)
    [maxi, max_index] = max(abs(ecg_in));
    if ecg_in(max_index) < 0
        ecg_out = -ecg_in;
    else
        ecg_out = ecg_in;
    end
end

