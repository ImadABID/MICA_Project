function dec = delay_between_2_sigs(sig_retarde,sig_org)
    correlation = xcorr(sig_retarde, sig_org);
    [Max, I] = max(correlation);
    dec = abs(I-length(sig_retarde));
end