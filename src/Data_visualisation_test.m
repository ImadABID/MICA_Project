clc;
clear all;
close all;

Sig1 = load("../data/ecg_normal_1.mat");

% Adapting ECG polarisation
[maxi, max_index] = max(abs(Sig1.ecg));
if Sig1.ecg(max_index) < 0
    Sig1.ecg = -Sig1.ecg;
end

Sig2 = load("../data/ecg_VF.mat");

% Adapting ECG polarisation
[maxi, max_index] = max(abs(Sig2.ecg));
if Sig2.ecg(max_index) < 0
    Sig2.ecg = -Sig2.ecg;
end


N_fft = 1024;
window_duration = 4; %slength(x)-1
N = window_duration * Sig1.Fs;
d = floor(N/2);
window = hann(N);

%spectro(Sig1.ecg, window,d,N_fft,Sig1.Fs, "Noramal_1");
%spectro(Sig2.ecg, window,d,N_fft,Sig2.Fs, "VF");

%[P_locs, Q_locs, R_locs, S_locs, T_locs] = wave_detection_PQRST(Sig.ecg(1:1:1200),1/(Sig.Fs), 2);

%% bpm test
fprintf("cardiac_rhythm = %d bpm\n", cardiac_rhythm(Sig1));