clc;
clear all;
close all;

Sig = load("../data/ecg_normal_1.mat");

% Adapting ECG polarisation
[maxi, max_index] = max(abs(Sig.ecg));
if Sig.ecg(max_index) < 0
    Sig.ecg = -Sig.ecg;
end


N_fft = 1024;
N = 100;
d = 60;
window = hann(N);

%spectro(Sig.ecg, window,d,N_fft,Sig.Fs);


[Q_locs, R_locs, S_locs] = wave_detection_QRS(Sig.ecg,1/(Sig.Fs), 2);
T_locs = wave_detection_T(Sig.ecg,[1 100 200 300 600 900]);

