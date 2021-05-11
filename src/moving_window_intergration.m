function sigI = moving_window_intergration(sig,rec_win_len)
    sigI = zeros(1, length(sig));
    for i= 1:1:length(sig)
        di = 0;
        while(i-di > 0 && di < rec_win_len)
            sigI(i) = sigI(i) + sig(i-di); 
            di = di + 1;
        end
        sigI(i) = sigI(i)/rec_win_len;
    end
end