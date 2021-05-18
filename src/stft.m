function [X, f, t] = stft(x,w,d,N_fft,Fs)
% This function computes the stft for m = [0, d, 2d, 3d...]
% This function outputs are:
% -> X, which is a matrix of n_fft lines and M columns
% M is the number of elements of m
% X(i,j) is the value of the spectrogram for time t(i) and frequency f(j)
% -> f, is a column vector of the frequencies (in Hz)
% -> t, is a row vector containing the times of the beginning of the windows

    N = length(w);
    nbr_frames = floor(length(x) / d) + 1;
    
    %adapting x
    ideal_length_of_x = (nbr_frames-1)*d + N;
    if(length(x) ~= ideal_length_of_x)
        x = [x, zeros(1, ideal_length_of_x-length(x))];
    end
    
    %framing
    x_frame = zeros(N, nbr_frames);
    for i = 1:1:nbr_frames
        x_frame(:,i)= transpose(x((i-1)*d+1:1:(i-1)*d+N));
    end
    
    %Multipalying by the window
    for i=1:1:nbr_frames
        x_frame(:,i) = x_frame(:,i) .* w;
    end
    
    %Result
    X = fft(x_frame, N_fft);
    f = 0:Fs/N_fft:Fs-Fs/N_fft;
    t = 0:1/Fs:(length(x)-1)*1/Fs;
end