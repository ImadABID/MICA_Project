clc;
clear all;
close all;

Sig = load("../data/ecg_normal_1.mat");

[P_locations, Q_locations, R_locations, S_locations, T_locations] = wave_detection_PQRST(Sig.ecg(1:1:1000),1/Sig.Fs, 2, 'plot');