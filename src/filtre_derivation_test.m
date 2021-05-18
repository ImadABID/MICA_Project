clc;
clear all;
close all;

Sig = load("../data/ecg_normal_1.mat");

Sig.ecg = -Sig.ecg;

obs_len = 2000;
figure,
subplot(2,1,1)
plot([Sig.ecg(1:1:obs_len)])
title("ecg")
subplot(2,1,2)
plot(filtre_de_derivation(Sig.ecg(1:1:obs_len)))
title("derivated ecg")