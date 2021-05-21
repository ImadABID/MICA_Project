clc;
clear all;
close all;

Sig = load("../data/ecg_normal_1.mat");
%Sig_2 = load("../data/ecg_VF.mat");

% Adapting ECG polarisation
[maxi, max_index] = max(abs(Sig.ecg));
if Sig.ecg(max_index) < 0
    Sig.ecg = -Sig.ecg;
end


N_fft = 1024;
N = 100;
d = 60;
window = hann(N);

spectro(Sig.ecg, window,d,N_fft,Sig.Fs);
%spectro(Sig_2.ecg, window,d,N_fft,Sig_2.Fs);


[P_locs, Q_locs, R_locs, S_locs, T_locs] = wave_detection_PQRST(Sig.ecg(1:1:1200),1/(Sig.Fs), 4);

[R_duration,R_diff] = eptopic_beat(R_locs);