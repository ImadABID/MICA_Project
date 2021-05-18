Sig = load("../data/ecg_normal_1.mat");

N_fft = 1024;
N = 100;
d = 10;
window = hann(N);

spectro(Sig.ecg, window,d,N_fft,Sig.Fs);