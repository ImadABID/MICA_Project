clc;
clear all;
close all;

Sig1 = load("../data/ecg_VF.mat");

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


spectro(Sig1.ecg, window,d,N_fft,Sig1.Fs, "Normal_1");
spectro(Sig2.ecg, window,d,N_fft,Sig2.Fs, "VF");

[P_locs, Q_locs, R_locs, S_locs, T_locs] = wave_detection_PQRST(Sig2.ecg(1:1:2000),1/(Sig2.Fs), 2,'no plot');

%% ecptopic beat test
is_ectopic_beat = ectopic_beat(Sig1);
if(is_ectopic_beat == 1)
    fprintf("The patient has an ectopic beat \n")
else
    fprintf("The patient does not have  an ectopic beat \n")
end


%fprintf("max eptopic value  = %d \n", max(delta_R_2));


%% bpm test
fprintf("cardiac_rhythm = %d bpm\n", cardiac_rhythm(Sig1));

%% artial_fibrillation test
af = atrial_fibrillation(Sig1, 'no plot');
if(af == 1)
    fprintf("The patient has an atrial fibrillation \n")
else
    fprintf("The patient hasn't an atrial fibrillation \n")
end

is_ventricular_fibrillation =  ventricular_fibrillation(Sig1);

if(is_ventricular_fibrillation == 1)
    fprintf("The patient has a ventricular fibrillation  \n")
else
    fprintf("The patient does not have a ventricular fibrillation \n")
end


