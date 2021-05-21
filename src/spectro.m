function [Sx, f, t] = spectro(x,w,d,N_fft,Fs, fig_name)
    % This function computes the spectrogram for m = [0, d, 2d, 3d...]
    % This function outputs are:
    % -> Sx, which is a matrix of n_fft lines and
    % M (number of elements of m) columns
    % Sx(i,j) is the value of the spectrogram for time t(i) and frequency f(j)
    % -> f, is a column vector of the frequencies (in Hz)
    % -> t, is a row vector containing the times of the beginning of the windows
    
    [X, f, t] = stft(x,w,d,N_fft,Fs);
    Sx = abs(X) .^ 2;
    
    figure('Name', fig_name)
    imagesc(t, f, 10*log(Sx))
    colorbar
    title("Spectrogram")
    xlabel("time (s)")
    ylabel("frequence (Hz)")
end