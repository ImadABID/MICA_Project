clc;
clear all;
close all;

Sig = load("../data/ecg_AF.mat");
%Sig.ecg = Sig.ecg(1:1:1000);

%% artial_fibrillation test
af = atrial_fibrillation(Sig, 'plot');
if(af == 1)
    fprintf("The patient has an atrial fibrillation \n")
else
    fprintf("The patient hasn't an atrial fibrillation \n")
end